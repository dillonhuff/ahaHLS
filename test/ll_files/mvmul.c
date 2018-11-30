void mvmul(int* __restrict a,
           int* __restrict b,
           int* __restrict c) {
  for (int i = 0; i < 3; i++) {
    c[i] = 0;
    for (int j = 0; j < 3; j++) {
      c[i] += a[i*3 +j] * c[j];
    }
  }
}
