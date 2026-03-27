# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## CRITICAL: AgentRail Session Protocol (MUST follow exactly)

This project uses AgentRail. Every session follows this exact sequence:

### 1. START (do this FIRST, before anything else)
```bash
agentrail next
```
Read the output carefully. It tells you your current step, prompt, skill docs, and past trajectories.

### 2. BEGIN (immediately after reading the next output)
```bash
agentrail begin
```

### 3. WORK (do what the step prompt says)
Do NOT ask the user "want me to proceed?" or "shall I start?". The step prompt IS your instruction. Execute it.

### 4. COMMIT (after the work is done)
Commit your code changes with git.

### 5. COMPLETE (LAST thing, after committing)
```bash
agentrail complete --summary "what you accomplished" \
  --reward 1 \
  --actions "tools and approach used"
```
If the step failed: `--reward -1 --failure-mode "what went wrong"`
If the saga is finished: add `--done`

### 6. STOP (after complete, DO NOT continue working)
Do NOT make any further code changes after running agentrail complete.
Any changes after complete are untracked and invisible to the next session.
If you see more work to do, it belongs in the NEXT step, not this session.

Do NOT skip any of these steps. The next session depends on your trajectory recording.

## Project: web-p24c -- Browser-Based Pascal Demos for COR24

Read-only Pascal source and pre-compiled p-code assembly displayed side by side. Link (pl24r), assemble (pa24r), and run (pvm.s on cor24-rs emulator) — all in WASM. No server-side compilation.

## Multi-Agent Coordination (Wiki)

This project coordinates with other agents via a shared wiki. See `docs/agent-cas-wiki.md` for the full API reference and CAS protocol.

- **Wiki server:** `http://localhost:7402` (git backend)
- **Key pages:** [[AgentToAgentRequests]], [[AgentStatus]], [[P24Toolchain]], [[COR24Architecture]], [[MVP]]
- **On session start:** Read [[AgentToAgentRequests]] and [[AgentStatus]] to check for new requests or updates from other agents. Update your status.

## Related Projects

- `~/github/softwarewrighter/web-dv24r` -- P-code debugger (CLOSEST pattern — study build.rs, config.rs, debugger.rs, demos.rs)
- `~/github/sw-vibe-coding/pv24a` -- P-code VM and assembler (COR24 assembly, `pvm.s`)
- `~/github/softwarewrighter/pa24r` -- P-code assembler (Rust, .spc → .p24)
- `~/github/softwarewrighter/pl24r` -- P-code text-level linker (Rust)
- `~/github/softwarewrighter/p24p` -- Pascal compiler (C, compiled by tc24r)
- `~/github/softwarewrighter/pr24p` -- Pascal runtime library (.spc sources)
- `~/github/sw-embed/cor24-rs` -- COR24 assembler and emulator (Rust)
- `~/github/sw-vibe-coding/web-tf24a` -- Forth debugger (pattern reference)
- `~/github/sw-vibe-coding/web-tc24r` -- C compiler UI (pattern reference)
- `~/github/sw-vibe-coding/web-tml24c` -- Lisp REPL (pattern reference)
- `~/github/sw-vibe-coding/agentrail-domain-coding` -- Coding skills domain

## Available Task Types

`rust-project-init`, `rust-clippy-fix`, `yew-component`, `wasm-build`, `pre-commit`

## Key Documentation (READ BEFORE WORKING)

- `docs/research.txt` -- Full design spec: UI layout, architecture, build config, demo programs, execution model, toolchain dependencies, loading/relocation protocol.
- `docs/agent-cas-wiki.md` -- Wiki API for multi-agent coordination (CAS protocol, endpoints, workflow).

## Build

Edition 2024 for any Rust code. Never suppress warnings.

```bash
trunk build                    # Build WASM to dist/
./scripts/serve.sh             # Dev server (port 9918)
./scripts/build-pages.sh       # Release build to pages/ for GitHub Pages
cargo clippy --all-targets --all-features -- -D warnings  # Lint
cargo fmt --all                # Format
```

## Architecture

- **Trunk** builds the WASM binary and serves it
- **cor24-emulator** provides `EmulatorCore` + `Assembler` (path dep to `../../sw-embed/cor24-rs`)
- **pa24r** provides p-code assembler (path dep to `../pa24r`)
- **pl24r** provides p-code linker (path dep to `../pl24r`)
- **Yew 0.21** CSR framework for the UI
- **build.rs** pre-assembles pvm.s at build time (same pattern as web-dv24r)
- Batch execution loop (50K instructions per tick) prevents browser blocking
- Demo .pas + .spc pairs embedded via `include_str!()`
- Linking and assembly happen at runtime in WASM when user clicks Link & Run
