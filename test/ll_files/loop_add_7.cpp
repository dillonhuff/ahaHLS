#include "ram.h"

#define a 0
#define b 10

void loop_add_7(RAM<int, 16>* ram) { //int* __restrict a, int* __restrict b) {
  for (int i = 0; i < 10; i++) {
    ram->write(a + i, ram->read(b + i) + 7);
    //a[i] = b[i] + 7;
  }
}
