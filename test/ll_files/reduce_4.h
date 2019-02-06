// Compile calls: clang -S -emit-llvm -O1 -c -D__SYNTHESIS__ experiments/reduce_4.c
// clang ./experiments/test_reduce.c ./experiments/reduce_4.c 

#ifndef __SYNTHESIS__

typedef unsigned char bool;

#define FIFO_SIZE 32

typedef struct {
  int buffer[FIFO_SIZE];
  int read_addr;
  int write_addr;
  bool empty;
} builtin_fifo_32;

#else

struct builtin_fifo_32;
typedef struct builtin_fifo_32 builtin_fifo_32;

#endif

int builtin_read_fifo_32(builtin_fifo_32* in);
void builtin_write_fifo_32(int val, builtin_fifo_32* out);
builtin_fifo_32 builtin_build_fifo_32();
