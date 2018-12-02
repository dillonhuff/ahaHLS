void stalled_single_store_axi(int* __restrict a, int* __restrict b) {
  int b0 = b[0];
  int r = 0;
  while (r < 20) {
    r += b0;
  }

  a[0] = r;
}
