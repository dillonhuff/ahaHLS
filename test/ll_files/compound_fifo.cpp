// Problem: What should the definition of
// read() be for compound types? We cannot
// just do a builtin port read off of
// the output port of the FIFO, or can we? I guess
// the output of the FIFO is a wire of width sizeof(T)
// and the given T has some copy constructor, and the
// caller will allocate a T, pass in a pointer to that
// T and then the copy constructor will get called on *copy?

// From the POV of the hardware what is going to happen?
// Is the read data going to come out on a bus of width sizeof(T)
// and just be copied to the allocated struct, or should something
// more general happen? What does the template parameter for the
// underlying buffer type mean for the port list of the FIFO?

// Option: The port list of the FIFO varies based on the value
// of the template parameter T. A call to read represents a
// "read" module that takes in the data ports of the FIFO itself
// as well as the data ports of the caller module representing
// the FIFO and then executes the default copy constructor?

// Where do ready and valid fit in to this? I guess the
// copy constructor is started as soon as the valid and ready
// are both set to 1?


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
    //assert(!empty);
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
