#include "algorithm.h"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include <llvm/Analysis/TargetLibraryInfo.h>
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include <llvm/Analysis/LoopInfo.h>
#include "llvm/IR/Dominators.h"

using namespace std;
using namespace llvm;
using namespace ahaHLS;


bool isUnknownValue(const SCEV* ss) {
  if (SCEVCouldNotCompute::classof(ss) ||
      SCEVUnknown::classof(ss)) {
    return true;
  }

  return false;
}

bool affine(const SCEV* ss) {
  if (!SCEVAddRecExpr::classof(ss)) {
    return false;
  }

  return dyn_cast<SCEVAddRecExpr>(ss)->isAffine();
}

// TODO: Filter loops that call functions that contain loops
void printLoopInfo(Loop* loop, ScalarEvolution& scev) {
  if (loop->getSubLoops().size() == 0) {
    cout << "Found inner loop with blocks" << endl;
    for (auto blk : loop->getBlocksVector()) {
      cout << valueString(blk) << endl;

      for (auto& instrR : *blk) {
        auto instr = &instrR;
        if (LoadInst::classof(instr)) {
          Value* source = instr->getOperand(0);
          const SCEV* ss = scev.getSCEV(source);

          if (isUnknownValue(ss)) {
            if (!scev.isLoopInvariant(ss, loop) && !(affine(ss))) {
              cout << tab(1) << "Loop contains load from " << valueString(source) << " that SCEV cannot analyze" << endl;
            }
          } else {
            if (!scev.isLoopInvariant(ss, loop) && !(affine(ss))) {
              cout << tab(1) << "Loop contains load from " << valueString(source) << " that SCEV cannot analyze" << endl;
            }
          }
        }

        if (StoreInst::classof(instr)) {
          Value* source = instr->getOperand(1);
          const SCEV* ss = scev.getSCEV(source);

          cout << tab(1) << "Store to source " << valueString(source) << " has scev " << scevStr(ss) << endl;

          if (isUnknownValue(ss)) {
            if (!scev.isLoopInvariant(ss, loop) && !(affine(ss))) {
              cout << tab(1) << "Loop contains store to: " << valueString(source) << " that SCEV cannot analyze or is not affine..." << endl;
            } else {
              cout << tab(1) << "Loop contains store to unknown loop invariant value: " << valueString(source) << " that SCEV cannot analyze" << endl;              
            }
          } else {
            if (!scev.isLoopInvariant(ss, loop) && !(affine(ss))) {
              cout << tab(1) << "Loop contains store to: " << valueString(source) << " that SCEV cannot analyze or is not affine..." << endl;
            }
          }
        }
      }
    }

  } else {
    for (Loop* sl : loop->getSubLoops()) {
      printLoopInfo(sl, scev);
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

      TargetLibraryInfoImpl i;
      TargetLibraryInfo tli(i);
      AssumptionCache ac(fR);
      ScalarEvolution scev(fR, tli, ac, dt, li);
      
      for (auto loop : li) {
        printLoopInfo(loop, scev);
      }
    }
  }
  
}

int main() {
  //string filePath = "/Users/dillon/CppWorkspace/rosetta/digit-recognition/src/sw/digitrec_sw";
  string filePath = "/Users/dillon/CppWorkspace/rosetta/3d-rendering/src/sw/rendering_sw";
  //string filePath = "/Users/dillon/CppWorkspace/rosetta/face-detection/src/sw/face_detect_sw";
  //string filePath = "/Users/dillon/CppWorkspace/rosetta/optical-flow/src/sw/optical_flow_sw";
  
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
