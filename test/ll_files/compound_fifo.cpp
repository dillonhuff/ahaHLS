#include <cassert>

template<typename T, int depth>
class Fifo {
  T buffer[depth];
  int raddr;
  int waddr;
  bool empty;
  
public:

  Fifo() {
    raddr = 0;
    waddr = 0;
    empty = 1;
  }

  T read() {
    assert(!empty);
    T value = buffer[raddr];
    raddr = (raddr + 1) % depth;

    if (raddr == waddr) {
      empty = 1;
    }
    return value;
  }

  void write(T& value) {

    buffer[waddr] = value;
    waddr = (waddr + 1) % depth;
    empty = 0;

  }
};

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

void compound_fifo(Fifo<bus<int, 8>, 16>* in,
                   Fifo<int, 16>* out) {
  bus<int, 8> b = in->read();

  int sum = 0;
  for (int i = 0; i < 8; i++) {
    sum += b.get(i);
  }

  out->write(sum);
}
