.module casetest
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
; p24p output: casetest
.global day 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 1
    storeg day
L1:
    loadg day
    push 7
    le
    jz L2
    loadg day
    dup
    push 1
    eq
    jz L4
    drop
    push S0
    call _p24p_write_str
    call _p24p_write_ln
    jmp L3
L4:
    dup
    push 2
    eq
    jz L5
    drop
    push S1
    call _p24p_write_str
    call _p24p_write_ln
    jmp L3
L5:
    dup
    push 3
    eq
    jz L6
    drop
    push S2
    call _p24p_write_str
    call _p24p_write_ln
    jmp L3
L6:
    dup
    push 4
    eq
    jz L7
    drop
    push S3
    call _p24p_write_str
    call _p24p_write_ln
    jmp L3
L7:
    dup
    push 5
    eq
    jz L8
    drop
    push S4
    call _p24p_write_str
    call _p24p_write_ln
    jmp L3
L8:
    dup
    push 6
    eq
    jz L9
    drop
    push S5
    call _p24p_write_str
    call _p24p_write_ln
    jmp L3
L9:
    dup
    push 7
    eq
    jz L10
    drop
    push S6
    call _p24p_write_str
    call _p24p_write_ln
    jmp L3
L10:
    drop
L3:
    loadg day
    push 1
    add
    storeg day
    jmp L1
L2:
    push S7
    call _p24p_write_str
    call _p24p_write_ln
L0:
    halt
.end
.data S0 77,111,110,100,97,121,0
.data S1 84,117,101,115,100,97,121,0
.data S2 87,101,100,110,101,115,100,97,121,0
.data S3 84,104,117,114,115,100,97,121,0
.data S4 70,114,105,100,97,121,0
.data S5 83,97,116,117,114,100,97,121,0
.data S6 83,117,110,100,97,121,0
.data S7 68,111,110,101,0
.endmodule
; OK
