#define N 4

void loop_add_4_copy(int* __restrict a, int* __restrict b) {
  int temp[N];

  // Write to temp, up to N - 1
  for (int i = 0; i < N - 1; i++) {
    temp[i] = a[i] + 4;
  }

  // Prevent loop fusion
  temp[N - 1] = temp[0] + temp[1];

  // Copy from temp to b
  for (int i = 0; i < N; i++) {
    b[i] = temp[i] + 6;
  }

}
