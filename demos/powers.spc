.module power
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
; p24p output: power
.global base 1
.global exp 1
.global result 1
.global i 1

.proc main 0
    enter 0
    push 2
    storeg base
    push 1
    storeg exp
L0:
    loadg exp
    push 12
    le
    jz L1
    push 1
    storeg result
    push 0
    storeg i
L2:
    loadg i
    loadg exp
    lt
    jz L3
    loadg result
    loadg base
    mul
    storeg result
    loadg i
    push 1
    add
    storeg i
    jmp L2
L3:
    loadg result
    call _p24p_write_int
    call _p24p_write_ln
    loadg exp
    push 1
    add
    storeg exp
    jmp L0
L1:
    halt
.end
.endmodule
; OK
