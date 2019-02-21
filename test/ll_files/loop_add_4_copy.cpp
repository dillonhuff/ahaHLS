#include "ram.h"

#define N 4
#define a 0
#define b 10

void loop_add_4_copy(RAM_2<int, 16>* ram) { //int* __restrict a, int* __restrict b) {
  //int temp[N];
  RAM<int, N> temp;

  // Write to temp, up to N - 1
  for (int i = 0; i < N - 1; i++) {
    temp.write(i, ram->read_0(a + i) + 4);
    //temp[i] = a[i] + 4;
  }

  // Prevent loop fusion
  //temp[N - 1] = temp[0] + 12;
  temp.write(N - 1, temp.read(0) + 12);

  // Copy from temp to b
  for (int i = 0; i < N; i++) {
    //b[i] = temp[i] + 6;
    ram->write_0(b + i, temp.read(i) + 6);
  }

}
