#pragma once

#define AHAHLS_SYNTH_BUILTIN __attribute__((optnone,noinline))

AHAHLS_SYNTH_BUILTIN
void ahahls_pipeline(const int ii) {
}

#define AHAHLS_PIPELINE(II) ahahls_pipeline(II)
