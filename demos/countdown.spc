.module countdown
.export main
.extern _p24p_write_int
.extern _p24p_write_ln

.proc main 1
    ; i := 5 (local 0)
    push 5
    storel 0
loop_test:
    ; while i > 0
    loadl 0
    push 0
    gt
    jz loop_end
    ; writeln(i)
    loadl 0
    call _p24p_write_int
    call _p24p_write_ln
    ; i := i - 1
    loadl 0
    push 1
    sub
    storel 0
    jmp loop_test
loop_end:
    halt
.end

.endmodule
