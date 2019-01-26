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

//float builtin_fadd(adder* const fpu, const float a, const float b) {
float builtin_fadd(adder* const fpu, Fifo<float, 10>* a, Fifo<float, 10>* b) {
  int af = bitCastToInt(a->read());

  cout << "af = " << af << endl;
  
  int bf = bitCastToInt(b->read());

  cout << "bf = " << bf << endl;

  fpu->rst = 1;

  POSEDGE(fpu);

  fpu->rst = 0;
  fpu->input_a = af;
  fpu->input_a_stb = 1;

  while (fpu->input_a_ack != 1) {
    POSEDGE(fpu);
  }

  cout << "input_a_ack = " << (int) fpu->input_a_ack << endl;

  assert(fpu->input_a_ack == 1);

  fpu->input_b = bf;
  fpu->input_b_stb = 1;

  POSEDGE(fpu);

  fpu->input_a_stb = 0;

  while (fpu->input_b_ack != 1) {
    POSEDGE(fpu);
  }
  
  cout << "input_a_ack = " << (int) fpu->input_a_ack << endl;
  cout << "input_b_ack = " << (int) fpu->input_b_ack << endl;

  assert(fpu->input_b_ack == 1);

  while (fpu->output_z_stb != 1) {
    POSEDGE(fpu);
  }
  
  assert(fpu->output_z_stb == 1);
  return bitCastToFloat(fpu->output_z);
}

int main() {
  adder fpu0;
  // float a = 10.0;
  // float b = 23.6;

  Fifo<float, 10> a;
  a.write(10.0);

  Fifo<float, 10> b;
  b.write(23.6);

  float result = builtin_fadd(&fpu0, &a, &b);


  cout << "result = " << result << endl;

  float aVal = 10.0;
  float bVal = 23.6;
  assert((aVal + bVal) == result);
}
