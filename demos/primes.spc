.module primecheck
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
; p24p output: primecheck
.global n 1
.global i 1
.global isprime 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 2
    storeg n
L1:
    loadg n
    push 20
    le
    jz L2
    push 1
    storeg isprime
    push 2
    storeg i
L3:
    loadg i
    loadg n
    lt
    jz L4
    loadg n
    loadg i
    mod
    push 0
    eq
    jz L5
    push 0
    storeg isprime
L5:
    loadg i
    push 1
    add
    storeg i
    jmp L3
L4:
    loadg isprime
    jz L7
    loadg n
    call _p24p_write_int
    call _p24p_write_ln
L7:
    loadg n
    push 1
    add
    storeg n
    jmp L1
L2:
L0:
    halt
.end
.endmodule
; OK
