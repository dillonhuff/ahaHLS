#include "reduce_4.h"

void reduce_4(builtin_fifo_32* in, builtin_fifo_32* out) {
  int sum = 0;
  for (int i = 0; i < 4; i++) {
    sum += builtin_read_fifo_32(in);
  }

  builtin_write_fifo_32(sum, out);
}
