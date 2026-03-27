# web-p24c

Browser-based Pascal demo runner for the [pv24a](https://github.com/softwarewrighter/pv24a) p-code VM running on the [COR24](https://github.com/sw-embed/cor24-rs) emulator via WASM.

**[Live Demo](https://softwarewrighter.github.io/web-p24c/)**

## Overview

web-p24c displays Pascal source and pre-compiled p-code assembly side by side. Click "Link & Run" to link ([pl24r](https://github.com/softwarewrighter/pl24r)), assemble ([pa24r](https://github.com/softwarewrighter/pa24r)), and execute on the COR24 emulator -- all in the browser, no server-side compilation.

Demos include Hello World (string output via `_p24p_write_str`) and Countdown (loop with global variable).

Built with Rust, Yew 0.21, and Trunk. Runs entirely in the browser as a WASM application.

## Build

```bash
trunk build                    # Build WASM to dist/
./scripts/serve.sh             # Dev server (port 9918)
./scripts/build-pages.sh       # Release build to pages/ for GitHub Pages
```

## Related Projects

- [pv24a](https://github.com/softwarewrighter/pv24a) -- P-code VM and p-code assembler (COR24 assembly)
- [pa24r](https://github.com/softwarewrighter/pa24r) -- P-code assembler (Rust, .spc to .p24)
- [pl24r](https://github.com/softwarewrighter/pl24r) -- P-code text-level linker (Rust)
- [pr24p](https://github.com/softwarewrighter/pr24p) -- Pascal runtime library (.spc sources)
- [p24p](https://github.com/softwarewrighter/p24p) -- Pascal compiler (C)
- [cor24-rs](https://github.com/sw-embed/cor24-rs) -- COR24 assembler and emulator
- [web-dv24r](https://github.com/softwarewrighter/web-dv24r) -- P-code debugger (browser)

## License

MIT License -- see [LICENSE](LICENSE) for details.

Copyright (c) 2026 Michael A. Wright
