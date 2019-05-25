#include "int_add_wrapper.h"

#include <cassert>

int main() {
  int_add wrap;
  int a = 5;
  int b = 10;
  int c = 0;

  wrap.add(&a, &b, &c);
  
  assert(c == (5 + 10));
}
