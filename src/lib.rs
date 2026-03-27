pub mod config;
pub mod demos;

use std::collections::VecDeque;

use config::{PVM_BINARY, label_addr};
use cor24_emulator::EmulatorCore;
use demos::{DEMOS, RUNTIME_SPC};
use gloo::timers::callback::Timeout;
use web_sys::{HtmlElement, HtmlInputElement, HtmlSelectElement};
use yew::prelude::*;

const BATCH_SIZE: u64 = 50_000;
const TICK_MS: u32 = 25;

fn pcode_instr_size(op: u8) -> usize {
    match op {
        0x01 | 0x30 | 0x31 | 0x32 | 0x33 | 0x54 | 0x55 | 0x56 => 4,
        0x02 | 0x34 | 0x35 | 0x36 | 0x40 | 0x42 | 0x43 | 0x44 | 0x45 | 0x57 | 0x60 => 2,
        0x58 | 0x59 => 3,
        0x5A => 5,
        _ => 1,
    }
}

#[derive(Clone, Copy, PartialEq)]
enum AppStatus {
    Ready,
    Running,
    Exited,
}

pub enum Msg {
    SelectDemo(usize),
    LinkAndRun,
    Stop,
    Tick,
    ToggleSwitch,
    UpdateInput(String),
    SendInput,
    InputKeyDown(KeyboardEvent),
}

pub struct App {
    selected: usize,
    status: AppStatus,
    emulator: EmulatorCore,
    output: String,
    running: bool,
    halted: bool,
    instruction_count: u64,
    binary_size: usize,
    led_on: bool,
    switch_on: bool,
    uart_input: String,
    uart_rx_queue: VecDeque<u8>,
    _tick_handle: Option<Timeout>,
    output_ref: NodeRef,
    pending_code_base: Option<u32>,
    vm_state_addr: u32,
    vm_loop_addr: u32,
    code_seg_addr: u32,
}

impl App {
    fn load_vm_binary(&mut self) {
        self.emulator = EmulatorCore::new();
        for (i, &b) in PVM_BINARY.iter().enumerate() {
            self.emulator.write_byte(i as u32, b);
        }
    }

    fn load_p24_image(&mut self, image: &pa24r::LoadedImage) {
        let load_addr = 0x010000_u32;
        let code_size = image.code.len() as u32;
        let total = code_size + image.data.len() as u32;

        // Relocate data references: push IMM24 operands in [code_size, total)
        // get load_addr added to become absolute addresses.
        let mut code = image.code.clone();
        let mut i = 0usize;
        while i < code.len() {
            let op = code[i];
            let size = pcode_instr_size(op);
            if op == 0x01 && i + 4 <= code.len() {
                let val = u32::from(code[i + 1])
                    | (u32::from(code[i + 2]) << 8)
                    | (u32::from(code[i + 3]) << 16);
                if val >= code_size && val < total {
                    let abs = val + load_addr;
                    code[i + 1] = abs as u8;
                    code[i + 2] = (abs >> 8) as u8;
                    code[i + 3] = (abs >> 16) as u8;
                }
            }
            i += size;
        }

        // Write relocated code + data contiguously at load_addr
        for (i, &b) in code.iter().chain(image.data.iter()).enumerate() {
            self.emulator.write_byte(load_addr + i as u32, b);
        }

        self.binary_size = total as usize;
        self.pending_code_base = Some(load_addr);
    }

    fn apply_pending_code_base(&mut self) {
        if let Some(load_addr) = self.pending_code_base.take() {
            // Write "sys halt" at code_seg to stop pvm.s after init
            self.emulator.write_byte(self.code_seg_addr, 0x60);
            self.emulator.write_byte(self.code_seg_addr + 1, 0x00);

            // Run pvm.s init (boots, prints banner)
            self.emulator.resume();
            self.emulator.run_batch(10_000);

            // Discard boot output
            self.emulator.clear_uart_output();
            self.output.clear();

            // Soft reset preserving memory
            self.emulator.reset();
            self.emulator.set_uart_tx_busy_cycles(0);

            // Jump to vm_loop, skip pvm.s init
            self.emulator.set_pc(self.vm_loop_addr);
            self.emulator.set_reg(3, self.vm_state_addr); // fp

            // Patch vm_state for loaded demo
            let base = self.vm_state_addr;
            // code_base = load_addr
            self.emulator.write_byte(base + 18, load_addr as u8);
            self.emulator.write_byte(base + 19, (load_addr >> 8) as u8);
            self.emulator.write_byte(base + 20, (load_addr >> 16) as u8);
            // pc = 0
            self.emulator.write_byte(base, 0);
            self.emulator.write_byte(base + 1, 0);
            self.emulator.write_byte(base + 2, 0);
            // status = 0 (running)
            self.emulator.write_byte(base + 21, 0);
            self.emulator.write_byte(base + 22, 0);
            self.emulator.write_byte(base + 23, 0);
        }
    }

    fn collect_uart(&mut self) {
        let uart = self.emulator.get_uart_output().to_owned();
        if !uart.is_empty() {
            self.output.push_str(&uart);
            self.emulator.clear_uart_output();
        }
    }

    fn feed_uart_bytes(&mut self) {
        while !self.uart_rx_queue.is_empty() {
            let status = self.emulator.read_byte(0xFF0101);
            if status & 0x01 != 0 {
                break;
            }
            if let Some(byte) = self.uart_rx_queue.pop_front() {
                self.emulator.send_uart_byte(byte);
            }
        }
    }

    fn schedule_tick(&mut self, ctx: &Context<Self>) {
        let link = ctx.link().clone();
        self._tick_handle = Some(Timeout::new(TICK_MS, move || {
            link.send_message(Msg::Tick);
        }));
    }

    fn check_halted(&mut self, reason: cor24_emulator::StopReason) {
        match reason {
            cor24_emulator::StopReason::Halted
            | cor24_emulator::StopReason::InvalidInstruction(_) => {
                self.halted = true;
                self.running = false;
                self._tick_handle = None;
                self.status = AppStatus::Exited;
            }
            _ => {}
        }
        // Also check p-code vm_state STATUS field
        let st = self.emulator.read_byte(self.vm_state_addr + 21) as u32
            | ((self.emulator.read_byte(self.vm_state_addr + 22) as u32) << 8)
            | ((self.emulator.read_byte(self.vm_state_addr + 23) as u32) << 16);
        if st != 0 {
            self.halted = true;
            self.running = false;
            self._tick_handle = None;
            self.status = AppStatus::Exited;
        }
    }

    fn link_and_assemble(&mut self) -> Result<pa24r::LoadedImage, String> {
        let demo = &DEMOS[self.selected];

        // Parse runtime and demo .spc modules
        let rt_module = pl24r::parser::parse(RUNTIME_SPC, "runtime.spc")
            .map_err(|e| format!("Parse runtime: {e}"))?;
        let demo_module = pl24r::parser::parse(demo.spc_source, "demo.spc")
            .map_err(|e| format!("Parse demo: {e}"))?;

        // Link: runtime first, then demo (which contains main)
        let linked = pl24r::linker::link(&[rt_module, demo_module]).map_err(|errs| {
            errs.iter()
                .map(|e| e.to_string())
                .collect::<Vec<_>>()
                .join("; ")
        })?;
        let spc_text = pl24r::linker::emit(&linked);

        // Assemble linked .spc to .p24 binary
        let p24_bytes = pa24r::assemble_to_p24(&spc_text).map_err(|errs| {
            errs.iter()
                .map(|e| format!("line {}: {}", e.line, e.message))
                .collect::<Vec<_>>()
                .join("; ")
        })?;

        // Load .p24 binary
        pa24r::load_p24(&p24_bytes).map_err(|e| format!("Load p24: {e:?}"))
    }
}

impl Component for App {
    type Message = Msg;
    type Properties = ();

    fn create(_ctx: &Context<Self>) -> Self {
        let mut emulator = EmulatorCore::new();
        for (i, &b) in PVM_BINARY.iter().enumerate() {
            emulator.write_byte(i as u32, b);
        }

        Self {
            selected: 0,
            status: AppStatus::Ready,
            emulator,
            output: String::new(),
            running: false,
            halted: false,
            instruction_count: 0,
            binary_size: 0,
            led_on: false,
            switch_on: false,
            uart_input: String::new(),
            uart_rx_queue: VecDeque::new(),
            _tick_handle: None,
            output_ref: NodeRef::default(),
            pending_code_base: None,
            vm_state_addr: label_addr("vm_state"),
            vm_loop_addr: label_addr("vm_loop"),
            code_seg_addr: label_addr("code_seg"),
        }
    }

    fn update(&mut self, ctx: &Context<Self>, msg: Self::Message) -> bool {
        match msg {
            Msg::SelectDemo(idx) => {
                if idx < DEMOS.len() {
                    self.selected = idx;
                    // Stop any running execution
                    self.running = false;
                    self.halted = false;
                    self._tick_handle = None;
                    self.output.clear();
                    self.instruction_count = 0;
                    self.binary_size = 0;
                    self.status = AppStatus::Ready;
                    self.pending_code_base = None;
                }
                true
            }

            Msg::LinkAndRun => {
                // Reset state
                self.running = false;
                self._tick_handle = None;
                self.uart_rx_queue.clear();
                self.output.clear();
                self.instruction_count = 0;
                self.halted = false;
                self.led_on = false;

                // Reload VM binary
                self.load_vm_binary();

                // Link and assemble
                match self.link_and_assemble() {
                    Ok(image) => {
                        self.load_p24_image(&image);

                        // Apply and start running
                        self.apply_pending_code_base();
                        self.running = true;
                        self.status = AppStatus::Running;
                        self.emulator.resume();
                        self.schedule_tick(ctx);
                    }
                    Err(e) => {
                        self.output = format!("Error: {e}");
                        self.status = AppStatus::Exited;
                    }
                }
                true
            }

            Msg::Stop => {
                self.running = false;
                self._tick_handle = None;
                self.emulator.pause();
                self.status = AppStatus::Exited;
                true
            }

            Msg::Tick => {
                if !self.running || self.halted {
                    return false;
                }

                self.feed_uart_bytes();
                let result = self.emulator.run_batch(BATCH_SIZE);
                self.instruction_count += result.instructions_run;
                self.collect_uart();

                // Check LED state
                let led_byte = self.emulator.read_byte(0xFF0200);
                self.led_on = led_byte != 0;

                self.check_halted(result.reason);

                if self.running && !self.halted {
                    self.schedule_tick(ctx);
                }
                true
            }

            Msg::ToggleSwitch => {
                self.switch_on = !self.switch_on;
                self.emulator.set_button_pressed(self.switch_on);
                true
            }

            Msg::UpdateInput(val) => {
                self.uart_input = val;
                false
            }

            Msg::SendInput => {
                let text = std::mem::take(&mut self.uart_input);
                for b in text.bytes() {
                    self.uart_rx_queue.push_back(b);
                }
                self.uart_rx_queue.push_back(b'\n');
                true
            }

            Msg::InputKeyDown(e) => {
                if e.key() == "Enter" {
                    ctx.link().send_message(Msg::SendInput);
                }
                false
            }
        }
    }

    fn rendered(&mut self, _ctx: &Context<Self>, _first_render: bool) {
        if let Some(el) = self.output_ref.cast::<HtmlElement>() {
            el.set_scroll_top(el.scroll_height());
        }
    }

    fn view(&self, ctx: &Context<Self>) -> Html {
        let link = ctx.link();
        let demo = &DEMOS[self.selected];

        let on_select = link.callback(|e: Event| {
            let target: HtmlSelectElement = e.target_unchecked_into();
            Msg::SelectDemo(target.value().parse::<usize>().unwrap_or(0))
        });

        let on_input = link.callback(|e: InputEvent| {
            let target: HtmlInputElement = e.target_unchecked_into();
            Msg::UpdateInput(target.value())
        });

        let on_keydown = link.callback(Msg::InputKeyDown);

        let (status_text, status_class) = match self.status {
            AppStatus::Ready => ("Ready", "status status-ready"),
            AppStatus::Running => ("Running", "status status-running"),
            AppStatus::Exited => ("Exited", "status status-exited"),
        };

        let can_run = !self.running;
        let is_running = self.running;

        html! {
            <>
                <header>
                    <h1>{"Pascal Demos"}</h1>
                    <span class="subtitle">{"COR24 P-Code VM"}</span>
                </header>

                <div class="toolbar">
                    <select class="demo-select" onchange={on_select}>
                        { for DEMOS.iter().enumerate().map(|(i, d)| html! {
                            <option value={i.to_string()} selected={i == self.selected}>
                                { d.name }
                            </option>
                        })}
                    </select>
                    if can_run {
                        <button class="btn btn-run"
                                onclick={link.callback(|_| Msg::LinkAndRun)}>
                            {"Link & Run"}
                        </button>
                    } else {
                        <button class="btn btn-stop"
                                onclick={link.callback(|_| Msg::Stop)}>
                            {"Stop"}
                        </button>
                    }
                    <span class={status_class}>{ status_text }</span>
                </div>

                <div class="grid">
                    // Top-left: Pascal Source
                    <div class="panel panel-tl">
                        <div class="panel-header">{"Pascal Source"}</div>
                        <div class="panel-body">
                            <pre class="code-display">{ demo.pas_source }</pre>
                        </div>
                    </div>

                    // Top-right: P-Code Assembly
                    <div class="panel panel-tr">
                        <div class="panel-header">{"P-Code Assembly (.spc)"}</div>
                        <div class="panel-body">
                            <pre class="code-display">{ demo.spc_source }</pre>
                        </div>
                    </div>

                    // Bottom-left: Output
                    <div class="panel panel-bl">
                        <div class="panel-header">{"Output"}</div>
                        <div class="panel-body">
                            <div class="output-text" ref={self.output_ref.clone()}>
                                { &self.output }
                            </div>
                        </div>
                        <div class="uart-input">
                            <input class="uart-field" type="text"
                                   placeholder="UART input..."
                                   value={self.uart_input.clone()}
                                   oninput={on_input}
                                   onkeydown={on_keydown}
                                   disabled={!is_running} />
                            <button class="btn btn-send"
                                    onclick={link.callback(|_| Msg::SendInput)}
                                    disabled={!is_running}>
                                {"Send"}
                            </button>
                        </div>
                    </div>

                    // Bottom-right: Hardware
                    <div class="panel panel-br">
                        <div class="panel-header">{"Hardware"}</div>
                        <div class="panel-body">
                            <div class="hw-section">
                                <div class="hw-row">
                                    <span>{"LED D2:"}</span>
                                    <span class={classes!("led-indicator",
                                        self.led_on.then_some("led-on"))}></span>
                                    <span class="hw-stat">
                                        { if self.led_on { "on" } else { "off" } }
                                    </span>
                                </div>
                            </div>
                            <div class="hw-section">
                                <div class="hw-row">
                                    <span>{"Switch S2:"}</span>
                                    <button class={classes!("switch-btn",
                                        self.switch_on.then_some("switch-on"))}
                                        onclick={link.callback(|_| Msg::ToggleSwitch)}>
                                        { if self.switch_on { "ON" } else { "OFF" } }
                                    </button>
                                </div>
                            </div>
                            <div class="hw-section">
                                <div class="hw-row">
                                    <span class="hw-stat">{"Binary: "}</span>
                                    <span class="hw-stat-val">
                                        { if self.binary_size > 0 {
                                            format!("{} bytes", self.binary_size)
                                        } else {
                                            "—".into()
                                        }}
                                    </span>
                                </div>
                                <div class="hw-row">
                                    <span class="hw-stat">{"Instructions: "}</span>
                                    <span class="hw-stat-val">
                                        { self.instruction_count.to_string() }
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <footer>
                    <span>{"MIT License"}</span>
                    <span class="sep">{"|"}</span>
                    <span>{"© 2026 Michael A Wright"}</span>
                    <span class="sep">{"|"}</span>
                    <span>{"COR24-P24C"}</span>
                </footer>
            </>
        }
    }
}
