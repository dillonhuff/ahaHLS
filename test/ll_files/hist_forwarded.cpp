#include "ram.h"

void hist_forwarded(RAM<int, 16>* img, RAM<int, 256>* hist) {
  bool firstIteration = true;
  int lastPix = 0;
  int lastHistVal = 0;

  for (int i = 0; i < 16; i++) {
    
    int pix = img->read(i);
    int curVal = hist->read(pix);

    int nextHistVal;
    if (firstIteration || (pix != lastPix)) {
      nextHistVal = curVal + 1;
    } else {
      nextHistVal = lastHistVal + 1;
    }

    hist->write(pix, nextHistVal);

    firstIteration = false;
    lastHistVal = nextHistVal;
    lastPix = pix;
  }
}
