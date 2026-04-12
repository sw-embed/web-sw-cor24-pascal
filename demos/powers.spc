.module power
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
; p24p output: power
.global base 1
.global exp 1
.global result 1
.global i 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 2
    storeg base
    push 1
    storeg exp
L1:
    loadg exp
    push 12
    le
    jz L2
    push 1
    storeg result
    push 0
    storeg i
L3:
    loadg i
    loadg exp
    lt
    jz L4
    loadg result
    loadg base
    mul
    storeg result
    loadg i
    push 1
    add
    storeg i
    jmp L3
L4:
    loadg result
    call _p24p_write_int
    call _p24p_write_ln
    loadg exp
    push 1
    add
    storeg exp
    jmp L1
L2:
L0:
    halt
.end
.endmodule
; OK
