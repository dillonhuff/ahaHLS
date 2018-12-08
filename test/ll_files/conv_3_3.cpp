#include <iostream>

using namespace std;

#define IN_DIM 8
#define OUT_DIM (IN_DIM - 2)
#define KERNEL_DIM 3

#define ARR(a, i, j, stride) (a)[(i)*(stride) + (j)]
#define GET_A(a, i, j) ARR((a), (i), (j), IN_DIM)
#define GET_K(a, i, j) ARR((a), (i), (j), KERNEL_DIM)
#define GET_O(a, i, j) ARR((a), (i), (j), OUT_DIM)

void conv_3_3(const int* __restrict in,
              const int* __restrict kernel,
              int* __restrict out) {

  for (int i = 1; i < IN_DIM - 1; i++) {
    for (int j = 1; j < IN_DIM - 1; j++) {
      int top_row = GET_K(kernel, 0, 0)*GET_A(in, i - 1, j - 1) +
        GET_K(kernel, 0, 1)*GET_A(in, i - 1, j) +
        GET_K(kernel, 0, 2)*GET_A(in, i - 1, j + 1);

      int mid_row = GET_K(kernel, 1, 0)*GET_A(in, i, j - 1) +
        GET_K(kernel, 1, 1)*GET_A(in, i, j) +
        GET_K(kernel, 1, 2)*GET_A(in, i, j + 1);

      int low_row = GET_K(kernel, 2, 0)*GET_A(in, i + 1, j - 1) +
        GET_K(kernel, 2, 1)*GET_A(in, i + 1, j) +
        GET_K(kernel, 2, 2)*GET_A(in, i + 1, j + 1);

      GET_O(out, i - 1, j - 1) = top_row + mid_row + low_row;
    }
  }
}

int main() {
  int* in = (int*) malloc(sizeof(int)*IN_DIM*IN_DIM);
  int* kernel = (int*) malloc(sizeof(int)*(KERNEL_DIM*KERNEL_DIM));
  for (int i = 0; i < KERNEL_DIM; i++) {
    for (int j = 0; j < KERNEL_DIM; j++) {
      GET_K(kernel, i, j) = 1;
    }
  }

  for (int i = 0; i < IN_DIM; i++) {
    for (int j = 0; j < IN_DIM; j++) {
      GET_A(in, i, j) = 1;
    }
  }
  
  const int out_size = (IN_DIM - 2)*(IN_DIM - 2);
  int* out = (int*) malloc(sizeof(int)*out_size);

  conv_3_3(in, kernel, out);

  for (int i = 0; i < IN_DIM - 2; i++) {
    for (int j = 0; j < IN_DIM - 2; j++) {
      cout << GET_O(out, i, j) << " ";
    }
    cout << endl;
  }
  
  free(in);
  free(kernel);
}
