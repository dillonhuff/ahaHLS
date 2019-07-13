#include "fifo.h"

using namespace ahaHLS;

#define AHAHLS_PIPELINE_LOOP(type, name, ii) type name __attribute__((annotate("pipeline II="#ii)));
//__attribute__((annotate("pipeline II=1")));

void convs(Fifo<int, 128>* in, Fifo<int, 128>* out) {

  Fifo<int, 128> tmp;

  AHAHLS_PIPELINE_LOOP(int, i, 1);
  for (i = 0; i < 20; i++) {
    int a = in->read();
    int b = in->read();

    tmp.write(3*a + 2*b);
  }

  for (i = 0; i < 10; i++) {
    out->write(2*tmp.read() + tmp.read());
  }
}
