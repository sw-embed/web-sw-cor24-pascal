.module testforward
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
; p24p output: testforward

.proc main 0
    call _p24p_main
    halt
.end

.proc _user_quadruple 1
    loada 0
    call _user_double
    call _user_double
    storel 0
L0:
    loadl 0
    ret 1
.end

.proc _user_double 1
    loada 0
    push 2
    mul
    storel 0
L1:
    loadl 0
    ret 1
.end

.proc _user_is_odd 1
    loada 0
    push 0
    eq
    jz L3
    push 0
    storel 0
    jmp L4
L3:
    loada 0
    push 1
    sub
    call _user_is_even
    storel 0
L4:
L2:
    loadl 0
    ret 1
.end

.proc _user_is_even 1
    loada 0
    push 0
    eq
    jz L6
    push 1
    storel 0
    jmp L7
L6:
    loada 0
    push 1
    sub
    call _user_is_odd
    storel 0
L7:
L5:
    loadl 0
    ret 1
.end

.proc _p24p_main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 5
    call _user_quadruple
    call _p24p_write_int
    call _p24p_write_ln
    push 4
    call _user_is_even
    jz L9
    push 1
    call _p24p_write_int
    call _p24p_write_ln
    jmp L10
L9:
    push 0
    call _p24p_write_int
    call _p24p_write_ln
L10:
    push 3
    call _user_is_odd
    jz L11
    push 1
    call _p24p_write_int
    call _p24p_write_ln
    jmp L12
L11:
    push 0
    call _p24p_write_int
    call _p24p_write_ln
L12:
    push 3
    call _user_is_even
    jz L13
    push 1
    call _p24p_write_int
    call _p24p_write_ln
    jmp L14
L13:
    push 0
    call _p24p_write_int
    call _p24p_write_ln
L14:
L8:
    ret 0
.end
.endmodule
; OK
