#include "loop_add_4_copy.c"

#include <stdio.h>

int main() {
  int a[N];
  a[0] = 1;
  a[1] = 2;
  a[2] = 3;
  a[3] = 4;
  
  int b[N];
  loop_add_4_copy(a, b);

  for (int i = 0; i < N; i++) {
    printf("b[%d] = %d\n", i, b[i]);
  }
}
