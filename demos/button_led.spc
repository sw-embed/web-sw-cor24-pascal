.module buttonled
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
.extern _p24p_led_on
.extern _p24p_led_off
.extern _p24p_read_switch
.export main
; p24p output: buttonled
.global on 1

.proc main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 0
    storeg on
    push S0
    call _p24p_write_str
    call _p24p_write_ln
L1:
    loadg on
    push 0
    eq
    jz L2
    call _p24p_read_switch
    push 1
    eq
    jz L3
    call _p24p_led_on
    push 1
    storeg on
L3:
    jmp L1
L2:
    push S1
    call _p24p_write_str
    call _p24p_write_ln
L0:
    halt
.end
.data S0 80,114,101,115,115,32,83,50,32,115,119,105,116,99,104,46,46,46,0
.data S1 76,69,68,32,111,110,32,98,121,32,115,119,105,116,99,104,0
.endmodule
; OK
