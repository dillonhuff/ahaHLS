typedef unsigned char bool;

#include <assert.h>
#include <stdio.h>

#define FIFO_SIZE 32

typedef struct {
  int buffer[FIFO_SIZE];

  int read_addr;
  int write_addr;
  bool empty;
  
} builtin_fifo_32;


static inline
void builtin_write_fifo_32(int val, builtin_fifo_32* out) {
  out->buffer[out->write_addr] = val;
  out->write_addr = (out->write_addr + 1) % FIFO_SIZE;
  out->empty = 0;
}

static inline
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

static inline
void init_builtin_fifo_32(builtin_fifo_32* buf) {
  buf->read_addr = 0;
  buf->write_addr = 0;
  buf->empty = 1;
}

void reduce_4(builtin_fifo_32* in, builtin_fifo_32* out);
