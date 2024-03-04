
const fs = require('node:fs');
const assert = require('assert')

function LoadWasm(cfg){
    const wasmBuffer = fs.readFileSync('./wasm.wasm');
    if (cfg != undefined) {
        return WebAssembly.instantiate(wasmBuffer, cfg)
    } else {
        return WebAssembly.instantiate(wasmBuffer)
    }
}

describe('test wasm', function() {
    let mem = new WebAssembly.Memory({initial: 1})
    LoadWasm({mem: {mem: mem}}).then(wasmModule => {
        const { myAbs, myMemset, myGetSum, myQuickSort } = wasmModule.instance.exports;
        it('myAbs', function() {
            assert.equal(myAbs(-5), 5)
            assert.equal(myAbs(0), 0)
            assert.equal(myAbs(35), 35)
        })

        it('myGetSum', function() {
            assert.equal(myGetSum(5), 15)
            assert.equal(myGetSum(10), 55)
        })

        it('myMemset', function() {
            let assertMemset = (mem, start, len, b)=> {
                flag = true
                let buf = new Int8Array(mem.buffer, start, len)
                for (let i = 0; i < len; i ++) {
                    flag = flag & (buf[i] == b)
                }
                return flag
            }
            myMemset(0, 50, 0x04)
            assert.equal(true, assertMemset(mem, 0, 50, 0x04))
        })

        it('myQS', function() {
            let raw_values = [5,6,7,8,9,-1,3,4]
            let i32Array = new Int32Array(mem.buffer, 0, raw_values.length)
            for (let i in raw_values) {
                i32Array[i] = raw_values[i]
            }
            let assertQS = (mem, start, len) => {
                let arr = new Int32Array(mem.buffer, start, len)
                let m = arr[0]
                for (let i = 0; i < len; i ++) {
                    if (arr[i] < m) {
                        return false
                    } else {
                        m = arr[i]
                    }
                }
                return true
            }
            myQuickSort(0, raw_values.length - 1)
            assert.equal(true, assertQS(mem, 0, raw_values.length))
        })
    })
})
