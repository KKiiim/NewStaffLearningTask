(module
    (import "mem" "mem" (memory 1))
    (import "log" "logI32" (func $logI32 (param i32)))
    (import "log" "LogSplit" (func $logSplit))
    (func $myAbs (param $in i32) (result i32)
        i32.const 0
        local.get $in
        i32.gt_s
        (if (result i32)
            (then
                i32.const 0
                local.get $in
                i32.sub
            )
            (else
                local.get $in
            )
        )
        return
    )
    (func $myGetSum (param $n i32) (result i32) (local $res i32)
        i32.const 0
        local.set $res
        (loop $loop (result i32)
            local.get $n
            local.get $res
            i32.add
            local.set $res
            local.get $n
            i32.const 1
            i32.sub
            local.set $n
            local.get $n
            i32.const 0
            i32.gt_s
            br_if $loop
            local.get $res
        )
    )

    (func $myMemset (param $start i32) (param $n i32) (param $byte i32)
        local.get $start
        local.get $byte
        local.get $n
        memory.fill
    )

    (func $partition (param $start i32) (param $end i32) (result i32)
        (local $left i32) (local $right i32) (local $pivot i32) (local $addr i32)
        local.get $end
        local.set $right
        local.get $start
        i32.const 1
        i32.add
        local.set $left
        ;; load pivot
        local.get $start
        i32.load
        local.set $pivot
        (loop $loop
            call $logSplit
            (block $find_left_end
                (loop $find_left
                    local.get $left
                    call $logI32
                    ;;Load arr[left]
                    local.get $left
                    local.get $right
                    i32.ge_s
                    br_if $find_left_end
                    local.get $left
                    i32.const 4
                    i32.mul
                    local.set $addr
                    local.get $addr
                    i32.load
                    local.get $pivot
                    i32.le_s
                    br_if $find_left
                )
                local.get $addr
                i32.load
                call $logI32
            )
            call $logSplit
            (block $find_right_end
                (loop $find_right
                    local.get $right
                    call $logI32
                    ;;Load arr[right]
                    local.get $left
                    local.get $right
                    i32.ge_s
                    br_if $find_right_end
                    local.get $right
                    i32.const 4
                    i32.mul
                    local.set $addr
                    local.get $addr
                    i32.load
                    local.get $pivot
                    i32.ge_s
                    br_if $find_right
                )
                local.get $addr
                i32.load
                call $logI32
            )
            call $logSplit
            local.get $left
            local.get $right
            i32.lt_s
            (if 
                (then
                    local.get $left
                    i32.const 4
                    i32.mul
                    i32.load
                    local.get $right
                    i32.const 4
                    i32.mul
                    i32.load
                    call $logI32
                    call $logSplit
                    ;; local.get $left
                    ;; i32.const 4
                    ;; i32.mul
                    ;; i32.store
                    ;;call $logI32
                    call $logSplit
                    local.get $right
                    i32.const 4
                    i32.mul
                    i32.store
                )
                (else
                    ;; local.get $left
                    ;; i32.const 4
                    ;; i32.mul
                    ;; i32.load
                    ;; local.get $pivot
                    ;; local.get $left
                    ;; i32.const 4
                    ;; i32.mul
                    ;; i32.store
                    ;; local.get $start
                    ;; i32.const 4
                    ;; i32.mul
                    ;; i32.store
                )
            )
        )
        local.get $pivot
    )

    (export "myAbs" (func $myAbs))
    (export "myGetSum" (func $myGetSum))
    (export "myMemset" (func $myMemset))
    (export "partition" (func $partition))
)