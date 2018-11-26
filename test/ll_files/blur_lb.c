#define A_LEN 8
#define B_LEN (A_LEN - 2);

void blur_lb(int* __restrict a, int* __restrict b) {
  int a_near = a[0];
  int a_mid = a[1];
  int a_far = a[2];

  for (int i = 1; i < A_LEN - 1; i++) {
    b[i - 1] = a_near + a_mid + a_far;
  }
}
