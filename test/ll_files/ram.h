#pragma once

template<typename T, int depth>
class RAM {
  T elems[depth];
  
public:

  T read(int addr) {
    return elems[addr];
  }

  void write(const int addr, const T value) {
    elems[addr] = value;
  }
};

template<typename T, int depth>
class RAM_2 {
  T elems[depth];
  
public:

  T read_0(int addr) {
    return elems[addr];
  }

  T read_1(int addr) {
    return elems[addr];
  }
  
  void write_0(const int addr, const T value) {
    elems[addr] = value;
  }
};
