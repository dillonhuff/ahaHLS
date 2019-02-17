#include "ram.h"

#define a 0
#define b 1
#define c 2
#define d 3

void many_adds(RAM_3<int, 16>* ram) {
  //int* __restrict a, int* __restrict b, int* __restrict c, int* __restrict d) {
  ram->write(d, ram->read_0(a) + ram->read_1(b) + ram->read_2(c));
  //d[0] = a[0] + b[0] + c[0];
}
