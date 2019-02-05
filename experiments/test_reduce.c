#include "reduce_4.h"

typedef builtin_fifo_32 fifo;

#include <assert.h>
#include <stdio.h>

int main() {
  fifo in, out;
  init_builtin_fifo_32(&in);
  init_builtin_fifo_32(&out);

  builtin_write_fifo_32(1, &in);
  builtin_write_fifo_32(4, &in);
  builtin_write_fifo_32(2, &in);
  builtin_write_fifo_32(9, &in);

  reduce_4(&in, &out);

  int result = builtin_read_fifo_32(&out);

  printf("result == %d\n", result);
  assert(result == (1 + 4 + 2 + 9));
}
