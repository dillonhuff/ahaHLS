#include "gen_classes.h"

typedef hls_stream_AxiPackedStencil_uint16_t_1_1__ StencilStream;
typedef AxiPackedStencil_uint16_t_1_1_ Stencil;

void stencil_stream_rw(StencilStream* in, StencilStream* out) {
  Stencil s = in->read();
  out->write(s);
}
