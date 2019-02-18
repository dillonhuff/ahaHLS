#include "ram.h"

#define A_LEN 8
#define B_LEN (A_LEN - 2);

#define a 0
#define b 8

void blur_no_lb(RAM_3<int, 32>* ram) {
  for (int i = 1; i < A_LEN - 1; i++) {
    int sum = ram->read_0(a + (i - 1)) + ram->read_1(a + i) + ram->read_2(a + i + 1);
    ram->write_0(b + (i - 1), sum);
  }
}
