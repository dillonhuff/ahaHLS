#include "ram.h"

#define A_LEN 8
#define B_LEN (A_LEN - 2);

#define a 0
#define b 8

void blur_lb(RAM<int, 16>* ram) { //int* __restrict a, int* __restrict b) {
  int a_near = ram->read(a + 0); //a[0];
  int a_mid = ram->read(a + 1); //a[1];
  int a_far;

  // This gets 4 as a value for b[0] instead of 3 = 0 + 1 + 2?
  // Maybe it is 0 + 2 + 2 instead?
  for (int i = 1; i < A_LEN - 1; i++) {
    //a_far = a[i + 1];
    a_far = ram->read(a + i + 1);
    
    //b[i - 1] = a_near + a_mid + a_far;
    ram->write(b + i - 1, a_near + a_mid + a_far);
    a_near = a_mid;
    a_mid = a_far;

  }
}
