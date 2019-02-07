#include <iostream>

using namespace std;

#include "fifo.h"
#include "add_10_template.h"

int main() {
  Fifo<int, 32> in;
  Fifo<int, 32> out;

  in.write(1);
  add_10_template(&in, &out);

  int res = out.read();
  cout << "result = " << res << endl;
  assert(res == 11);
}
