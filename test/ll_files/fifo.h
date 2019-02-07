#pragma once

#include <cassert>

namespace DHLS {

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

    void write(T value) {

      buffer[waddr] = value;
      waddr = (waddr + 1) % depth;
      empty = 0;

    }
  };

}
