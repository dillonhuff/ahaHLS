#include "algorithm.h"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include <llvm/Analysis/LoopInfo.h>
#include "llvm/IR/Dominators.h"

using namespace std;
using namespace llvm;
using namespace ahaHLS;

// TODO: Filter code that contains
void printLoopInfo(Loop* loop) {
  if (loop->getSubLoops().size() == 0) {
    cout << "Found inner loop with blocks" << endl;
    for (auto blk : loop->getBlocksVector()) {
      cout << valueString(blk) << endl;
    }
  } else {
    for (Loop* sl : loop->getSubLoops()) {
      printLoopInfo(sl);
    }
  }
}

void innerLoopInfo(Module* mod) {
  for (auto& fR : mod->functions()) {
    cout << "Found function " << string(fR.getName()) << endl;
    if (!fR.empty()) {
      cout << tab(1) << "not empty" << endl;
      DominatorTree dt(fR);
      LoopInfo li(dt);

      for (auto loop : li) {
        printLoopInfo(loop);
      }
    }
  }
  
}

int main() {
  //string filePath = "/Users/dillon/CppWorkspace/rosetta/digit-recognition/src/sw/digitrec_sw";
  //string filePath = "/Users/dillon/CppWorkspace/rosetta/3d-rendering/src/sw/rendering_sw";
  //string filePath = "/Users/dillon/CppWorkspace/rosetta/face-detection/src/sw/face_detect_sw";
  string filePath = "/Users/dillon/CppWorkspace/rosetta/optical-flow/src/sw/optical_flow_sw";
  
  int res = system(("clang -DSW -O1 -D__SYNTHESIS__ -c -S -emit-llvm " + filePath + ".cpp -o " + filePath + ".ll").c_str());
  assert(res == 0);

  SMDiagnostic err;
  LLVMContext context;
  setGlobalLLVMContext(&context);
  
  std::unique_ptr<Module> mod = loadLLFileRawPath(context,
                                                  err,
                                                  filePath + ".ll");

  setGlobalLLVMModule(mod.get());

  innerLoopInfo(mod.get());
}
