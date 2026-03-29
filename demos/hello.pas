{ Hello World — Pascal on the COR24 emulator.

  Pipeline stages when you click Link & Run:
  1. p-code (.spc) is linked with runtime  (pl24r)
  2. Linked p-code is assembled to binary  (pa24r)
  3. Binary loads into the p-code VM        (pvm.s)
  4. VM runs on the COR24 emulator       (cor24-rs)
  5. Output appears on the emulated UART

  In Edit mode, an extra first step compiles
  Pascal source to p-code using the p24p compiler,
  itself a C program running on the emulator.

  Everything runs in WebAssembly in the browser,
  or at the CLI via cor24-run, or on the COR24-TB
  development board. }

program Hello;
begin
  writeln('Hello, World!')
end.
