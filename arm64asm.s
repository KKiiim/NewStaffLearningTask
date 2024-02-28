
.text
.global myAbs, myMemset, myGetSum, myQuickSort, partition

myAbs:
    CMP X0, #0
    BPL abs_ret
    NEG X0, X0
abs_ret:
    RET


myMemset:
    MOV     X3, #0
    CMP     X1, #0
    BEQ     memset_ret
memset_loop:
    STRB    W2, [X0, X3]
    ADD     X3, X3, #1
    CMP     X3, X1
    BLT     memset_loop
memset_ret: 
    MOV X0, X3
    RET

myGetSum:
    MOV X2, #0
    MOV X1, #0
getsum_loop:
    ADD X2, X2, X1
    ADD X1, X1, #1
    CMP X1, X0
    BLE getsum_loop
getsum_ret:
    MOV X0, X2
    RET

myQuickSort:
    CMP     X1, X2
    BGE     _my_quick_sort_ret
    STP     LR, X1, [SP, #-0x10]!
    BL      _partition
    LDP     LR, X1, [SP], #0x10
    
    STP     X1, X2, [SP, #-0x10]!
    SUB     X2, X2, 1
    STP     LR, X3, [SP, #-0x10]!
    BL      _myQuickSort
    LDP     LR, X3, [SP], #0x10
    LDP     X1, X2, [SP], #0x10
    ADD     X1, X10, #1
    STP     LR, X10, [SP, #-0x10]!
    BL      _myQuickSort
    LDP     LR, X10, [SP], #0x10
_my_quick_sort_ret:
    RET

_partition:
    MOV     X10, X1
    MOV     X11, X2
    LDR     W20, [X0, X1, LSL #2]
_partition_loop:
    ;CMP     X10, X11
    ;BGE     _partition_loop_end
_find_right:
    LDR     W21, [X0, X11, LSL #2]
    CMP     X10, X11
    BGE     _find_left
    CMP     W21, W20
    BLT     _find_right_end
    SUB     X11, X11, #1
    B       _find_right
_find_right_end:
_find_left:
    LDR     W22, [X0, X10, LSL #2]
    CMP     X10, X11
    BGE     _partition_loop_end
    CMP     W22, W20
    BGT     _find_left_end
    ADD     X10, X10, #1
    B       _find_left
_find_left_end:
    STR     W22, [X0, X11, LSL #2]
    STR     W21, [X0, X10, LSL #2]
    B       _partition_loop
_partition_loop_end:
    STR     W20, [X0, X11, LSL #2]
    STR     W21, [X0, X1, LSL #2]
    // MOV     X0, X10
    RET


