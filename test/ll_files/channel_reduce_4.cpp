#include "ac_channel.h"

void channel_reduce_4(ac_channel<int>* in, ac_channel<int>* out) {
  int sum = 0;
  for (int i = 0; i < 4; i++) {
    sum += in->read();
  }
  out->write(sum);
}
