#include "ram.h"

template<typename Pixel, int nRows, int nCols>
class Image {
  RAM<Pixel, nRows*nCols> storage;
public:

  Pixel readPixel(int row, int col) {
    return storage.read(row*nCols + col);
  }
};
