# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project: web-sw-cor24-pascal -- Browser-Based Pascal Demos for COR24

Pascal source and pre-compiled p-code assembly displayed side by side. Link (pl24r), assemble (pa24r), and run (pvm.s on COR24 emulator) -- all in WASM. No server-side compilation. Edit mode compiles Pascal via p24p running inside a COR24 emulator in the browser.

## Related Projects

- `~/github/sw-embed/web-sw-cor24-pcode` -- P-code debugger (CLOSEST pattern -- study build.rs, config.rs, debugger.rs, demos.rs)
- `~/github/sw-embed/sw-cor24-pcode` -- P-code VM, assembler (pa24r), and linker (pl24r)
- `~/github/sw-embed/sw-cor24-pascal` -- Pascal compiler (compiler/) and runtime (runtime/)
- `~/github/sw-embed/sw-cor24-emulator` -- COR24 emulator core (Rust; `EmulatorCore`)
- `~/github/sw-embed/sw-cor24-x-assembler` -- COR24 cross-assembler (Rust; `Assembler`, used at build time)

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
- **cor24-emulator** provides `EmulatorCore` (path dep to `../sw-cor24-emulator`)
- **cor24-assembler** provides the COR24 `Assembler`, used by build.rs (path dep to `../sw-cor24-x-assembler`)
- **pa24r** provides p-code assembler (path dep to `../sw-cor24-pcode/assembler`)
- **pl24r** provides p-code linker (path dep to `../sw-cor24-pcode/linker`)
- **build.rs** pre-assembles pvm.s and compiles p24p Pascal compiler at build time
- **Yew 0.21** CSR framework for the UI
- Batch execution loop (50K instructions per tick) prevents browser blocking
- Demo .pas + .spc pairs embedded via `include_str!()`
- Linking and assembly happen at runtime in WASM when user clicks Link & Run

## Devgroup workflow

This repo follows the devgroup branching/PR policy. **You never push** -- the
coordinator (mike) relays your work into `dev` and pushes.

- **Branches:** `main` and `dev` are coordinator-only. Base your work on
  `origin/dev`, not `origin/main`.
  - `feat/<slug>` -- work in progress (use `dg-new-feature <slug>`)
  - `fix/<slug>` -- bug-fix flavor (use `dg-new-fix <slug>`)
  - `pr/<slug>` -- "ready to merge" signal; created by renaming `feat/` ->
    `pr/` via `dg-mark-pr`
- **Rules:** no history rewrites on `dev`/`main` (rebase is OK on your own
  `feat/*`); the ref name is the contract -- no PR API, JSON, or ticketing.
- **Flow:** `dg-new-feature <slug>` -> commit -> verify -> update `CHANGES.md`
  -> `dg-mark-pr` -> tell mike. After merge: `git fetch origin --prune &&
  git switch dev && git branch -D pr/<slug>`.
- **Helpers** (on `PATH`): `dg-new-feature`, `dg-new-fix`, `dg-mark-pr`,
  `dg-list-pr`, `dg-reap`. Run `onboarding` for a full briefing.

Full policy: `/disk1/github/softwarewrighter/devgroup/docs/branching-pr-strategy.md`
