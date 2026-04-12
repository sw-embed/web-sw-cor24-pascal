.module repeattest
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
; p24p output: repeattest
.global n 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 5
    storeg n
L1:
    loadg n
    call _p24p_write_int
    call _p24p_write_ln
    loadg n
    push 1
    sub
    storeg n
    loadg n
    push 0
    eq
    jz L1
    push S0
    call _p24p_write_str
    call _p24p_write_ln
L0:
    halt
.end
.data S0 100,111,110,101,0
.endmodule
; OK
