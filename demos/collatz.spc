.module collatz
.extern _p24p_write_int
.extern _p24p_write_bool
.extern _p24p_write_str
.extern _p24p_write_ln
.extern _p24p_io_init
.extern _p24p_read_int
.extern _p24p_read_char
.extern _p24p_read_ln
.extern _p24p_heap_init
.extern _p24p_new
.extern _p24p_dispose
.extern _p24p_abs
.extern _p24p_odd
.extern _p24p_ord
.extern _p24p_chr
.extern _p24p_succ
.extern _p24p_pred
.extern _p24p_sqr
.extern _p24p_eof
.extern _p24p_eoln
.extern _p24p_write_char
.extern _p24p_peek
.extern _p24p_poke
.extern _p24p_memcpy
.extern _p24p_memset
.export main
; p24p output: collatz
.global n 1
.global steps 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 27
    storeg n
    push 0
    storeg steps
    loadg n
    call _p24p_write_int
    call _p24p_write_ln
L1:
    loadg n
    push 1
    ne
    jz L2
    loadg n
    push 2
    mod
    push 0
    eq
    jz L3
    loadg n
    push 2
    div
    storeg n
    jmp L4
L3:
    push 3
    loadg n
    mul
    push 1
    add
    storeg n
L4:
    loadg steps
    push 1
    add
    storeg steps
    loadg n
    call _p24p_write_int
    call _p24p_write_ln
    jmp L1
L2:
    loadg steps
    call _p24p_write_int
    call _p24p_write_ln
L0:
    halt
.end
.endmodule
; OK
