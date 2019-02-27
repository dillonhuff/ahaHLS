#include "gen_classes.h"

typedef hls_stream_AxiPackedStencil_uint16_t_1_1__ StencilStream;
typedef AxiPackedStencil_uint16_t_1_1_ Stencil;

void stencil_stream_mul(StencilStream* in, StencilStream* out) {
  Stencil s = in->read();
  Stencil b;
  b.set(s.get(0, 0, 0) << 1, 0, 0, 0);
  b.set_last(1);
  out->write(b);
}
