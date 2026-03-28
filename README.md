# web-p24c

Browser-based Pascal demo runner for the [pv24a](https://github.com/softwarewrighter/pv24a) p-code VM running on the [COR24](https://github.com/sw-embed/cor24-rs) emulator via WASM.

**[Live Demo](https://softwarewrighter.github.io/web-p24c/)**

## Overview

web-p24c displays Pascal source and pre-compiled p-code assembly side by side. Two modes:

- **Demo mode**: Select a pre-compiled demo and click "Link & Run" to link, assemble, and execute instantly.
- **Edit mode**: Write or modify Pascal source in an editable text area, then click "Compile & Run" to compile via the [p24p](https://github.com/softwarewrighter/p24p) Pascal compiler running inside a COR24 emulator, link with the runtime, assemble, and execute -- all in the browser.

Linking uses [pl24r](https://github.com/softwarewrighter/pl24r), assembly uses [pa24r](https://github.com/softwarewrighter/pa24r), and execution runs on the COR24 emulator via WASM. No server-side compilation.

11 demos: Hello World, Countdown, Fibonacci, Primes, Collatz, For Loop, Factorial, Even/Odd, Powers of 2, Write, and Std Library.

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
