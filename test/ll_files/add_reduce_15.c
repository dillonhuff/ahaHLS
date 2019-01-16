void add_reduce_15(int* __restrict in, int* __restrict out) {

  int r = 0;

  for (int i = 0; i < 15; i++) {
    r = r + in[i];
  }

  out[0] = r;
}
