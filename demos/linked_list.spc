.module pointertest
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
; p24p output: pointertest
.global head 1
.global p 1
.global tmp 1
.global i 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 0
    storeg head
    push 1
    storeg i
L1:
    loadg i
    push 5
    le
    jz L2
    push 6
    call _p24p_new
    storeg p
    loadg p
.global _p24p_tmp 1
    storeg _p24p_tmp
    loadg i
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
    add
    storeg i
    jmp L1
L2:
    loadg head
    storeg p
L3:
    loadg p
    push 0
    ne
    jz L4
    loadg p
    load
    call _p24p_write_int
    call _p24p_write_ln
    loadg p
    push 3
    add
    load
    storeg p
    jmp L3
L4:
    loadg head
    storeg p
L5:
    loadg p
    push 0
    ne
    jz L6
    loadg p
    push 3
    add
    load
    storeg tmp
    loadg p
    call _p24p_dispose
    loadg tmp
    storeg p
    jmp L5
L6:
    push 0
    call _p24p_write_int
    call _p24p_write_ln
L0:
    halt
.end
.endmodule
; OK
