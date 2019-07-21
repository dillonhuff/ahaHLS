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

  // Maybe: In each frame:
  // Assumptions are eq / not equal on symbolic values
  // Map from active instruction to its value (if the value exists)
  class SymValue {
  public:
    std::string name;
  };
  
  class SymFrame;

  std::ostream& operator<<(std::ostream& out, const SymFrame& frame);

  void printDefinedValue(std::ostream& out, const SymFrame& frame);
  
  class Assumption {
  public:
    bool areEqual;
    SymFrame* a;
    SymFrame* b;    
  };

  std::ostream& operator<<(std::ostream& out, const Assumption& a) {
    printDefinedValue(out, *(a.a));
    out << (a.areEqual ? " == " : " != ");
    printDefinedValue(out, *(a.b));    
    return out;
  }

  Assumption equal(SymFrame* a, SymFrame* b) {
    return {true, a, b};
  }

  Assumption notEqual(SymFrame* a, SymFrame* b) {
    return {false, a, b};
  }
  
  class SymHazard {
  public:
    SymFrame* source;

    SymHazard(SymFrame* source_) : source(source_) {}
  };

  // TODO: Create symbolic value class (and move activeInstruction to it?)
  // Move assumption handling up in the hierarchy
  class SymFrame {
  public:
    SymFrame* lastFrame;
    BasicBlock* lastBlock;
    Instruction* activeInstruction;
    int tripDepth;
    vector<Assumption*> assumptions;
    vector<SymHazard*> hazards;
    SymValue* instructionValue;

    SymFrame* getOperand(const int operandNum) {
      SymFrame* toSearch = lastFrame;
      Value* toSearchFor = activeInstruction->getOperand(operandNum);

      assert(Instruction::classof(toSearchFor));
      
      while (toSearch != nullptr) {
        if (toSearch->activeInstruction == toSearchFor) {
          break;
        }

        toSearch = toSearch->lastFrame;
      }

      assert(toSearch != nullptr);

      return toSearch;
    }
    
    void addAssumption(const Assumption& a) {
      assumptions.push_back(new Assumption(a));
    }

    void addHazard(const SymHazard& h) {
      hazards.push_back(new SymHazard(h));
    }

    SymFrame() : lastFrame(nullptr),
                 lastBlock(nullptr),
                 activeInstruction(nullptr),
                 tripDepth(0),
                 assumptions({}),
                 hazards({}),
                 instructionValue(nullptr) {}

    ~SymFrame() {
      delete instructionValue;
      
      for (auto a : assumptions) {
        delete a;
      }

      for (auto h : hazards) {
        delete h;
      }
    }
  };

  void printDefinedValue(std::ostream& out, const SymFrame& frame) {
    out << valueString(frame.activeInstruction) << ": " << frame.tripDepth;
  }
  
  std::ostream& operator<<(std::ostream& out, const SymFrame& frame) {
    printDefinedValue(out, frame);

    out << ", assume: ";
    for (auto a : frame.assumptions) {
      out << *a << ", ";
    }
    return out;
  }
  
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

    // Q: What info do I want to add to each frame
    // Idea: II = 1 but sequential inside the loop pruning?
    // Q: Are hazard assumptions (phi values, ram address value assumptions
    // branch condition assumptions?) Branch conditions probably require
    // more inference to use because the value of a branch condition variable
    // may not itself be used
    void printPaths() {
      cout << "Printing paths" << endl;
      
      assert(active.size() > 0);
      for (auto f : active) {
        SymFrame* lastFrame = f;
        deque<SymFrame*> frames;
        do {
          frames.push_back(lastFrame);
          lastFrame = lastFrame->lastFrame;
        } while (lastFrame != nullptr);

        cout << "---- Path length " << frames.size() << endl;
        reverse(frames);
        for (auto f : frames) {
          cout << tab(1) << *f << endl;
          //cout << tab(1) << valueString(f->activeInstruction) << ", " << f->lastBlock << endl;
        }
      }
    }

    bool isBackwardJump(BasicBlock* src, BasicBlock* dest) {
      if (dest == loop->getHeader()) {
        return true;
      }

      return false;
    }
    
    bool processNextFrame(const int maxDepth) {
      auto frame = active.front();
      active.pop_front();

      if ((frame->tripDepth == (maxDepth - 1)) &&
          isLatchBranch(frame->activeInstruction)) {
        active.push_back(frame);
        return false;
      }

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

            if (isBackwardJump(frame->activeInstruction->getParent(), succ)) {
              nextF->tripDepth = frame->tripDepth + 1;
            } else {
              nextF->tripDepth = frame->tripDepth;              
            }
        
            active.push_back(nextF);
          }
        }
      } else {
        auto nextInstr = instr->getNextNonDebugInstruction();
        
        if (matchesCall("ram.read", nextInstr)) {
          cout << "Handling load " << valueString(nextInstr) << endl;
          Value* ram = nextInstr->getOperand(0);
          Value* addr = nextInstr->getOperand(1);

          cout << "Splitting on value of addres " << valueString(addr) << endl;
          vector<SymFrame*> allHazardStores =
            findEarlierStoresToSameLocation(ram, addr, frame);

          cout << "Possible hazards" << endl;
          for (auto st : allHazardStores) {
            cout << tab(1) << *st << endl;
          }

          if (allHazardStores.size() == 0) {
            SymFrame* nextF = nextFrame(frame);
            active.push_back(nextF);
          } else {

            if (allHazardStores.size() != 1) {
              printPaths();
            }
            
            assert(allHazardStores.size() == 1);
            SymFrame* hazardStore = allHazardStores.at(0);

            SymFrame* nextFTrue = nextFrame(frame);
            nextFTrue->addAssumption(equal(nextFTrue->getOperand(1), hazardStore->getOperand(1)));
            nextFTrue->addHazard(SymHazard(hazardStore));

            SymFrame* nextFFalse = nextFrame(frame);
            nextFFalse->addAssumption(notEqual(nextFFalse->getOperand(1), hazardStore->getOperand(1)));

            active.push_back(nextFTrue);
            active.push_back(nextFFalse);                    
          }
        } else {
          SymFrame* nextF = nextFrame(frame);
          active.push_back(nextF);
        }
      }

      processed.push_back(frame);

      return true;
    }

    SymFrame* nextFrame(SymFrame* frame) {
      auto instr = frame->activeInstruction;
      SymFrame* nextF = new SymFrame();
      nextF->lastBlock = frame->lastBlock;
      nextF->activeInstruction = instr->getNextNonDebugInstruction();
      assert(nextF->activeInstruction != nullptr);
      nextF->lastFrame = frame;
      nextF->tripDepth = frame->tripDepth;
      return nextF;
    }

    vector<SymFrame*> findEarlierStoresToSameLocation(Value* ram, Value* addr, SymFrame* source) {
      vector<SymFrame*> hazards;
      SymFrame* currentH = source;
      while (currentH != nullptr) {
        auto i = currentH->activeInstruction;
        if (matchesCall("ram.write", i)) {
          if (i->getOperand(0) == ram) {
            hazards.push_back(currentH);
          }
        }
        currentH = currentH->lastFrame;
      }
      return hazards;
    }

    bool isLatchBranch(Instruction* instr) {
      if (BranchInst::classof(instr)) {
        return loop->isLoopExiting(instr->getParent());
      }

      return false;
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

  class SyntaxHazard {
  public:
    std::string name;
    Instruction* source;
    Instruction* impeded;
  };

#define CMP_FIELDS(x, y, fieldName) if (x.fieldName < y.fieldName) { return true; } if (x.fieldName > y.fieldName) { return false; }

  bool operator<(const SyntaxHazard& x,
                 const SyntaxHazard& y) {
    CMP_FIELDS(x, y, name);
    CMP_FIELDS(x, y, source);
    CMP_FIELDS(x, y, impeded);

    return false;
  }
  
  class SymExe {

  public:

    llvm::Function* f;

    map<SyntaxHazard, int> hazardDDs;

    SymExe(llvm::Function* f_) : f(f_) {}

    void analyzeLoops(const int depth) {
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

        bool processedNode = true;
        while (processedNode) {
          processedNode = trace.processNextFrame(depth);          
        }
        // // Now: Check that every 
        // cout << "# of active blocks " << trace.active.size() << endl;
        // for (int i = 0; i < 40; i++) {
        //   //cout << "# of active blocks " << trace.active.size() << endl;
        //   bool processedNode = trace.processNextFrame();
        // }

        trace.printPaths();

        for (auto frame : trace.active) {
          assert(frame->tripDepth == (depth - 1));
          assert(trace.isLatchBranch(frame->activeInstruction));
        }
      }
      
    }

    int rawDD(llvm::Instruction* load,
              llvm::Instruction* store) {
      return 1;
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
    auto storeNewCount = storeRAMVal(loopBuilder, histRam, pix, nextCount);
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
    engine.analyzeLoops(2);

    REQUIRE(engine.rawDD(count, storeNewCount) == 1);    
  }

  TEST_CASE("Symbolic analysis of histogram with forwarding") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("Histogram with forwarding", context);
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

    auto lastCount = loopBuilder.CreatePHI(intType(32), 2);
    auto lastPix = loopBuilder.CreatePHI(intType(32), 2);
    auto notFirstIter = loopBuilder.CreatePHI(intType(32), 2);

    auto pix = loadRAMVal(loopBuilder, imgRam, indPhi);
    auto count = loadRAMVal(loopBuilder, histRam, pix);
    auto nextCountN = loopBuilder.CreateAdd(count, one);
    auto lastCountInc = loopBuilder.CreateAdd(lastCount, one);    

    auto lastPixIsThisPix =
      loopBuilder.CreateAnd(notFirstIter, loopBuilder.CreateICmpEQ(pix, lastPix));
    auto nextCount =
      loopBuilder.CreateSelect(lastPixIsThisPix, lastCountInc, nextCountN);
    auto storeNewCount = storeRAMVal(loopBuilder, histRam, pix, nextCount);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);
    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    lastPix->addIncoming(zero, entryBlock);
    lastPix->addIncoming(pix, loopBlock);

    lastCount->addIncoming(zero, entryBlock);
    lastCount->addIncoming(nextCount, loopBlock);

    notFirstIter->addIncoming(mkInt(0, 1), entryBlock);
    notFirstIter->addIncoming(mkInt(1, 1), loopBlock);
    
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    // Try to show that in any trace of depth 2
    // either the load from image is to a different location than
    // the prior iterations store, or that the loaded value is dead
    SymExe engine(f);
    engine.analyzeLoops(2);

    // TODO: Add check that minimum DD between load and store to
    // histogram memory is at least 2

    REQUIRE(engine.rawDD(count, storeNewCount) >= 2);
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
