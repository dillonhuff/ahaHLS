#include <cassert>
#include <cxxabi.h>
#include <cstdlib>
#include <cstdio>

#include <string>

using namespace std;

int main() {
  int status = 0;
  const char* mangledName = string("_ZN4FifoIiLi32EE4readEv").c_str();
  const char* realName = abi::__cxa_demangle(mangledName, 0, 0, &status);
  bool quiet = false;
  
  switch (status) {
  case 0:
    if (quiet) {
      puts(realName);
    } else {
      printf("%s  %s\n", realName, mangledName);
    }
    break;
  case -1:
    printf("FAIL: failed to allocate memory while demangling %s\n",
           mangledName);
    break;
  case -2:
    printf("FAIL: %s is not a valid name under the C++ ABI mangling rules\n",
           mangledName);
    break;
  default:
    printf("FAIL: some other unexpected error: %d\n", status);
    break;
  }
  free((void *)realName);  
}
