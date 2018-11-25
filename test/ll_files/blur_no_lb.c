#define A_LEN 8
#define B_LEN (A_LEN - 2);

void blur_no_lb(int* __restrict a, int* __restrict b) {
  for (int i = 1; i < A_LEN - 1; i++) {
    b[i] = (a[i - 1] + a[i] + a[i + 1]);
  }
}
