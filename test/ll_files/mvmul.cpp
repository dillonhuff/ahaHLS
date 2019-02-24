#include "ram.h"

#define a 0
#define b 9
#define c 12

void mvmul(RAM_3<int, 32>* ram) {
  for (int i = 0; i < 3; i++) {
    ram->write_0(c + i, 0);
    //c[i] = 0;
    for (int j = 0; j < 3; j++) {
      //c[i] += a[i*3 + j] * b[j];
      ram->write_0(c + i, ram->read_0(a + i*3 + j) * ram->read_1(b + j));
    }
  }
}
