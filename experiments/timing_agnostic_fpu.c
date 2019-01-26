struct builtin_fifo_32;
struct adder;

typedef struct builtin_fifo_32 builtin_fifo_32;
typedef struct adder adder;

#include <stdint.h>

typedef uint8_t bit;

int builtin_read_fifo_32(builtin_fifo_32* a);
void builtin_write_fifo_32(int f, builtin_fifo_32* a);

void builtin_write_port_rst(adder* a, bit val);

void builtin_write_port_input_a_stb(adder* a, bit val);
void builtin_write_port_input_b_stb(adder* a, bit val);

void builtin_write_port_input_a(adder* a, int val);
void builtin_write_port_input_b(adder* a, int val);

int builtin_read_port_output_z(adder* a);

void builtin_fadd(adder* const fpu,
                  builtin_fifo_32* a,
                  builtin_fifo_32* b,
                  builtin_fifo_32* c) {
  int af = builtin_read_fifo_32(a);
  int bf = builtin_read_fifo_32(b);  

  builtin_write_port_rst(fpu, 1);

  builtin_write_port_rst(fpu, 0);

  builtin_write_port_input_a(fpu, af);
  builtin_write_port_input_a_stb(fpu, 1);

  builtin_write_port_input_b(fpu, bf);
  builtin_write_port_input_b_stb(fpu, 1);

  int result = builtin_read_port_output_z(fpu);
  builtin_write_fifo_32(result, c);
}
