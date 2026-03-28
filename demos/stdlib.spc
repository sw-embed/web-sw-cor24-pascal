.module stdlib
.extern _p24p_write_int
.extern _p24p_write_bool
.extern _p24p_write_str
.extern _p24p_write_ln
.extern _p24p_abs
.extern _p24p_odd
.extern _p24p_ord
.extern _p24p_chr
.extern _p24p_succ
.extern _p24p_pred
.extern _p24p_sqr
.extern _p24p_eof
.extern _p24p_eoln
.extern _p24p_read_ln
.extern _p24p_write_char
.export main
; p24p output: stdlib
.global x 1

.proc main 0
    enter 0
    push 0
    push 5
    sub
    storeg x
    loadg x
    call _p24p_abs
    call _p24p_write_int
    call _p24p_write_ln
    push 3
    call _p24p_sqr
    call _p24p_write_int
    call _p24p_write_ln
    push 9
    call _p24p_succ
    call _p24p_write_int
    call _p24p_write_ln
    push 10
    call _p24p_pred
    call _p24p_write_int
    call _p24p_write_ln
    push 7
    call _p24p_odd
    jz L0
    push S0
    call _p24p_write_str
    call _p24p_write_ln
L0:
    push 4
    call _p24p_odd
    push 0
    eq
    jz L2
    push S1
    call _p24p_write_str
    call _p24p_write_ln
L2:
    halt
.end
.data S0 55,32,105,115,32,111,100,100,0
.data S1 52,32,105,115,32,101,118,101,110,0
.endmodule
; OK
