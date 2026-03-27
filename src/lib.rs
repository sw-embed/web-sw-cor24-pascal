pub mod demos;

use demos::DEMOS;
use web_sys::HtmlSelectElement;
use yew::prelude::*;

#[function_component(App)]
pub fn app() -> Html {
    let selected = use_state(|| 0_usize);

    let on_select = {
        let selected = selected.clone();
        Callback::from(move |e: Event| {
            let target: HtmlSelectElement = e.target_unchecked_into();
            if let Ok(idx) = target.value().parse::<usize>() {
                selected.set(idx);
            }
        })
    };

    let demo = &DEMOS[*selected];

    html! {
        <>
            <header>
                <h1>{"Pascal Demos"}</h1>
                <span class="subtitle">{"COR24 P-Code VM"}</span>
            </header>

            <div class="toolbar">
                <select class="demo-select" onchange={on_select}>
                    { for DEMOS.iter().enumerate().map(|(i, d)| html! {
                        <option value={i.to_string()} selected={i == *selected}>
                            { d.name }
                        </option>
                    })}
                </select>
                <button class="btn btn-run">{"Link & Run"}</button>
                <span class="status status-ready">{"Ready"}</span>
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
                        <div class="output-text"></div>
                    </div>
                    <div class="uart-input">
                        <input class="uart-field" type="text"
                               placeholder="UART input..." />
                        <button class="btn btn-send">{"Send"}</button>
                    </div>
                </div>

                // Bottom-right: Hardware
                <div class="panel panel-br">
                    <div class="panel-header">{"Hardware"}</div>
                    <div class="panel-body">
                        <div class="hw-section">
                            <div class="hw-row">
                                <span>{"LED D2:"}</span>
                                <span class="led-indicator"></span>
                                <span class="hw-stat">{"off"}</span>
                            </div>
                        </div>
                        <div class="hw-section">
                            <div class="hw-row">
                                <span>{"Switch S2:"}</span>
                                <button class="switch-btn">{"Toggle"}</button>
                            </div>
                        </div>
                        <div class="hw-section">
                            <div class="hw-row">
                                <span class="hw-stat">{"Binary: "}</span>
                                <span class="hw-stat-val">{"—"}</span>
                            </div>
                            <div class="hw-row">
                                <span class="hw-stat">{"Instructions: "}</span>
                                <span class="hw-stat-val">{"0"}</span>
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
