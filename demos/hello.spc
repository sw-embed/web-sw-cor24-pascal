.module hello
.export main
.extern _p24p_write_str
.extern _p24p_write_ln

.data msg 72,101,108,108,111,44,32,87,111,114,108,100,33,0

.proc main 0
    push msg
    call _p24p_write_str
    call _p24p_write_ln
    halt
.end

.endmodule
