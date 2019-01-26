#include "verilated.h"
#include "Vadder.h"

#include <vector>

typedef Vadder adder;

#define POSEDGE(fpu) (fpu)->clk = 0; (fpu)->eval(); (fpu)->clk = 1; (fpu)->eval();

#include <iostream>

using namespace std;

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

// Goal is for this function to be implemented using builtin read and write
// port functions, and then to have those implemented in verilator in software
// with stalls inserted where necessary and as primitives in hardware. The HLS
// compiler will have 2 modes. It will be able to compile the function from
// builtin port and fifo calls in to a simulator binding version in C++ for
// software testing, or in to a synthesized piece of hardware for use in HLS

// Q: Where will I add the scheduling metadata?
void builtin_fadd(adder* const fpu, Fifo<float, 10>* a, Fifo<float, 10>* b, Fifo<float, 10>* c) {
  int af = bitCastToInt(a->read());
  int bf = bitCastToInt(b->read());

  fpu->rst = 1;

  POSEDGE(fpu);

  fpu->rst = 0;
  fpu->input_a = af;
  fpu->input_a_stb = 1;

  while (fpu->input_a_ack != 1) {
    POSEDGE(fpu);
  }

  assert(fpu->input_a_ack == 1);

  fpu->input_b = bf;
  fpu->input_b_stb = 1;

  POSEDGE(fpu);

  fpu->input_a_stb = 0;

  while (fpu->input_b_ack != 1) {
    POSEDGE(fpu);
  }
  
  assert(fpu->input_b_ack == 1);

  while (fpu->output_z_stb != 1) {
    POSEDGE(fpu);
  }
  
  assert(fpu->output_z_stb == 1);

  c->write(bitCastToFloat(fpu->output_z));
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
}
