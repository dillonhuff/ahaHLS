#include "verilated.h"
#include "Vadder.h"

typedef Vadder adder;

#define POSEDGE(fpu) (fpu)->clk = 0; (fpu)->eval(); (fpu)->clk = 1; (fpu)->eval();

#include <iostream>

using namespace std;

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

float builtin_fadd(adder* const fpu, const float a, const float b) {
  int af = bitCastToInt(a);

  cout << "af = " << af << endl;
  
  int bf = bitCastToInt(b);

  cout << "bf = " << bf << endl;

  fpu->rst = 1;

  POSEDGE(fpu);

  fpu->rst = 0;
  fpu->input_a = af;
  fpu->input_a_stb = 1;

  POSEDGE(fpu);

  cout << "input_a_ack = " << (int) fpu->input_a_ack << endl;

  assert(fpu->input_a_ack == 1);


  fpu->input_b = bf;
  fpu->input_b_stb = 1;

  POSEDGE(fpu);

  fpu->input_a_stb = 0;
  
  cout << "input_a_ack = " << (int) fpu->input_a_ack << endl;
  cout << "input_b_ack = " << (int) fpu->input_b_ack << endl;

  POSEDGE(fpu);

  cout << "input_b_ack = " << (int) fpu->input_b_ack << endl;

  assert(fpu->input_b_ack == 1);

  for (int i = 0; i < 100; i++) {
    POSEDGE(fpu);

    cout << "Posedge" << endl;

    if (fpu->output_z_stb) {
      break;
    }
  }
  
  assert(fpu->output_z_stb == 1);
  return bitCastToFloat(fpu->output_z);
}

int main() {
  adder fpu0;
  float a = 10.0;
  float b = 23.6;
  float result = builtin_fadd(&fpu0, a, b);

  cout << "a      = " << a << endl;
  cout << "result = " << result << endl;
}
