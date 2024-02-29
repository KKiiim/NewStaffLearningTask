
const fs = require('node:fs');
const assert = require('assert')

function LoadWasm(){
    const wasmBuffer = fs.readFileSync('./wasm.wasm');
    return WebAssembly.instantiate(wasmBuffer)
}

describe('test myAbs', function() {
    LoadWasm().then(wasmModule => {
        const { myAbs } = wasmModule.instance.exports;
        it('myAbs(-5)', function() {
            assert.equal(myAbs(-5), 5)
            assert.equal(myAbs(0), 0)
            assert.equal(myAbs(35), 35)
        })
    })
})

