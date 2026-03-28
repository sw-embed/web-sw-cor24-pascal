.module writetest
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
; p24p output: writetest
.global i 1

.proc main 0
    enter 0
    push 1
    storeg i
L0:
    loadg i
    push 5
    le
    jz L1
    loadg i
    call _p24p_write_int
    push S0
    call _p24p_write_str
    loadg i
    push 1
    add
    storeg i
    jmp L0
L1:
    push S1
    call _p24p_write_str
    call _p24p_write_ln
    halt
.end
.data S0 32,0
.data S1 100,111,110,101,0
.endmodule
; OK
