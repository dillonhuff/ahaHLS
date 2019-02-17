#include "ram.h"

#define a 0
#define b 3
#define c 4

void if_else(RAM_2<int, 16>* ram) {
  //int* __restrict a, int* __restrict b, int* __restrict c) {
  //if (c[0] == 3) {
  if (ram->read_1(c) == 3) {
    ram->write_0(a, ram->read_0(b));
    //a[0] = b[0];
  }
}
