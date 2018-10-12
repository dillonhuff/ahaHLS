#define N 100

void foo(int* __restrict a, int* __restrict b, int* __restrict c) {
  for (int i = 0; i < N; i++) {
    c[i] = a[i] + b[i];
  }
}
