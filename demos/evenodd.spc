.module evenodd
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
; p24p output: evenodd
.global i 1

.proc main 0
    enter 0
    push 1
    storeg i
L0:
    loadg i
    push 10
    le
    jz L1
    loadg i
    push 2
    mod
    push 0
    eq
    jz L2
    loadg i
    call _p24p_write_int
    call _p24p_write_ln
    jmp L3
L2:
    push 0
    loadg i
    sub
    call _p24p_write_int
    call _p24p_write_ln
L3:
    loadg i
    push 1
    add
    storeg i
    jmp L0
L1:
    halt
.end
.endmodule
; OK
