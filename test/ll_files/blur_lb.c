#define A_LEN 8
#define B_LEN (A_LEN - 2);

/* class LineBuffer { */
/*   int near; */
/*   int mid; */
/*   int far; */

/*   void push(const int new_near) { */
/*     far = mid; */
/*     mid = near; */
/*     near = new_near; */
/*   } */

/*   int read_near() { */
/*     return near; */
/*   } */

/*   int read_mid() { */
/*     return mid; */
/*   } */

/*   int read_far() { */
/*     return far; */
/*   } */
  
/* }; */

void blur_lb(int* __restrict a, int* __restrict b) {
  int a_near = a[0];
  int a_mid = a[1];
  int a_far;

  // This gets 4 as a value for b[0] instead of 3 = 0 + 1 + 2?
  // Maybe it is 0 + 2 + 2 instead?
  for (int i = 1; i < A_LEN - 1; i++) {
    a_far = a[i + 1];
    
    b[i - 1] = a_near + a_mid + a_far;
    a_near = a_mid;
    a_mid = a_far;

  }
}
