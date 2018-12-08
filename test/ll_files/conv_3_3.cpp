#define IN_DIM 8

#define ARR(a, i, j) (a)[(i)*IN_DIM + (j)]

void conv_3_3(const int* __restrict in,
              const int* __restrict kernel,
              int* __restrict out) {

  for (int i = 1; i < IN_DIM - 1; i++) {
    for (int j = 1; j < IN_DIM - 1; j++) {
      int top_row = ARR(kernel, 0, 0)*ARR(in, i - 1, j - 1) +
        ARR(kernel, 0, 1)*ARR(in, i - 1, j) +
        ARR(kernel, 0, 2)*ARR(in, i - 1, j + 1);

      int mid_row = ARR(kernel, 1, 0)*ARR(in, i, j - 1) +
        ARR(kernel, 1, 1)*ARR(in, i, j) +
        ARR(kernel, 1, 2)*ARR(in, i, j + 1);

      int low_row = ARR(kernel, 2, 0)*ARR(in, i + 1, j - 1) +
        ARR(kernel, 2, 1)*ARR(in, i + 1, j) +
        ARR(kernel, 2, 2)*ARR(in, i + 1, j + 1);

      ARR(out, i, j) = top_row + mid_row + low_row;
    }
  }
}
