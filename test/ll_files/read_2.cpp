#include "ram.h"

#define a 0
#define b 3

void read_2(RAM<int, 16>* ram) {
  ram->write(b, ram->read(a + 2));
}
