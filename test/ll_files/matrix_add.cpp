#include "ram.h"

#define NROWS 16
#define NCOLS 16

void matrix_add(RAM<int, 32>* a, RAM<int, 32>* b, RAM<int, 32>* c) {

  for (int i = 0; i < NROWS; i++) {
    for (int j = 0; j < NCOLS; j++) {
      int av = a->read(i*NROWS + j);
      int bv = b->read(i*NROWS + j);
      c->write(i*NROWS + j, av + bv);
    }
  }
}
