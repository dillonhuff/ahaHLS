#include "image.h"

#include <cstdint>

void histogram(RAM<uint8_t, 2^8>* histogram, Image<uint8_t, 4, 4>* img) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      uint8_t val = img->readPixel(i, j);
      histogram->write(val, histogram->read(val) + 1);
    }
  }
}
