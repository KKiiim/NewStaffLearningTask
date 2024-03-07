(module
    (import "mem" "mem" (memory 1))
    
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
    (func $myGetSum (param $n i32) (result i64)
        (local $n64 i64) (local $res i64)
        i64.const 0
        local.set $res
        (loop $loop (result i64)
            local.get $n
            i64.extend_i32_s
            local.get $res
            i64.add
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
        local.set $left
        local.get $start
        i32.const 4
        i32.mul
        i32.load
        local.set $pivot
        (loop $loop
            (block $find_right_end
                (loop $find_right
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
                    (if
                        (then
                            local.get $right
                            i32.const 1
                            i32.sub
                            local.set $right
                            br $find_right
                        )
                    )
                )
            )
            (block $find_left_end
                (loop $find_left
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
                    (if
                        (then
                            local.get $left
                            i32.const 1
                            i32.add
                            local.set $left
                            br $find_left
                        )
                    )
                )
            )
            local.get $left
            local.get $right
            i32.lt_s
            (if 
                (then
                    local.get $left
                    i32.const 4
                    i32.mul
                    local.get $right
                    i32.const 4
                    i32.mul
                    i32.load

                    local.get $right
                    i32.const 4
                    i32.mul
                    local.get $left
                    i32.const 4
                    i32.mul
                    i32.load
                    i32.store
                    i32.store
                    br $loop
                )
                (else
                    local.get $start
                    i32.const 4
                    i32.mul
                    local.get $left
                    i32.const 4
                    i32.mul
                    i32.load
                    local.get $left
                    i32.const 4
                    i32.mul
                    local.get $start
                    i32.const 4
                    i32.mul
                    i32.load
                    i32.store
                    i32.store
                )
            )
        )
        local.get $left
    )

    (func $myQuickSort (param $start i32) (param $end i32)
        (local $pivot i32)
        local.get $start
        local.get $end
        i32.ge_s
        (if 
            (then
                return
            )
        )
        local.get $start
        local.get $end
        call $partition
        local.set $pivot
        local.get $start
        local.get $pivot
        i32.const 1
        i32.sub
        call $myQuickSort
        local.get $pivot
        i32.const 1
        i32.add
        local.get $end
        call $myQuickSort
    )

    (export "myAbs" (func $myAbs))
    (export "myGetSum" (func $myGetSum))
    (export "myMemset" (func $myMemset))
    (export "partition" (func $partition))
    (export "myQuickSort" (func $myQuickSort))
)