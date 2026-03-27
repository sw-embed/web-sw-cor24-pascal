Phase 6: In-browser Pascal compilation. p24p now has UART-input mode (src/main.c reads Pascal via getchar until EOT, compiles to .spc on UART). Integrate this into web-p24c:

1. Build-time: Add to build.rs — compile p24p C source with tc24r to COR24 assembly, then assemble to binary (same pattern as pvm.s). Embed the p24p binary via include_bytes!().

2. Runtime: Add a 'Compile & Run' mode alongside existing 'Link & Run':
   - User edits Pascal source in a text area (left panel becomes editable)
   - Click 'Compile & Run' spins up a second EmulatorCore running the p24p binary
   - Feed Pascal source + EOT via UART to the p24p emulator
   - Run in batches until halt, collecting .spc from UART output
   - Feed collected .spc into existing pipeline: pl24r link with runtime → pa24r assemble → loader → pvm.s execute

3. UI changes:
   - Pascal source panel becomes editable text area when in compile mode
   - P-code panel shows the .spc output from compilation (read-only)
   - Status shows Compiling → Linking → Running progression
   - Keep demo selector for pre-compiled demos as fast defaults

Reference: p24p UART mode documented in wiki [[P24P]]. Build pattern: study web-p24c/build.rs for pvm.s pre-assembly. Emulator batch execution pattern: study web-p24c/src/lib.rs Msg::Tick handler.

Dependencies: tc24r must be available at build time. p24p source at ~/github/softwarewrighter/p24p/src/{main.c,lexer.c,lexer.h,parser.c,parser.h}. tc24r include dir at ~/github/sw-vibe-coding/tc24r/include.