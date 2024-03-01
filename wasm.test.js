
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

function LogI32(i32) {
    console.log('i32:', '0x' + i32.toString(16))
}

function LogSplit() {
    console.log('----------')
}

describe('test myAbs', function() {
    LoadWasm().then(wasmModule => {
        const { myAbs } = wasmModule.instance.exports;
        it('myAbs', function() {
            assert.equal(myAbs(-5), 5)
            assert.equal(myAbs(0), 0)
            assert.equal(myAbs(35), 35)
        })
    })
})


describe('test myMemset', function() {
    let mem = new WebAssembly.Memory({initial: 1})
    LoadWasm({js: {mem: mem}}).then(wasmModule => {
        const { myMemset } = wasmModule.instance.exports;
        it('myMemset', function() {
            myMemset(5, 10, 0x05)
            myMemset(10, 10, 0x08)
            let buf = new Uint8Array(mem.buffer, 0, 20);
            console.log('buf', buf)
        })
    })
})

describe('test myQuickSort', function() {
    let mem = new WebAssembly.Memory({initial: 1})
    let raw_values = [5,6,7,8,0,-1,3,4]
    let i32Array = new Int32Array(mem.buffer, 0, raw_values.length)
    for (let i in raw_values) {
        i32Array[i] = raw_values[i]
    }
    LoadWasm({mem: {mem: mem}, log: {logI32: LogI32, LogSplit: LogSplit}}).then(wasmModule => {
        const { partition } = wasmModule.instance.exports;
        it('myQS', function() {
            console.log('raw array', i32Array)
            let p = partition(0, raw_values.length - 1)
            console.log('sorted array', i32Array, p)
        })
    })
})
