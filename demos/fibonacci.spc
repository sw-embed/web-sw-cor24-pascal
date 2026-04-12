.module fibonacci
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
; p24p output: fibonacci
.global f1 1
.global f2 1
.global f3 1
.global i 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 0
    storeg f1
    push 1
    storeg f2
    loadg f1
    call _p24p_write_int
    call _p24p_write_ln
    loadg f2
    call _p24p_write_int
    call _p24p_write_ln
    push 3
    storeg i
L1:
    loadg i
    push 10
    le
    jz L2
    loadg f1
    loadg f2
    add
    storeg f3
    loadg f3
    call _p24p_write_int
    call _p24p_write_ln
    loadg f2
    storeg f1
    loadg f3
    storeg f2
    loadg i
    push 1
    add
    storeg i
    jmp L1
L2:
L0:
    halt
.end
.endmodule
; OK
