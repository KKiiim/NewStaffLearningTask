// The entry file of your WebAssembly module.

export function myAbs(a: i32): i32 {
  return (a < 0) ? -a : a;
}

export function myMemset(buf: ArrayBuffer, byte: u8): ArrayBuffer {
  let arr: Int8Array = Int8Array.wrap(buf)
  arr.fill(byte)
  return arr.buffer
}

export function myGetsum(a: i32): i64 {
  let res: i64 = 0
  while (a > 0) {
    res += i64(a)
    a -= 1
  }
  return res;
}

export function partition(arrbuf: ArrayBuffer, start: i32, end: i32): i32 {
  let arr = Int32Array.wrap(arrbuf)
  let pivot: i32 = start
  while(end > start) {
    while (end > start) {
      if (arr[end] < arr[pivot]) {
        break
      } else {
        end -= 1
      }
    }
    while (end > start) {
      if (arr[start] > arr[pivot]) {
        break
      } else {
        start += 1
      }
    }
    let tmp:i32 = arr[start]
    arr[start] = arr[end]
    arr[end] = tmp
  }
  let tmp: i32 = arr[start]
  arr[start] = arr[pivot]
  arr[pivot] = tmp
  return start
}

export function myQuickSort(arr: Int32Array, start: i32, end: i32): Int32Array {
  if (end <= start) {
    return arr
  }
  let pivot: i32 = partition(arr.buffer, start, end);
  myQuickSort(arr, start, pivot - 1)
  myQuickSort(arr, pivot + 1, end)
  return arr
}
