.module testnested
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
; p24p output: testnested
.global result 1

.proc main 0
    call _p24p_main
    halt
.end

.proc _user_inner 0
    push 42
    storen 1 0
L0:
    ret 0
.end

.proc _user_set_x 0
    loada 0
    storen 1 0
L1:
    ret 1
.end

.proc _user_get_x 1
    loadn 1 0
    storel 0
L2:
    loadl 0
    ret 0
.end

.proc _user_outer 1
    push 0
    storel 0
    calln 0 _user_inner
    calln 0 _user_get_x
    call _p24p_write_int
    call _p24p_write_ln
    push 99
    calln 0 _user_set_x
    calln 0 _user_get_x
    call _p24p_write_int
    call _p24p_write_ln
    loadl 0
    storeg result
L3:
    ret 0
.end

.proc _user_bot 0
    loadn 2 0
    push 10
    add
    storen 1 0
L4:
    ret 0
.end

.proc _user_mid 1
    push 0
    storel 0
    calln 0 _user_bot
    loadl 0
    storen 1 0
L5:
    ret 0
.end

.proc _user_deep 1
    push 5
    storel 0
    calln 0 _user_mid
    loadl 0
    storeg result
L6:
    ret 0
.end

.proc _p24p_main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    call _user_outer
    loadg result
    call _p24p_write_int
    call _p24p_write_ln
    call _user_deep
    loadg result
    call _p24p_write_int
    call _p24p_write_ln
L7:
    ret 0
.end
.endmodule
; OK
