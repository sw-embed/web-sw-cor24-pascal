.module factorial
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
; p24p output: factorial
.global n 1
.global s 1
.global i 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 10
    storeg n
    push 1
    storeg i
    push 1
    storeg s
L1:
    loadg i
    loadg n
    le
    jz L2
    loadg s
    loadg i
    mul
    storeg s
    loadg i
    push 1
    add
    storeg i
    jmp L1
L2:
    push S0
    call _p24p_write_str
    call _p24p_write_ln
    loadg s
    call _p24p_write_int
    call _p24p_write_ln
L0:
    halt
.end
.data S0 49,48,33,32,61,32,0
.endmodule
; OK
