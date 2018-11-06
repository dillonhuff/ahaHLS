void loop_add_4(int* __restrict a, int* __restrict b) {
  for (int i = 0; i < 6; i++) {
    a[i] = b[i] + 4;
  }
}
