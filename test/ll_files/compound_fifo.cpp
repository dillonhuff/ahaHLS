#include "fifo.h"

template<typename T, int width>
class bus {
  T elems[width];
  
public:

  T get(const int i) {
    return elems[i];
  }

  void set(const int i, const T& val) {
    elems[i] = val;
  }

};

void compound_fifo(DHLS::Fifo<bus<int, 8>, 16>* in,
                   DHLS::Fifo<int, 16>* out) {
  bus<int, 8> b = in->read();

  int sum = 0;
  for (int i = 0; i < 8; i++) {
    sum += b.get(i);
  }

  out->write(sum);
}
