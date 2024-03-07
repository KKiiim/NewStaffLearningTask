# NewStaffLearningTask  
  
**Tip: Add clangd extension in vscode for code formatting**

## Arm Assembly language

1. differentiate QEMU in user-mode and system-mode
2. setup coding environment with aarch64-linux-gnu and qemu
3. implement functions with arm64 assembly language:  
**cross-compiling: caller in main with C and callee functions with Assembly**   
>     abs(Absolute value)  
>     memset  
>     getSum(Calculate the sum from 0 to n)  
>     QuickSort algorithm   
4. add googleTest for the functions above with CMakeLists
5. add CI pipeline in your github repo

## WebAssembly

1. learn wasm and wat(WebAssembly Text Format)  
   "https://webassembly.github.io/spec/core/text/index.html" is worthy of reference
2. learn wasm toolchain like wasm2wat, wat2wasm,
3. implement functions with  WebAssembly language:  
 **caller webassembly module instance with typescript and callee functions with WAT**  
>     abs(Absolute value)  
>     memset  
>     getSum(Calculate the sum from 0 to n)  
>     QuickSort algorithm  
4. add mocha-test and CI pipeline  
**Tips: You can debug wasm with Chrome DevTools**  

## AssemblyScript

1. reference: https://www.assemblyscript.org/introduction.html#from-a-webassembly-perspective
2. implement functions:   
>     abs(Absolute value)  
>     memset  
>     getSum(Calculate the sum from 0 to n)  
>     QuickSort algorithm  
3. add test and CI pipeline  

## Tools  
[Compile online](https://godbolt.org/) compile you code in different platform with different compiler  

## Optional Learning Tutorials    
[Cmake](https://subingwen.cn/cmake/CMake-primer/index.html) learn how to use the cmake toolchain to compile a project.  
[Node.js](https://cloud.tencent.com/developer/article/1037475 ) help to understanding the underlying principles of Node.js.  
[Linker](https://jia.je/software/2023/05/06/linker/)  learn how the linker process works.  



>
> 
# Some SmallBUTBeautiful Programming Questions  
### Thread synchronization (state machines)  
  There are three kinds of threads:  
  Thread1 dead-loop to print the character '<'  
  Thread2 dead-loop to print the character '>'  
  Thread3 dead-loop to print the character ' '  
  Synchronize these threads, so that the terminal prints the combination of '<>< ' and '><> '.  
  Like two small fish with different tail orientations.
