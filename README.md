# web-sw-cor24-pascal

Browser-based Pascal demo runner for the [sw-cor24-pcode](https://github.com/sw-embed/sw-cor24-pcode) p-code VM running on the [COR24](https://github.com/sw-embed/sw-cor24-emulator) emulator via WASM.

**[Live Demo](https://sw-embed.github.io/web-sw-cor24-pascal/)**

## Overview

web-sw-cor24-pascal displays Pascal source and pre-compiled p-code assembly side by side. Two modes:

- **Demo mode**: Select a pre-compiled demo and click "Link & Run" to link, assemble, and execute instantly.
- **Edit mode**: Write or modify Pascal source in an editable text area, then click "Compile & Run" to compile via the [sw-cor24-pascal](https://github.com/sw-embed/sw-cor24-pascal) Pascal compiler running inside a COR24 emulator, link with the runtime, assemble, and execute -- all in the browser.

Linking uses [pl24r](https://github.com/sw-embed/sw-cor24-pcode) (linker), assembly uses [pa24r](https://github.com/sw-embed/sw-cor24-pcode) (assembler), and execution runs on the COR24 emulator via WASM. No server-side compilation.

13 demos including hardware I/O: Button LED (switch-polling to light LED D2), LED On, and algorithmic demos (Fibonacci, Primes, Collatz, Factorial, etc.).

Built with Rust, Yew 0.21, and Trunk. Runs entirely in the browser as a WASM application.

## Build

```bash
trunk build                    # Build WASM to dist/
./scripts/serve.sh             # Dev server (port 9918)
./scripts/build-pages.sh       # Release build to pages/ for GitHub Pages
```

## Related Projects

- [sw-cor24-pcode](https://github.com/sw-embed/sw-cor24-pcode) -- P-code VM, assembler, and linker
- [sw-cor24-pascal](https://github.com/sw-embed/sw-cor24-pascal) -- Pascal compiler and runtime
- [sw-cor24-emulator](https://github.com/sw-embed/sw-cor24-emulator) -- COR24 assembler and emulator
- [web-sw-cor24-pcode](https://github.com/sw-embed/web-sw-cor24-pcode) -- P-code debugger (browser)

## License

MIT License -- see [LICENSE](LICENSE) for details.

Copyright (c) 2026 Michael A. Wright
