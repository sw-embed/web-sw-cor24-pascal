.module echo
.extern _p24p_write_int
.extern _p24p_write_bool
.extern _p24p_write_str
.extern _p24p_write_ln
.extern _p24p_read_int
.extern _p24p_read_ln
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
.export main
; p24p output: echo
.global x 1

.proc main 0
    enter 0
    push S0
    call _p24p_write_str
    call _p24p_read_int
    storeg x
    call _p24p_read_ln
    push S1
    call _p24p_write_str
    loadg x
    call _p24p_write_int
    call _p24p_write_ln
    halt
.end
.data S0 69,110,116,101,114,32,97,32,110,117,109,98,101,114,58,32,0
.data S1 89,111,117,32,101,110,116,101,114,101,100,58,32,0
.endmodule
; OK
