#include "ram.h"

void single_store(RAM<int, 16>* a) {
  a->write(0, 5);
}
