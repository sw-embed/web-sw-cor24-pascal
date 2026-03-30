# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project: web-sw-cor24-pascal -- Browser-Based Pascal Demos for COR24

Pascal source and pre-compiled p-code assembly displayed side by side. Link (pl24r), assemble (pa24r), and run (pvm.s on COR24 emulator) -- all in WASM. No server-side compilation. Edit mode compiles Pascal via p24p running inside a COR24 emulator in the browser.

## Related Projects

- `~/github/sw-embed/web-sw-cor24-pcode` -- P-code debugger (CLOSEST pattern -- study build.rs, config.rs, debugger.rs, demos.rs)
- `~/github/sw-embed/sw-cor24-pcode` -- P-code VM, assembler (pa24r), and linker (pl24r)
- `~/github/sw-embed/sw-cor24-pascal` -- Pascal compiler (compiler/) and runtime (runtime/)
- `~/github/sw-embed/sw-cor24-emulator` -- COR24 assembler and emulator (Rust)

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
- **cor24-emulator** provides `EmulatorCore` + `Assembler` (path dep to `../sw-cor24-emulator`)
- **pa24r** provides p-code assembler (path dep to `../sw-cor24-pcode/assembler`)
- **pl24r** provides p-code linker (path dep to `../sw-cor24-pcode/linker`)
- **build.rs** pre-assembles pvm.s and compiles p24p Pascal compiler at build time
- **Yew 0.21** CSR framework for the UI
- Batch execution loop (50K instructions per tick) prevents browser blocking
- Demo .pas + .spc pairs embedded via `include_str!()`
- Linking and assembly happen at runtime in WASM when user clicks Link & Run
