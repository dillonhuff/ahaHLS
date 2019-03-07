#include "ac_channel.h"

class median {
  int val0;
  int val1;
public:

  void run_median(ac_channel<int>* in0,
                  ac_channel<int>* in1,
                  ac_channel<int>* in2,
                  ac_channel<int>* out);
  
};

void median_filter(ac_channel<int>* in0,
                   ac_channel<int>* in1,
                   ac_channel<int>* in2,
                   ac_channel<int>* out) {

  median m;
  m.run_median(in0, in1, in2, out);

}
