#include "rams.h"

void trmvmul(RAM<int, 16*16>* M, ram<int, 16>* x, ram<int, 16>* y) {
  for (int r = 0; r < 16; r++) {
    int sum = 0;
    for (int c = 0; c < r; c++) {
      sum += M->read(r*NCOLS + c)* x->read(c);
    }

    y->write(r*NCOLS + c, sum);
  }
}
