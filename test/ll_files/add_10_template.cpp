#include "add_10_template.h"

void add_10_template(Fifo<int, 32>* in, Fifo<int, 32>* out) {
  int a = in->read();
  out->write(a + 10);
}
