#include "ac_channel.h"

void channel_add(ac_channel<int>* in0, ac_channel<int>* in1, ac_channel<int>* out) {
  int a = in0->read();
  int b = in1->read();
  out->write(a + b);
}
