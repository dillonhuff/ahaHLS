#include "ram.h"

#define a 0
#define b 1
#define c 2

void cmp_gt(RAM_3<int, 16>* ram) {
  //if (a[0] > b[0]) {
  if (ram->read_0(a) > ram->read_1(b)) {
    ram->write_0(c, 10);
    //c[0] = 10;
  } else {
    ram->write_0(c, 0);
    //c[0] = 0;
  }
}
