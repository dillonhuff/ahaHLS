#include "verilated.h"
#include "Vadder.h"

#include <vector>

typedef Vadder adder;

#define POSEDGE(fpu) (fpu)->clk = 0; (fpu)->eval(); (fpu)->clk = 1; (fpu)->eval();

#include <iostream>

using namespace std;

class AddWrapper {

  adder innerMod;

public:
  AddWrapper() {
    innerMod.rst = 0;
    POSEDGE(&innerMod);
    innerMod.rst = 1;
    POSEDGE(&innerMod);
    innerMod.rst = 0;
    POSEDGE(&innerMod);    
  }

  int add(int a, int b) {
    cout << "a ack ? " << (int) innerMod.input_a_ack << endl;
      
    // POSEDGE(&innerMod);

    // cout << "a ack ? " << (int) innerMod.input_a_ack << endl;

    // if (innerMod.input_a_ack == 1) {
    //   POSEDGE(&innerMod);
    // } else {
    //   do {
    //     POSEDGE(&innerMod);
    //     cout << "a ack ? " << (int) innerMod.input_a_ack << endl;
    //   } while (!innerMod.input_a_ack);
    // }

    innerMod.input_a_stb = 1;
    innerMod.input_b_stb = 0;
    innerMod.output_z_ack = 0;    

    innerMod.input_a = a;

    // do {
    //   cout << "in loop pre pos b ack ? " << (int) innerMod.input_b_ack << endl;
    //   POSEDGE(&innerMod);
    //   cout << "in loop b ack ? " << (int) innerMod.input_b_ack << endl;

    // } while (!innerMod.input_a_ack);
    
    while (!innerMod.input_a_ack) {
      cout << "in loop pre pos b ack ? " << (int) innerMod.input_b_ack << endl;
      POSEDGE(&innerMod);
      cout << "in loop b ack ? " << (int) innerMod.input_b_ack << endl;
    }

    POSEDGE(&innerMod);
    
    cout << "b ack ? " << (int) innerMod.input_b_ack << endl;
    
    cout << "a ack ? " << (int) innerMod.input_a_ack << endl;
    cout << "b ack ? " << (int) innerMod.input_b_ack << endl;

    innerMod.input_b_stb = 1;
    innerMod.input_b = b;

    while (!innerMod.input_b_ack) {
      //cout << "Waiting on b ack" << endl;
      POSEDGE(&innerMod);
    }

    while (!innerMod.output_z_stb) {
      POSEDGE(&innerMod);
    }

    assert(innerMod.output_z_stb);
    
    
    return innerMod.output_z;
  }
};



template<typename T, int Size>
class Fifo {
  std::vector<T> elems;
  int readPtr;
  int writePtr;
  bool empty;
  
public:

  Fifo() : readPtr(0), writePtr(0), empty(true) {
    elems.resize(Size);
  }

  void write(T value) {
    elems[writePtr] = value;
    writePtr = (writePtr + 1) % Size;
    empty = false;
  }

  T read() {
    assert(!empty);

    T res = elems[readPtr];
    readPtr = (readPtr + 1) % Size;

    if (readPtr == writePtr) {
      empty = true;
    }

    return res;
  }
};

int bitCastToInt(const float a) {
  void* p = (void*) (&a);
  int* ap = (int*) p;
  return *ap;
}

float bitCastToFloat(const int a) {
  void* p = (void*) (&a);
  float* ap = (float*) p;
  return *ap;
}

typedef Fifo<float, 10> builtin_fifo_32;
typedef uint8_t bit;

int builtin_read_fifo_32(builtin_fifo_32* a) {
  return bitCastToInt(a->read());
}

void builtin_write_fifo_32(int val, builtin_fifo_32* a) {
  return a->write(bitCastToFloat(val));
}

void builtin_write_port_rst(adder* fpu, bit a) {
  assert((a == 0) || (a == 1));

  fpu->rst = a;
}

void builtin_write_port_input_a_stb(adder* fpu, bit a) {
  assert((a == 0) || (a == 1));

  fpu->input_a_stb = a;
}

void builtin_write_port_input_b_stb(adder* fpu, bit a) {
  assert((a == 0) || (a == 1));

  fpu->input_b_stb = a;
}

void builtin_write_port_input_b(adder* fpu, int a) {
  fpu->input_b = a;
}

void builtin_write_port_input_a(adder* fpu, int a) {
  fpu->input_a = a;
}

int builtin_read_port_output_z(adder* fpu) {
  return fpu->output_z;
}

// END of software definitions for hardware builtins

// Goal is for this function to be implemented using builtin read and write
// port functions, and then to have those implemented in verilator in software
// with stalls inserted where necessary and as primitives in hardware. The HLS
// compiler will have 2 modes. It will be able to compile the function from
// builtin port and fifo calls in to a simulator binding version in C++ for
// software testing, or in to a synthesized piece of hardware for use in HLS

// Q: Where will I add the scheduling metadata?
void builtin_fadd(adder* const fpu,
                  builtin_fifo_32* a,
                  builtin_fifo_32* b,
                  builtin_fifo_32* c) {
  int af = builtin_read_fifo_32(a);
  int bf = builtin_read_fifo_32(b);  

  builtin_write_port_rst(fpu, 1);

  POSEDGE(fpu);

  builtin_write_port_rst(fpu, 0);

  builtin_write_port_input_a(fpu, af);
  builtin_write_port_input_a_stb(fpu, 1);

  while (fpu->input_a_ack != 1) {
    POSEDGE(fpu);
  }

  assert(fpu->input_a_ack == 1);

  builtin_write_port_input_b(fpu, bf);
  builtin_write_port_input_b_stb(fpu, 1);

  POSEDGE(fpu);

  while (fpu->input_b_ack != 1) {
    POSEDGE(fpu);
  }
  
  assert(fpu->input_b_ack == 1);

  while (fpu->output_z_stb != 1) {
    POSEDGE(fpu);
  }
  
  assert(fpu->output_z_stb == 1);

  int result = builtin_read_port_output_z(fpu);
  builtin_write_fifo_32(result, c);
}

int main() {
  adder fpu0;

  Fifo<float, 10> a;
  a.write(10.0);

  Fifo<float, 10> b;
  b.write(23.6);

  Fifo<float, 10> c;
  
  builtin_fadd(&fpu0, &a, &b, &c);
  float result = c.read();

  cout << "result = " << result << endl;

  float aVal = 10.0;
  float bVal = 23.6;
  assert((aVal + bVal) == result);

  AddWrapper wrap;
  int wrapRes = wrap.add(bitCastToInt(aVal), bitCastToInt(bVal));
  cout << "WrapRes = " << bitCastToFloat(wrapRes) << endl;
  cout << "av + bv = " << aVal + bVal << endl;
  assert(bitCastToFloat(wrapRes) == aVal + bVal);
}
