#include "arm64asm.h"
#include <cstdint>
#include <stdlib.h>
#include <gtest/gtest.h>

TEST(myAbs, BasicAssertions) {
  EXPECT_EQ(myAbs(-8), 8);
  EXPECT_EQ(myAbs(-4294967296), 4294967296);
  EXPECT_EQ(myAbs(8), 8);
  EXPECT_EQ(myAbs(0), 0);
  EXPECT_EQ(myAbs(4294967296), 4294967296);
}

bool AssertMemset(void *p, int count, uint8_t pattern) {
    uint8_t *buf = (uint8_t*)p;
    for (int i = 0; i < count; i ++) {
        if (buf[i] != pattern) {
            return false;
        }
    }
    return true;
}

TEST(myMemset, BasicAssertions) {
    void *buffer = malloc(1024*1024*32);
    EXPECT_EQ(myMemset(buffer, 8, 0), 8);
    EXPECT_PRED3(AssertMemset, buffer, 8, 0);
    EXPECT_EQ(myMemset(buffer, 1024*1024*32, 0), 1024*1024*32);
    EXPECT_PRED3(AssertMemset, buffer, 1024*1024*32, 0);
    free(buffer);
}

void PrintArray(int32_t *array, int counts) {
    for (int i = 0; i < counts; i ++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}

void PrintArray2(int32_t *array, int begin, int end) {
    for (int i = begin; i <= end; i ++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}

bool AssertSort(int32_t *array, int counts) {
    int32_t temp = array[0];
    PrintArray(array, counts);
    for (int i = 1; i < counts; i ++) {
        if (array[i] < temp) {
            printf("assert failed, arr[%d]=%d < arr[%d] = %d\n", i, array[i], i - 1, temp);
            return false;
        }
        temp = array[i];
    }
    return true;
}


TEST(myGetSum, BasicAssertions) {
    EXPECT_EQ(myGetSum(0), 0);
    EXPECT_EQ(myGetSum(10), 55);
    EXPECT_EQ(myGetSum(256), 32896);
    EXPECT_EQ(myGetSum(16384), 134225920);
    EXPECT_EQ(myGetSum(4294967295), 9223372034707292160);
}



TEST(myQuickSort, BasicAssertions) {
    int raw[] = {6, 7, 8, 9, 0, 2, 3, 1, 4, 5};
    int32_t raw_len = sizeof(raw) / sizeof(int32_t);
    printf("array[%d]: ", raw_len);
    PrintArray(raw, raw_len);
    myQuickSort(raw, 0, raw_len - 1);
    printf("after sort: ");
    EXPECT_PRED2(AssertSort, (int*)raw, raw_len);
}