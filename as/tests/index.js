import assert from "assert";
import { myAbs, myMemset, myGetsum, myQuickSort, partition } from "../build/debug.js";

function AssertMemset(buf, start, end, byte) {
    let arr = new Int8Array(buf);
    while (start <= end) {
        if (arr[start] != byte) {
            return false
        }
        start += 1
    }
    return true
}

function AssertQS(arr, start, end) {
    let min = arr[start]
    while (start <= end) {
        if (arr[start] < min) {
            return false
        }
        start += 1
        min = arr[start]
    }
    return true
}



assert.equal(myAbs(-10), 10);
assert.equal(myAbs(0), 0);
assert.equal(myAbs(3), 3);

assert.equal(myGetsum(5), 15)
assert.equal(myGetsum(10), 55)

let buf = new ArrayBuffer(10)
AssertMemset(buf, 0, 9, 0x00)
buf = myMemset(buf, 0x03)
assert.equal(AssertMemset(buf, 0, 9, 0x03), true)

let raw = new Int32Array([5,3,6,7,29,5,0,-2,3])
let arrbuf = new ArrayBuffer(raw.length * 4)
arrbuf = myMemset(arrbuf, 0x05)
let arr = new Int32Array(arrbuf)
for (let i in raw) {
    arr[i] = raw[i]
}
arr = myQuickSort(arr, 0, arr.length - 1)
assert.equal(AssertQS(arr, 0, arr.length - 1), true)
console.log("ok");
