#include "ram.h"

#define a 0
#define b 10

void loop_add_4_6_iters(RAM_2<int, 16>* ram) {
  for (int i = 0; i < 6; i++) {
    ram->write_0(a + i, ram->read_0(b + i) + 4);
  }
}
