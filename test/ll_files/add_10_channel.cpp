#include "ac_channel.h"

void add_10_channel(ac_channel<int>* in, ac_channel<int>* out) {
  int a = in->read();
  out->write(a + 10);
}


