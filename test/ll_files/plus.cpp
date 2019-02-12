#include "ram.h"

void plus(RAM_2<int, 16>* mem) {
  mem->write_0(4, mem->read_0(0) + mem->read_1(3));
}
