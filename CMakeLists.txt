cmake_minimum_required(VERSION 3.15)
project(test-arm64-asm)


set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/output/)

# 设置交叉编译工具链和编译选项
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# 设置交叉编译工具链路径
set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++)

# 设置编译选项
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Og")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Og")

# 设置汇编文件和C文件的路径
set(ASM_SOURCE ${HOME}/arm64asm.s)
set(C_SOURCE ${HOME}/src/qsort.cpp)

# 将汇编文件和C文件编译为对象文件
enable_language(ASM)


# 链接对象文件生成可执行文件
add_executable(arm64asm_test
  arm64asm.s
  googleTest.cc
)

enable_testing()
target_link_libraries(arm64asm_test
    gtest
    gtest_main
    pthread
)

add_test(
    NAME arm64asm_test
    COMMAND "qemu-aarch64" -L /usr/aarch64-linux-gnu ./output/arm64asm_test
)
