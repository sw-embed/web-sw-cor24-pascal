.module binarysearchtree
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
; p24p output: binarysearchtree
.global root 1
.global p 1
.global parent 1
.global val 1
.global i 1

.proc main 0
    call _p24p_main
    halt
.end

.proc _user_printtree 0
    loada 0
    push 0
    ne
    jz L1
    loada 0
    push 3
    add
    load
    call _user_printtree
    loada 0
    load
    call _p24p_write_int
    call _p24p_write_ln
    loada 0
    push 6
    add
    load
    call _user_printtree
L1:
L0:
    ret 1
.end

.proc _p24p_main 0
    enter 0
    call _p24p_io_init
    call _p24p_heap_init
    push 0
    storeg root
    push 0
    storeg i
L4:
    loadg i
    push 7
    lt
    jz L5
    loadg i
    push 0
    eq
    jz L6
    push 4
    storeg val
    jmp L7
L6:
    loadg i
    push 1
    eq
    jz L8
    push 2
    storeg val
    jmp L9
L8:
    loadg i
    push 2
    eq
    jz L10
    push 6
    storeg val
    jmp L11
L10:
    loadg i
    push 3
    eq
    jz L12
    push 1
    storeg val
    jmp L13
L12:
    loadg i
    push 4
    eq
    jz L14
    push 3
    storeg val
    jmp L15
L14:
    loadg i
    push 5
    eq
    jz L16
    push 5
    storeg val
    jmp L17
L16:
    push 7
    storeg val
L17:
L15:
L13:
L11:
L9:
L7:
    push 9
    call _p24p_new
    storeg p
    loadg p
.global _p24p_tmp 1
    storeg _p24p_tmp
    loadg val
    loadg _p24p_tmp
    store
    loadg p
    push 3
    add
    storeg _p24p_tmp
    push 0
    loadg _p24p_tmp
    store
    loadg p
    push 6
    add
    storeg _p24p_tmp
    push 0
    loadg _p24p_tmp
    store
    loadg root
    push 0
    eq
    jz L18
    loadg p
    storeg root
    jmp L19
L18:
    loadg root
    storeg parent
L20:
    loadg parent
    push 0
    ne
    jz L21
    loadg val
    loadg parent
    load
    lt
    jz L22
    loadg parent
    push 3
    add
    load
    push 0
    eq
    jz L24
    loadg parent
    push 3
    add
    storeg _p24p_tmp
    loadg p
    loadg _p24p_tmp
    store
    push 0
    storeg parent
    jmp L25
L24:
    loadg parent
    push 3
    add
    load
    storeg parent
L25:
    jmp L23
L22:
    loadg parent
    push 6
    add
    load
    push 0
    eq
    jz L26
    loadg parent
    push 6
    add
    storeg _p24p_tmp
    loadg p
    loadg _p24p_tmp
    store
    push 0
    storeg parent
    jmp L27
L26:
    loadg parent
    push 6
    add
    load
    storeg parent
L27:
L23:
    jmp L20
L21:
L19:
    loadg i
    push 1
    add
    storeg i
    jmp L4
L5:
    loadg root
    call _user_printtree
L3:
    ret 0
.end
.endmodule
; OK
