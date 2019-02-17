#include "ram.h"

#define a 0
#define b 10

void loop_add_4(RAM<int, 16>* ram) {
  for (int i = 0; i < 2; i++) {
    ram->write(a + i, ram->read(b + i) + 4);
  }
}
