(module
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
            ;; local.get $res
            ;; call $log
            local.get $n
            i32.const 0
            i32.gt_s
            br_if $loop
            local.get $res
        )
    )
    (export "myAbs" (func $myAbs))
    (export "myGetSum" (func $myGetSum))
)