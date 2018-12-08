#include <iostream>
#include <deque>
#include <vector>

using namespace std;

#define IN_DIM 8
#define OUT_DIM (IN_DIM - 2)
#define KERNEL_DIM 3

#define ARR(a, i, j, stride) (a)[(i)*(stride) + (j)]
#define GET_A(a, i, j) ARR((a), (i), (j), IN_DIM)
#define GET_K(a, i, j) ARR((a), (i), (j), KERNEL_DIM)
#define GET_O(a, i, j) ARR((a), (i), (j), OUT_DIM)

void conv_3_3(const int* __restrict in,
              const int* __restrict kernel,
              int* __restrict out) {

  for (int i = 1; i < IN_DIM - 1; i++) {
    for (int j = 1; j < IN_DIM - 1; j++) {
      int top_row = GET_K(kernel, 0, 0)*GET_A(in, i - 1, j - 1) +
        GET_K(kernel, 0, 1)*GET_A(in, i - 1, j) +
        GET_K(kernel, 0, 2)*GET_A(in, i - 1, j + 1);

      int mid_row = GET_K(kernel, 1, 0)*GET_A(in, i, j - 1) +
        GET_K(kernel, 1, 1)*GET_A(in, i, j) +
        GET_K(kernel, 1, 2)*GET_A(in, i, j + 1);

      int low_row = GET_K(kernel, 2, 0)*GET_A(in, i + 1, j - 1) +
        GET_K(kernel, 2, 1)*GET_A(in, i + 1, j) +
        GET_K(kernel, 2, 2)*GET_A(in, i + 1, j + 1);

      GET_O(out, i - 1, j - 1) = top_row + mid_row + low_row;
    }
  }
}

template<typename OutType>
class Stream {
public:
  deque<OutType> tp;

  OutType readsLeft() {
    return false;
  }

  OutType read() {
    auto next = tp.back();
    tp.pop_back();
    return next;
  }

  void write(OutType val) {
    auto next = tp.push_back(val);
  }

};

template<typename T, int rowLength, int numRows>
class LineBuffer {
public:
  //vector<T> mem;
  T mem[rowLength * numRows + 3];
  int readPtr;
  int writePtr;
  int ramSize;

  bool isFull;

  LineBuffer() {
    readPtr = 0;
    writePtr = 0;
    ramSize = rowLength*numRows + 3;
    
    // for (int i = 0; i < rowLength; i++) {
    //   for (int j = 0; j < numRows; j++) {
    //     mem.push_back(0);
    //   }
    // }
  }

  T read(int a, int c) {
    return 0;
  }

  void write(const T input) {
    mem[writePtr] = input;
    writePtr++;
  }

  bool full() const {
    return true;
  }

  bool empty() const {
    return true;
  }

};

template<typename T, int r, int c>
class RAMShape {
public:

  T operator()(int ri, int ci) {
  }
};

// So: Is this supposed to run inside something else?
void conv_3_3_lb(Stream<int>& in, Stream<int>& kernel, Stream<int>& out) {
  LineBuffer<int, IN_DIM, KERNEL_DIM> lb;

  RAMShape<int, KERNEL_DIM, KERNEL_DIM> k;

  // Load kernel to constant

  // Fill 
  while (!lb.full()) {
    lb.write(in.read());
  }

  // Steady state, data coming in to the linebuffer
  while (in.readsLeft()) {

    int top =
      lb.read(-1, -1)*k(-1, -1) + lb.read(-1, 0)*k(-1, 0) + lb.read(-1, 1)*k(-1, 1);
    int mid =
      lb.read(0, -1)*k(0, -1) + lb.read(0, 0)*k(0, 0) + lb.read(0, 1)*k(0, 1);
    int bot =
      lb.read(1, -1)*k(1, -1) + lb.read(1, 0)*k(1, 0) + lb.read(1, 1)*k(1, 1);

    int res = top + mid + bot;

    out.write(res);
    lb.write(in.read());
  }

  // Drain, linebuffer is 
  while (!lb.empty()) {
  }

}


int main() {
  int* in = (int*) malloc(sizeof(int)*IN_DIM*IN_DIM);
  for (int i = 0; i < IN_DIM; i++) {
    for (int j = 0; j < IN_DIM; j++) {
      GET_A(in, i, j) = i + j;
    }
  }

  int* kernel = (int*) malloc(sizeof(int)*(KERNEL_DIM*KERNEL_DIM));
  for (int i = 0; i < KERNEL_DIM; i++) {
    for (int j = 0; j < KERNEL_DIM; j++) {
      GET_K(kernel, i, j) = i + 2*j;
    }
  }
  
  const int out_size = (IN_DIM - 2)*(IN_DIM - 2);
  int* out = (int*) malloc(sizeof(int)*out_size);

  conv_3_3(in, kernel, out);

  for (int i = 0; i < IN_DIM - 2; i++) {
    for (int j = 0; j < IN_DIM - 2; j++) {
      cout << GET_O(out, i, j) << " ";
    }
    cout << endl;
  }
  
  free(in);
  free(kernel);
}
