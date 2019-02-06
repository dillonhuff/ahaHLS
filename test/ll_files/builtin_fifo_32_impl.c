#include "reduce_4.h"

void builtin_write_fifo_32(int val, builtin_fifo_32* out) {
  out->buffer[out->write_addr] = val;
  out->write_addr = (out->write_addr + 1) % FIFO_SIZE;
  out->empty = 0;
}

int builtin_read_fifo_32(builtin_fifo_32* in) {
  assert(!in->empty);

  printf("reading address %d\n", in->read_addr);
  
  int res = in->buffer[in->read_addr];
  in->read_addr = (in->read_addr + 1) % FIFO_SIZE;

  if (in->read_addr == in->write_addr) {
    in->empty = 1;
  }

  return res;
}  

void init_builtin_fifo_32(builtin_fifo_32* buf) {
  buf->read_addr = 0;
  buf->write_addr = 0;
  buf->empty = 1;
}

void reduce_4(builtin_fifo_32* in, builtin_fifo_32* out);

builtin_fifo_32 builtin_build_fifo_32() {
  builtin_fifo_32 f;
  init_builtin_fifo_32(&f);
  return f;
}

