.module exitdemo
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
; p24p output: exitdemo
.global head 1
.global p 1
.global i 1

.proc main 0
    call _p24p_main
    halt
.end

.proc _user_find 2
    loada 1
    storel 1
    push 0
    storel 0
L1:
    loadl 1
    push 0
    ne
    jz L2
    loadl 1
    load
    loada 0
    eq
    jz L3
    push 1
    storel 0
    jmp L0
L3:
    loadl 1
    push 3
    add
    load
    storel 1
    jmp L1
L2:
L0:
    loadl 0
    ret 2
.end

.proc _p24p_main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 0
    storeg head
    push 5
    storeg i
L6:
    loadg i
    push 1
    ge
    jz L7
    push 6
    call _p24p_new
    storeg p
    loadg p
.global _p24p_tmp 1
    storeg _p24p_tmp
    loadg i
    push 10
    mul
    loadg _p24p_tmp
    store
    loadg p
    push 3
    add
    storeg _p24p_tmp
    loadg head
    loadg _p24p_tmp
    store
    loadg p
    storeg head
    loadg i
    push 1
    sub
    storeg i
    jmp L6
L7:
    loadg head
    push 30
    call _user_find
    call _p24p_write_int
    call _p24p_write_ln
    loadg head
    push 99
    call _user_find
    call _p24p_write_int
    call _p24p_write_ln
    loadg head
    push 10
    call _user_find
    call _p24p_write_int
    call _p24p_write_ln
    loadg head
    push 50
    call _user_find
    call _p24p_write_int
    call _p24p_write_ln
L5:
    ret 0
.end
.endmodule
; OK
