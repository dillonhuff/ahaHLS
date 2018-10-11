void foo(int* b) {
  *b = 0;

  while (*b < 10) {
    *b += 1;
  }

  *b = *b - 3;

}
