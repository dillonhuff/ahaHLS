#include "ram.h"

void hist_simple(RAM<char, 16>* img, RAM<int, 256>* hist) {
  for (int i = 0; i < 16; i++) {
    char pix = img->read(i);
    int curVal = hist->read(pix);
    hist->write(pix, curVal + 1);
  }
}
