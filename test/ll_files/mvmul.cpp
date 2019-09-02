#include "ram.h"

#define a 0
#define b 9
#define c 12

void mvmul(RAM_3<int, 32>* ram) {
  for (int i = 0; i < 3; i++) {
    int cval = 0;
    for (int j = 0; j < 3; j++) {
      cval += ram->read_1(a + i*3 + j) * ram->read_2(b + j);
    }

    ram->write_0(c + i, cval);
  }
}
