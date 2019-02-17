#include "ram.h"

#define a 0
#define b 3
#define c 4

void if_else(RAM_2<int, 16>* ram) {
  if (ram->read_0(c) == 3) {
    ram->write_0(a, ram->read_0(b));
  }
}
