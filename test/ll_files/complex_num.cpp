#include "ram.h"

class complex {
public:
  int real;
  int imag;
};

complex operator+(const complex& a, const complex& b) {
  return {a.real + b.real, a.imag + b.imag};
}

void complex_num(RAM<complex, 16>* ram) {
  complex a = ram->read(0);
  complex b = ram->read(1);

  ram->write(3, a + b);
}
