#include "rams.h"

void population_count(RAM<int, 128>* imgdiff, ram<int, 128>* pc) {
  for (int i = 0; i < 128; i++) {
    int val = imgdiff[i];
    int count = 0;

    while (val) {
      count++;
      val = val & (val - 1);
    }

    pc[i] = count;
  }
}
