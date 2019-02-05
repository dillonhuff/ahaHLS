#include "reduce_4.h"

#include <assert.h>
#include <stdio.h>

int main() {
  builtin_fifo_32 in = builtin_build_fifo_32();
  builtin_fifo_32 out = builtin_build_fifo_32();    

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
