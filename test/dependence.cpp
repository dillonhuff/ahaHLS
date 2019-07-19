#include "catch.hpp"

#include "algorithm.h"

#include "scheduling.h"
#include "verilog_backend.h"
#include "llvm_codegen.h"

#include <fstream>

#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/LoopInfo.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  // Now: What do I want to do with 
  class SymFrame {
  public:
    SymFrame* lastFrame;
    BasicBlock* lastBlock;
    Instruction* activeInstruction;
  };

  class SymTrace {
  public:

    Loop* loop;
    std::deque<SymFrame*> processed;
    std::deque<SymFrame*> active;

    void setStartBlock(BasicBlock* blk) {
      for (auto pred : predecessors(blk)) {
        auto frame = new SymFrame();
        frame->lastBlock = pred;
        frame->activeInstruction = &(blk->front());
        frame->lastFrame = nullptr;
        
        active.push_back(frame);
      }
    }

    bool inLoop(BasicBlock* blk) {
      for (auto b : loop->getBlocks()) {
        return blk == b;
      }
      return false;
    }

    void printPaths() {
      cout << "Printing paths" << endl;
      
      assert(active.size() > 0);
      for (auto f : active) {
        SymFrame* lastFrame = f; //active.back();
        deque<SymFrame*> frames;
        do {
          frames.push_back(lastFrame);
          lastFrame = lastFrame->lastFrame;
        } while (lastFrame != nullptr);

        cout << "Path length " << frames.size() << endl;
        reverse(frames);
        for (auto f : frames) {
          cout << tab(1) << valueString(f->activeInstruction) << ", " << f->lastBlock << endl;
        }
      }
    }
    
    void processNextFrame() {
      auto frame = active.front();
      active.pop_front();

      Instruction* instr =
        frame->activeInstruction;
      assert(instr != nullptr);

      cout << "Processing " << valueString(instr) << endl;

      // TODO: Add constraints for instruction
      // Generate new states
      // Add states to active queue

      if (BranchInst::classof(instr)) {
        //cout << "Error: Cant handle branches yet" << endl;
        cout << "Branch " << valueString(instr) << " splitting" << endl;
        for (BasicBlock* succ : successors(instr->getParent())) {
          // Ignore out of loop branches
          if (inLoop(succ)) {
            SymFrame* nextF = new SymFrame();

            nextF->lastBlock = instr->getParent();
            nextF->activeInstruction = &(succ->front());
            assert(nextF->activeInstruction != nullptr);          
            nextF->lastFrame = frame;
        
            active.push_back(nextF);
          }
        }
      } else {
        SymFrame* nextF = new SymFrame();
        nextF->lastBlock = frame->lastBlock;
        nextF->activeInstruction = instr->getNextNonDebugInstruction();
        assert(nextF->activeInstruction != nullptr);
        nextF->lastFrame = frame;
        
        active.push_back(nextF);
      }

      processed.push_back(frame);
    }

    ~SymTrace() {

      for (auto frame : processed) {
        delete frame;
      }
      
      for (auto frame : active) {
        delete frame;
      }

      
    }
  };
  
  class SymExe {

  public:

    llvm::Function* f;

    SymExe(llvm::Function* f_) : f(f_) {}

    void analyzeLoops() {
      DominatorTree dt(*f);
      LoopInfo li(dt);

      for (Loop* loop : li) {
        cout << "Analyzing loop with " << loop->getBlocks().size() << " basic block(s)" << endl;

        BasicBlock* h = loop->getHeader();
        assert(h != nullptr);

        cout << valueString(h) << endl;

        SymTrace trace;
        trace.loop = loop;
        trace.setStartBlock(h);

        cout << "# of active blocks " << trace.active.size() << endl;
        for (int i = 0; i < 50; i++) {
          //cout << "# of active blocks " << trace.active.size() << endl;
          trace.processNextFrame();
        }

        trace.printPaths();

        cout << "Done" << endl;
      }
    }
  };
  
  TEST_CASE("Symbolic analysis of histogram") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("Unroll by two", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo()};
    Function* f = mkFunc(inputs, "histogram", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto loopBlock = mkBB("loop_block", f);
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* loopBound = mkInt("8", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    builder.CreateBr(loopBlock);

    auto histRam = getArg(f, 0);
    auto imgRam = getArg(f, 1);    

    IRBuilder<> loopBuilder(loopBlock);
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto pix = loadRAMVal(loopBuilder, imgRam, indPhi);
    auto count = loadRAMVal(loopBuilder, histRam, pix);
    auto nextCount = loopBuilder.CreateAdd(count, one);
    storeRAMVal(loopBuilder, histRam, pix, nextCount);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);
    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    SymExe engine(f);
    engine.analyzeLoops();
    
    // HardwareConstraints hcs = standardConstraints();

    // scheduleFunction(f, hcs);
  }

  // TEST_CASE("Computing dependence distances via loop vectorizer") {
  //   LLVMContext context;
  //   setGlobalLLVMContext(&context);

  //   auto mod = llvm::make_unique<Module>("simple LLVM accumulate loop", context);

  //   std::vector<Type *> inputs{intType(32)->getPointerTo(),
  //       intType(32)->getPointerTo()};
  //   Function* f = mkFunc(inputs, "accum_loop", mod.get());

  //   auto entryBlock = mkBB("entry_block", f);
  //   auto loopBlock = mkBB("loop_block", f);
  //   auto exitBlock = mkBB("exit_block", f);        

  //   ConstantInt* loopBound = mkInt("5", 32);
  //   ConstantInt* zero = mkInt("0", 32);    
  //   ConstantInt* one = mkInt("1", 32);    

  //   IRBuilder<> builder(entryBlock);
  //   auto ldA = builder.CreateLoad(dyn_cast<Value>(f->arg_begin()));

  //   builder.CreateBr(loopBlock);

  //   IRBuilder<> loopBuilder(loopBlock);
  //   auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
  //   auto sumPhi = loopBuilder.CreatePHI(intType(32), 2);
  //   auto nextInd = loopBuilder.CreateAdd(indPhi, one);
  //   auto nextSum = loopBuilder.CreateAdd(sumPhi, ldA);

  //   auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

  //   indPhi->addIncoming(zero, entryBlock);
  //   indPhi->addIncoming(nextInd, loopBlock);

  //   sumPhi->addIncoming(zero, entryBlock);
  //   sumPhi->addIncoming(nextSum, loopBlock);
    
  //   loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

  //   IRBuilder<> exitBuilder(exitBlock);
  //   exitBuilder.CreateStore(nextSum, dyn_cast<Value>(f->arg_begin() + 1));
  //   exitBuilder.CreateRet(nullptr);

  //   cout << valueString(f) << endl;

  //   HardwareConstraints hcs = standardConstraints();

  //   scheduleFunction(f, hcs);
  // }
  
}
