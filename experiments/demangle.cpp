#include <cassert>
#include <cxxabi.h>
#include <cstdlib>
#include <cstdio>

#include <string>

using namespace std;

void demangle(const char* mangledName) {
  int status = 0;
  
  const char* realName = abi::__cxa_demangle(mangledName, 0, 0, &status);
  bool quiet = false;
  
  switch (status) {
  case 0:
    if (quiet) {
      puts(realName);
    } else {
      printf("%s, mangled: %s\n", realName, mangledName);
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

// Q: Could I build a more complex interface function?
// A: I guess I could, I would need to build a more interesting
//    system that 
int main() {
  const char* mangledName = string("_ZN4FifoIiLi32EE4readEv").c_str();
  demangle(mangledName);

  const char* mn2 = string("_ZN4FifoIiLi32EE5writeEi").c_str();
  demangle(mn2);

}
