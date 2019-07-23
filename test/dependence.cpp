#include "catch.hpp"

#include "z3++.h"

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
using namespace z3;

namespace ahaHLS {

  // Maybe: In each frame:
  // Assumptions are eq / not equal on symbolic values
  // Map from active instruction to its value (if the value exists)
  class SymValue {
  public:
    llvm::Value* llvmValue;
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
    std::string typeName;
    SymFrame* source;

    SymHazard(const std::string& typeName_, SymFrame* source_) :
      typeName(typeName_),
      source(source_) {}
  };

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

    int dd(const SymHazard& h) const {
      int dd = tripDepth - h.source->tripDepth;
      return dd;
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
    std::set<SymFrame*> completed;

    void setStartBlock(BasicBlock* blk) {
      for (auto pred : predecessors(blk)) {
        auto frame = new SymFrame();
        frame->lastBlock = pred;
        frame->activeInstruction = &(blk->front());
        frame->lastFrame = nullptr;
        auto sVal = new SymValue();
        sVal->llvmValue = frame->activeInstruction;
        frame->instructionValue = sVal;
        
        active.push_back(frame);
      }
    }

    std::set<SymFrame*> allNodes() const {
      set<SymFrame*> allN;
      for (auto n : processed) {
        allN.insert(n);
      }
      for (auto n : active) {
        allN.insert(n);
      }

      for (auto n : completed) {
        allN.insert(n);
      }
      
      return allN;
    }

    bool inLoop(BasicBlock* blk) {
      return loop->contains(blk);
      // for (BasicBlock* b : loop->getBlocks()) {
      //   return blk == b;
      // }
      // return false;
    }

    // Q: What info do I want to add to each frame
    // Idea: II = 1 but sequential inside the loop pruning?
    // Q: Are hazard assumptions (phi values, ram address value assumptions
    // branch condition assumptions?) Branch conditions probably require
    // more inference to use because the value of a branch condition variable
    // may not itself be used

    std::vector<SymFrame*> getTraceSoFar(SymFrame* f) {
      SymFrame* lastFrame = f;
      vector<SymFrame*> frames;
      do {
        frames.push_back(lastFrame);
        lastFrame = lastFrame->lastFrame;
      } while (lastFrame != nullptr);

      return frames;
    }

    void printPathSoFar(SymFrame* f) {
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
      }
      
    }
    
    void printPaths() {
      cout << "Printing " << completed.size() << " paths" << endl;
      
      //assert(active.size() > 0);
      for (auto f : completed) {
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
        }
      }
    }

    bool isBackwardJump(BasicBlock* src, BasicBlock* dest) {
      auto header = loop->getHeader();
      assert(header != nullptr);

      if ((src == header) && (dest == header)) {
        return true;
      }

      if (src == dest) {
        return false;
      }
      
      if (dest == loop->getHeader()) {
        return true;
      }

      return false;
    }

    bool isBackwardJump(Instruction* src, Instruction* dest) {
      if (!BranchInst::classof(src)) {
        return false;
      }

      return isBackwardJump(src->getParent(), dest->getParent());
    }
    
    void handleNextInstr(SymFrame* frame, Instruction* nextInstr) {
        
      if (matchesCall("ram.read", nextInstr)) {
        cout << "Handling load " << valueString(nextInstr) << endl;
        Value* ram = nextInstr->getOperand(0);
        Value* addr = nextInstr->getOperand(1);

        cout << "Splitting on value of address " << valueString(addr) << endl;
        vector<SymFrame*> allHazardStores =
          findEarlierStoresToSameLocation(ram, addr, frame);

        cout << "Possible hazards" << endl;

        for (auto st : allHazardStores) {
          cout << tab(1) << *st << endl;
        }

        cout << "Path so far" << endl;
        if (allHazardStores.size() > 1) {
          printPathSoFar(frame);
        }
        
        if (allHazardStores.size() == 0) {
          SymFrame* nextF = nextFrame(frame, nextInstr);
          active.push_back(nextF);
        } else {

          if (allHazardStores.size() != 1) {
            printPaths();
          }
            
          assert(allHazardStores.size() == 1);
          SymFrame* hazardStore = allHazardStores.at(0);

          SymFrame* nextFTrue = nextFrame(frame, nextInstr);
          nextFTrue->addAssumption(equal(nextFTrue->getOperand(1), hazardStore->getOperand(1)));
          nextFTrue->addHazard(SymHazard("ram_RAW", hazardStore));

          SymFrame* nextFFalse = nextFrame(frame, nextInstr);
          nextFFalse->addAssumption(notEqual(nextFFalse->getOperand(1), hazardStore->getOperand(1)));

          active.push_back(nextFTrue);
          active.push_back(nextFFalse);                    
        }
      } else {
        cout << "Handling non-load instruction " << valueString(nextInstr) << endl;
        SymFrame* nextF = nextFrame(frame, nextInstr);
        active.push_back(nextF);
      }
    }
    
    bool processNextFrame(const int maxDepth) {

      if (active.size() == 0) {
        return false;
      }

      // SymFrame* frame = nullptr;
      // for (auto fr : active) {
      //   if ((fr->tripDepth == (maxDepth - 1)) &&
      //       isLatchBranch(fr->activeInstruction)) {
      //     active.push_back(frame);
      //     return false;
      //   }
      // }

      // // Nothing left to process
      // if (frame == nullptr) {
      //   return false;
      // }

      auto frame = active.front();
      active.pop_front();
      if ((frame->tripDepth == (maxDepth - 1)) &&
          isLatchBranch(frame->activeInstruction)) {
        completed.insert(frame);
        return true;
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

            handleNextInstr(frame, &(succ->front()));
            
          } else {
            //cout << "block " << valueString(succ) << " not in loop" << endl;
            // cout << "Loop has " << loop->getBlocks().size() << " bbs" << endl;
            // for (auto blk : loop->getBlocks()) {
            //   cout << valueString(blk) << endl;
            // }
          }
        }

        cout << "Done with branch..." << endl;
      } else {
        auto nextInstr = instr->getNextNonDebugInstruction();

        handleNextInstr(frame, nextInstr);
      }

      processed.push_back(frame);

      return true;
    }

    SymFrame* nextFrame(SymFrame* frame, Instruction* nextInstr) {
      SymFrame* nextF = new SymFrame();
      nextF->lastBlock = frame->lastBlock;
      nextF->activeInstruction = nextInstr;
      assert(nextF->activeInstruction != nullptr);
      nextF->lastFrame = frame;

      auto sVal = new SymValue();
      sVal->llvmValue = nextInstr;
      nextF->instructionValue = sVal;
      
      bool isBack = isBackwardJump(frame->activeInstruction, nextInstr);
      if (isBack) {
        nextF->tripDepth = frame->tripDepth + 1;
      } else {
        nextF->tripDepth = frame->tripDepth;
      }
      
      return nextF;
    }

    vector<SymFrame*> findEarlierStoresToSameLocation(Value* ram, Value* addr, SymFrame* source) {
      cout << "Finding earlier stores to " << valueString(ram) << endl;
      vector<SymFrame*> hazards;
      SymFrame* currentH = source;
      while (currentH != nullptr) {
        auto i = currentH->activeInstruction;
        cout << "Checking instruction " << valueString(i) << endl;
        
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
      //cout << "Checking if " << valueString(instr) << " is loop exiting" << endl;
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

      for (auto frame : completed) {
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

        for (auto node : trace.allNodes()) {
          if (isRAMLoad(node->activeInstruction)) {
            for (auto hazard : node->hazards) {
              cout << "Found hazard... " << *node << ", DD = " << node->dd(*hazard) << ", type = " << hazard->typeName << endl;

              SyntaxHazard sh;
              sh.name = hazard->typeName;
              sh.source = hazard->source->activeInstruction;
              sh.impeded = node->activeInstruction;

              if (!contains_key(sh, hazardDDs)) {
                hazardDDs[sh] = node->dd(*hazard);
              } else {
                int currentDD = hazardDDs.at(sh);
                int newDD = node->dd(*hazard);
                if (newDD < currentDD) {
                  hazardDDs[sh] = newDD;
                }
              }
            }
          }
        }

        trace.printPaths();

        for (auto frame : trace.completed) {
          assert(frame->tripDepth == (depth - 1));
          assert(trace.isLatchBranch(frame->activeInstruction));

          auto tr = trace.getTraceSoFar(frame);
          checkTrace(tr);
        }
      }
      
    }

    expr operandExpr(context& c,
                     map<SymFrame*, string>& satValues,
                     SymFrame* f) {
      assert(contains_key(f, satValues));
      
      string name = satValues[f];
      return c.bv_const(name.c_str(), getValueBitWidth(f->activeInstruction));
    }
    
    void checkTrace(const std::vector<SymFrame*>& trace) {
      context c;
      solver s(c);
      map<SymFrame*, string> satValues;
      int i = 0;
      for (auto frame : trace) {
        Instruction* instr = frame->activeInstruction;
        if (!AllocaInst::classof(instr) && instr->getType() != voidType()) {

          string exprName = valueString(instr) + to_string(i);

          cout << "Adding variable: " << exprName << ", for " << valueString(instr) << endl;
          c.bv_const(exprName.c_str(), getTypeBitWidth(instr->getType()));
          satValues[frame] = exprName;
          i++;

        }
      }

      for (auto frame : trace) {
        Instruction* instr = frame->activeInstruction;
        if (!AllocaInst::classof(instr) && instr->getType() != voidType()) {
          if (BinaryOperator::classof(instr)) {
            auto opCode = instr->getOpcode();
            if (opCode == Instruction::Add) {

              // Value* op0V = frame->activeInstruction->getOperand(0);
              // expr op0;
              // if (!ConstantInt::classof(op0V)) {
              //   op0 = operandExpr(c, satValues, frame->getOperand(0));
              // } else {
              //   op0 = c.bv_value(getValueBitWidth(op0V),
              //                    intValue(op0V));
              // }
              // expr op1 = operandExpr(c, satValues, frame->getOperand(1));
              // expr res = operandExpr(c, satValues, frame);

              // s.add(res == op0 + op1);
            }
          }
        }        
      }

      auto res = s.check();
      if (res == sat || res == unknown) {
        cout << "Possibly legal trace" << endl;
        cout << s.get_model() << endl;
      } else {
        cout << "Impossible trace" << endl;
      }
    }

    int rawDD(llvm::Instruction* load,
              llvm::Instruction* store) {
      if (!(contains_key({"ram_RAW", store, load}, hazardDDs))) {
        return -1;
      }
      
      return map_find({"ram_RAW", store, load}, hazardDDs);
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
    auto loopForwardBlock = mkBB("loop_forward_block", f);
    auto loopLoadBlock = mkBB("loop_load_block", f);
    auto loopEndBlock = mkBB("loop_end_block", f);    
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
    auto lastCountInc = loopBuilder.CreateAdd(lastCount, one);    

    auto lastPixIsThisPix =
      loopBuilder.CreateAnd(notFirstIter, loopBuilder.CreateICmpEQ(pix, lastPix));
    loopBuilder.CreateCondBr(lastPixIsThisPix, loopForwardBlock, loopLoadBlock);


    IRBuilder<> loadBuilder(loopLoadBlock);
    auto count = loadRAMVal(loadBuilder, histRam, pix);
    auto nextCountN = loadBuilder.CreateAdd(count, one);
    loadBuilder.CreateBr(loopEndBlock);

    IRBuilder<> fwdBuilder(loopForwardBlock);
    fwdBuilder.CreateBr(loopEndBlock);
    
    // auto nextCount =
    //   loopBuilder.CreateSelect(lastPixIsThisPix, lastCountInc, nextCountN);

    IRBuilder<> loopEndBuilder(loopEndBlock);
    auto nextCount =
      loopEndBuilder.CreatePHI(intType(32), 2);
    auto storeNewCount = storeRAMVal(loopEndBuilder, histRam, pix, nextCount);
    auto nextInd = loopEndBuilder.CreateAdd(indPhi, one);
    auto exitCond = loopEndBuilder.CreateICmpNE(nextInd, loopBound);

    nextCount->addIncoming(lastCountInc, loopForwardBlock);
    nextCount->addIncoming(nextCountN, loopLoadBlock);
    
    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopEndBlock);

    lastPix->addIncoming(zero, entryBlock);
    lastPix->addIncoming(pix, loopEndBlock);

    lastCount->addIncoming(zero, entryBlock);
    lastCount->addIncoming(nextCount, loopEndBlock);

    notFirstIter->addIncoming(mkInt(0, 1), entryBlock);
    notFirstIter->addIncoming(mkInt(1, 1), loopEndBlock);
    
    loopEndBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

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

    //REQUIRE(engine.rawDD(count, storeNewCount) >= 2);
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
