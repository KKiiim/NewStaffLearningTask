#pragma once
extern "C" {
#include <stdint.h>

uint64_t myAbs(int64_t x);
int myMemset(void *addr, int bytes, uint8_t c);
uint64_t myGetSum(uint32_t n);
int myQuickSort(int *array, int start, int end);
int partition(int *array, int start, int end);

}
