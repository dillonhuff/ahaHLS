#include "ac_channel.h"

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

void compound_fifo(ac_channel<bus<int, 8> >* in,
                   ac_channel<int>* out) {
  bus<int, 8> b = in->read();

  int sum = 0;
  for (int i = 0; i < 8; i++) {
    sum += b.get(i);
  }

  out->write(sum);
}
