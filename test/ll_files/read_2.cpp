#include "ram.h"

#define a 0
#define b 3

void read_2(RAM_2<int, 16>* ram) {
  ram->write_0(b, ram->read_0(a + 2));
}
