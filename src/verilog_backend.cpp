#include "verilog_backend.h"

#include "utils.h"

#include <llvm/Analysis/OrderedBasicBlock.h>

#include <fstream>

using namespace dbhc;
using namespace llvm;
using namespace std;

// Pull zip file for z3 via travis? https://github.com/Z3Prover/z3/releases/download/z3-4.8.4/z3-4.8.4.d6df51951f4c-x64-ubuntu-14.04.zip

namespace DHLS {

  bool needsTempStorage(llvm::Instruction* const instr,
                        MicroArchitecture& arch);

  std::ostream& operator<<(std::ostream& out, const Wire w) {
    out << w.toString();
    return out;
  }

  std::string declareReg(const std::string name, const int width) {
    return "reg [" + to_string(width - 1) + ":0] " + name;
  }

  Port inputPort(const int width, const std::string& name) {
    return {false, true, width, name, false};
  }

  Port outputPort(const int width, const std::string& name) {
    return {false, false, width, name, false};
  }

  Port outputRegPort(const int width, const std::string& name) {
    return {true, false, width, name, false};
  }
  
  Port outputDebugPort(const int width, const std::string& name) {
    return {false, false, width, name, true};
  }
  
  std::ostream& operator<<(std::ostream& out, const FunctionalUnit& unit) {
    out << unit.getModName();
    out << " " << unit.instName << "(";
    vector<string> portStrs;
    for (auto pt : unit.portWires) {
      portStrs.push_back("." + pt.first + "(" + pt.second.name + ")");
    }

    for (auto pt : unit.outWires) {
      portStrs.push_back("." + pt.first + "(" + pt.second.name + ")");
    }

    out << commaListString(portStrs) << ")";

    return out;
  }

  bool hasOutput(Instruction* instr) {
    if (StoreInst::classof(instr) ||
        BranchInst::classof(instr) ||
        AllocaInst::classof(instr) ||
        BitCastInst::classof(instr) ||
        (CallInst::classof(instr) && !isBuiltinFifoRead(instr) && !isBuiltinPortRead(instr)) ||
        ReturnInst::classof(instr)) {
      return false;
    }

    return true;
  }

  Port wireToInputPort(const Wire w) {
    assert(!w.registered);

    return {false, true, w.width, w.name, false};
  }


  Port wireToOutputPort(const Wire w) {

    return {false, false, w.width, w.name, false};
  }
  
  std::vector<Port>
  getPorts(const MicroArchitecture& arch) {
    auto& unitAssignment = arch.unitAssignment;

    vector<Port> pts = {inputPort(1, "clk"), inputPort(1, "rst")};

    std::set<std::string> alreadyChecked;
    for (auto instr : unitAssignment) {
      auto unit = instr.second;

      if (!elem(unit.instName, alreadyChecked) && unit.isExternal()) {
        alreadyChecked.insert(unit.instName);

        for (auto w : unit.portWires) {
          pts.push_back(wireToOutputPort(w.second));
        }

        for (auto w : unit.outWires) {
          pts.push_back(wireToInputPort(w.second));
        }

      }


    }

    return pts;

  }

  // Issue: what is the name of each register?
  llvm::Value* getRAMName(Value* location,
                          std::map<llvm::Instruction*, llvm::Value*>& ramNames) {
    
    //cout << "Finding location of " << valueString(location) << endl;
    
    if (Instruction::classof(location)) {
      Instruction* locInstr = dyn_cast<Instruction>(location);

      if (!AllocaInst::classof(locInstr)) {
        if (!contains_key(locInstr, ramNames)) {
          return nullptr;
        }

        Value* src = map_find(locInstr, ramNames);
        return src;
      } else {

        return locInstr;
      }
      
    } else if (Argument::classof(location)) {

      return location;
    } else {
      return nullptr;
    }

  }

  int numMemOps(const std::vector<Instruction*>& instrs) {
    int ind = 0;
    for (auto instr : instrs) {
      if (StoreInst::classof(instr) ||
          LoadInst::classof(instr) ||
          GetElementPtrInst::classof(instr)) {
        ind++;
      }
    }
    return ind;
  }

  int numMemOps(BasicBlock& bb) {
    int ind = 0;

    for (auto& instr : bb) {
      if (StoreInst::classof(&instr) ||
          LoadInst::classof(&instr) ||
          GetElementPtrInst::classof(&instr)) {
        ind++;
      }
    }
    return ind;
  }
  
  void findLocation(Value* location,
                    Instruction* instr,
                    std::map<Instruction*, llvm::Value*>& mems,
                    std::set<Instruction*>& foundOps) {

    Value* val = getRAMName(location, mems);
    if (val != nullptr) {
      mems[instr] = val;
      foundOps.insert(instr);
    } else {
      cout << "No source for " << instructionString(instr) << endl;
    }
  }

  // TODO: Turn this in to a proper dataflow analysis using LLVM dataflow builtins
  std::map<llvm::Instruction*, llvm::Value*>
  memoryOpLocations(Function* f) {
    map<Instruction*, llvm::Value*> mems;

    // // TODO: Eventually all examples that use this should be removable
    // really need to figure out what pass by value vs reference means as well?
    // Maybe non-primitive return values on functions should be banned for now?
    // It is hard to predict what calling convention will show when using pass
    // by value, and it is hard to interpret a returned pointer value in an
    // ordinary function

    // Again: The compiler defined vs. code defined distinction is relevant.
    // port list predictability does not matter for below-top-level code.

    // No returning pointers maybe is the right rule?
    // -- No dynamic allocation
    // -- No returning a reference to a piece of state on your "stack"?
    // -- Could take in 2 pointers and return one of them? Arbiters?
    //    This is an important case...
    // -- I guess you could say that each call to the function that gets a
    //    pointer is like a barrell shifter, whose inputs must remain
    //    constant for the lifetime of the pointer? But this creates a new
    //    lifetime analysis problem...

    // Maybe the invariant of this system is that each pointer points
    // to a single instance of a module?
    // You can call the copy constructor of the underlying type on 2
    // pointers, but you cannot set the value of a pointer to be
    // another pointer?
    // Q: Would the implementation of a barrel shift register selector
    //    produce this problem if it was actually implemented?

    // No passing RAMs by value?
    // Or / And: No getelementptr with variable arguments?
    // Value: a wire (registered or not)
    // Passing by value means connecting 2 wires (at some time?)
    // Passing by reference means including one modules ports
    //   in the port list of the interface of the receiving module?

    // Maybe the real issue is not returning pointers, but assigning one
    // pointer to another? Both are an issue. Returning a pointer creates
    // problems as does passing a pointer, because each of them can create
    // confusion about the mapping between pointer values and resources

    // return mems;

    for (auto& bb : f->getBasicBlockList()) {

      std::set<Instruction*> foundOps;
      while (((int) foundOps.size()) < numMemOps(bb)) {
        //cout << "FoundInstrs =  "<< foundOps.size() << endl;

        for (auto& instrPtr : bb) {

          auto instr = &instrPtr;

          if (elem(instr, foundOps)) {
            continue;
          }

          if (LoadInst::classof(instr)) {

            Value* location = instr->getOperand(0);
            findLocation(location, instr, mems, foundOps);

          } else if (StoreInst::classof(instr)) {

            Value* location = instr->getOperand(1);
            findLocation(location, instr, mems, foundOps);

          } else if (GetElementPtrInst::classof(instr)) {

            Value* location = instr->getOperand(0);
            findLocation(location, instr, mems, foundOps);

          }
        }
      }
    }

    return mems;
  }

  std::string binopName(Instruction* instr) {
    string modName;
    if (instr->getOpcode() == Instruction::Add) {
      modName = "add";
    } else if (instr->getOpcode() == Instruction::Mul) {
      modName = "mul";
    } else if (instr->getOpcode() == Instruction::Sub) {
      modName = "sub";            
    } else if (instr->getOpcode() == Instruction::FAdd) {
      modName = "fadd";
    } else if (instr->getOpcode() == Instruction::And) {
      modName = "andOp";
    } else if (instr->getOpcode() == Instruction::Or) {
      modName = "orOp";
    } else {
      assert(false);
    }
    return modName;
  }
  
  std::string memName(llvm::Instruction* instr,
                      const std::map<Instruction*, llvm::Value*>& memSrcs,
                      const std::map<llvm::Value*, std::string>& memNames) {
    return map_find(map_find(instr, memSrcs), memNames);
  }

  std::string cmpName(CmpInst::Predicate pred) {
    string modName = "";
    if (pred == CmpInst::ICMP_EQ) {
      modName = "eq";
    } else if (pred == CmpInst::ICMP_SGT) {
      modName = "sgt";
    } else if (pred == CmpInst::ICMP_SLT) {
      modName = "slt";
    } else if (pred == CmpInst::ICMP_NE) {
      modName = "ne";
    } else if (pred == CmpInst::ICMP_ULT) {
      modName = "ult";
    }else {
      cout << "Error: Unsupported predicate in cmp: " << pred << endl;
      assert(false);
    }
    return modName;
  }

  FunctionalUnit createMemUnit(std::string unitName,
                               map<Value*, std::string>& memNames,
                               map<Instruction*, Value*>& memSrcs,
                               HardwareConstraints& hcs,
                               int& readNum,
                               int& writeNum,
                               llvm::Instruction* instr) {

    assert(LoadInst::classof(instr) || StoreInst::classof(instr));
    string modName = "add";

    bool isExternal = false;
    auto rStr = unitName;
    map<string, string> modParams;

    map<string, Wire> wiring;
    map<string, Wire> outWires;
    map<string, int> defaults;

    if (StoreInst::classof(instr)) {

      Value* memVal = map_find(instr, memSrcs);
      string memSrc = memName(instr, memSrcs, memNames);

      if (!Argument::classof(memVal)) {
        cout << "&&&& Memory unit Using unit " << memSrc << " for " << instructionString(instr) << endl;
        modName = "register";

        int dataWidth = getValueBitWidth(instr->getOperand(0));
        modParams = {{"WIDTH", to_string(dataWidth)}};
        //assert(inputWidth == dataWidth);

        //cout << "Got name for op" << endl;
        unitName = memSrc;
        // These names need to match names created in the portlist. So
        // maybe this should be used to create the port list? Generate the
        // names here and then write ports for them?
        wiring = {{"wen", {true, 1, "wen_" + unitName + "_reg"}},
                  {"waddr", {true, 32, "waddr_" + unitName + "_reg"}},
                  {"wdata", {true, dataWidth, "wdata_" + unitName + "_reg"}},
                  {"raddr", {true, 32, "raddr_" + unitName + "_reg"}}};

        outWires = {{"rdata", {false, dataWidth, "rdata_" + unitName}}};

      } else {
        modName = "store";
        isExternal = true;

        int inputWidth = getValueBitWidth(instr->getOperand(0));
        // These names need to match names created in the portlist. So
        // maybe this should be used to create the port list? Generate the
        // names here and then write ports for them?
        string wStr = to_string(writeNum);

        unitName = string(instr->getOpcodeName()) + "_" + wStr;
                                                                        
        wiring = {{"wen", {true, 1, "wen_" + wStr}}, {"waddr", {true, 32, "waddr_" + wStr}}, {"wdata", {true, inputWidth, "wdata_" + wStr}}};

        outWires = {{"rdata", {false, inputWidth, "rdata_" + unitName}}};
        defaults.insert({"wen", 0});            

        writeNum++;
      }

    } else if (LoadInst::classof(instr)) {

      //cout << "Finding memories for " << valueString(instr) << endl;
      
      Value* memVal = map_find(instr, memSrcs);          
      string memSrc = memName(instr, memSrcs, memNames);

      // If we are loading from an internal RAM, not an argument
      if (!Argument::classof(memVal)) {          
        modName = "register";

        int dataWidth = getValueBitWidth(instr->getOperand(0));
        modParams = {{"WIDTH", to_string(dataWidth)}};
        
        unitName = memSrc;

        wiring = {{"raddr", {true, 32, "raddr_" + unitName + "_reg"}}, {"wen", {true, 1, "wen_" + unitName + "_reg"}}, {"waddr", {true, 32, "waddr_" + unitName + "_reg"}}, {"wdata", {true, dataWidth, "wdata_" + unitName + "_reg"}}};
        outWires = {{"rdata", {false, dataWidth, "rdata_" + unitName}}};
            
      } else {

        isExternal = true;
        
        modName = "load";

        unitName = string(instr->getOpcodeName()) + "_" + to_string(readNum);
        int inputWidth = getValueBitWidth(instr);

        wiring = {{"raddr", {true, 32, "raddr_" + to_string(readNum)}}, {"ren", {true, 1, "ren_" + to_string(readNum)}}};

        // Note: I think the "_reg not found" error is caused by the default
        // value of the functional unit not containing the ren default entry?
        defaults.insert({"ren", 0});

        outWires = {{"rdata", {false, inputWidth, "rdata_" + to_string(readNum)}}};

        readNum++;
      }

    }

    FunctionalUnit unit = {{modParams, modName, {}, defaults}, unitName, wiring, outWires, isExternal};
    return unit;
  }
  
  FunctionalUnit createUnit(std::string unitName,
                            map<Value*, std::string>& memNames,
                            map<Instruction*, Value*>& memSrcs,
                            HardwareConstraints& hcs,
                            int& readNum,
                            int& writeNum,
                            llvm::Instruction* instr) {

    string modName = "add";

    auto rStr = unitName;
    map<string, string> modParams;
    bool isExternal = false;

    map<string, Wire> wiring;
    map<string, Wire> outWires;
    map<string, int> defaults;
    //cout << "Creating a unit for " << valueString(instr) << endl;
    
    if (LoadInst::classof(instr) || StoreInst::classof(instr)) {
      return createMemUnit(unitName, memNames, memSrcs, hcs, readNum, writeNum, instr);
    } else if (BinaryOperator::classof(instr)) {
      modName = binopName(instr);
      int w0 = getValueBitWidth(instr->getOperand(0));
      int w1 = getValueBitWidth(instr->getOperand(1));

      assert(w0 == w1);

      unitName = string(instr->getOpcodeName()) + "_" + rStr;

      string opCodeName = instr->getOpcodeName();
      int width = getValueBitWidth(instr);
      if (modName != "fadd") {
        modParams = {{"WIDTH", to_string(width)}};
      }

      wiring = {{"in0", {true, width, opCodeName + "_in0_" + rStr}},
                {"in1", {true, width, opCodeName + "_in1_" + rStr}}};

      if (modName == "fadd") {
        wiring.insert({"en", {true, 1, opCodeName + "_en_" + rStr}});
        defaults.insert({"en", 0});
      }
      outWires = {{"out", {false, width, opCodeName + "_out_" + rStr}}};
    } else if (ReturnInst::classof(instr)) {
      isExternal = true;
      modName = "ret";

      defaults.insert({"valid", 0});
      wiring = {{"valid", {true, 1, "valid"}}};
      outWires = {};
          
    } else if (CmpInst::classof(instr)) {
      CmpInst::Predicate pred = dyn_cast<CmpInst>(instr)->getPredicate();
      modName = cmpName(pred);

      int w0 = getValueBitWidth(instr->getOperand(0));
      int w1 = getValueBitWidth(instr->getOperand(1));

      assert(w0 == w1);

      modParams = {{"WIDTH", to_string(w0)}};
      wiring = {{"in0", {true, w0, "cmp_in0_" + rStr}}, {"in1", {true, w0, "cmp_in1_" + rStr}}};
      outWires = {{"out", {false, 1, "cmp_out_" + rStr}}};
          
    } else if (BranchInst::classof(instr)) {
      // Branches are not scheduled, they are encoded in the
      // STG transitions
      modName = "br_dummy";
      unitName = "br_unit";
    } else if (GetElementPtrInst::classof(instr)) {
      modName = "getelementptr_" + to_string(instr->getNumOperands() - 1);
      wiring = {{"base_addr", {true, 32, "base_addr_" + rStr}}};

      for (int i = 1; i < (int) instr->getNumOperands(); i++) {
        wiring.insert({"in" + to_string(i),
              {true, 32, "gep_add_in" + to_string(i) + "_" + rStr}});
      }
      outWires = {{"out", {false, 32, "getelementptr_out_" + rStr}}};
    } else if (PHINode::classof(instr)) {
      PHINode* phi = dyn_cast<PHINode>(instr);

      modName = "phi";

      wiring = {{"last_block", {true, 32, "phi_last_block_" + rStr}}};

      int w0 = getValueBitWidth(phi);
      int nb = (int) phi->getNumIncomingValues();
      modParams = {{"WIDTH", to_string(w0)}, {"NB_PAIR", to_string(nb)}};

      wiring.insert({"s", {true, 32*nb, string("phi_s") + "_" + rStr}});
      wiring.insert({"in", {true, w0*nb, string("phi_in_") + rStr}});
      
      outWires = {{"out", {false, 32, "phi_out_" + rStr}}};

    } else if (SelectInst::classof(instr)) {
      modName = "select";
      int w0 = getValueBitWidth(instr->getOperand(1));
      int w1 = getValueBitWidth(instr->getOperand(2));

      assert(w0 == w1);

      modParams = {{"WIDTH", to_string(w0)}};
      wiring = {{"in0", {true, w0, "sel_in0_" + rStr}},
                {"in1", {true, w0, "sel_in1_" + rStr}},
                {"sel", {true, 1, "sel_sel_" + rStr}}};
      outWires = {{"out", {false, w0, "sel_out_" + rStr}}};
            
    } else if (CallInst::classof(instr)) {

      if (isBuiltinPortCall(instr)) {
        // No action

        auto fuPtr = instr->getOperand(0);

        if (Argument::classof(fuPtr)) {
          isExternal = true;
        }

        ModuleSpec modSpec;
        if (contains_key(fuPtr, hcs.modSpecs)) {
          modSpec = map_find(fuPtr, hcs.modSpecs);
        } else {
          Type* fuTp = fuPtr->getType();

          cout << "Functional unit type = " << typeString(fuTp) << endl;
          assert(PointerType::classof(fuTp));

          Type* fuDerefTp = dyn_cast<PointerType>(fuTp)->getElementType();

          assert(StructType::classof(fuDerefTp));

          StructType* structT = dyn_cast<StructType>(fuDerefTp);

          cout << "Struct name = " << string(structT->getName()) << endl;
          
          modSpec = map_find(string(structT->getName()), hcs.typeSpecs)(structT);
        }

        modName = modSpec.name;
        unitName = fuPtr->getName();
        defaults = modSpec.defaultValues;

        if (Argument::classof(fuPtr) && (unitName == "")) {
          int i = 0;
          bool foundArg = false;
          Function* f = instr->getParent()->getParent();
          for (auto& arg : f->args()) {
            if (&arg == fuPtr) {
              unitName = "arg_" + to_string(i);
              foundArg = true;
              break;
            }
            i++;
          }

          assert(foundArg);
        } else if (unitName == "") {
          unitName = sanitizeFormatForVerilogId(valueString(fuPtr));
        }

        for (auto pt : modSpec.ports) {
          if (pt.second.input()) {
            wiring.insert({pt.first, {true, pt.second.width, unitName + "_" + pt.second.name}});
          } else {
            outWires.insert({pt.first, {false, pt.second.width, unitName + "_" + pt.second.name}});            
          }
        }

      } else {

        // No action
      }
    } else if (AllocaInst::classof(instr) ||
               BitCastInst::classof(instr)) {

      // TODO: Add test case that uses real function calls and casts
      // No action for these instruction types (YET)
    } else if (SExtInst::classof(instr)) {
      modName = "sext";
      wiring = {{"in", {true, 32, "sgt_in0_" + rStr}}};
      outWires = {{"out", {false, 64, "sgt_out_" + rStr}}};
    } else if (ZExtInst::classof(instr)) {
      modName = "zext";
      int outWidth = getValueBitWidth(instr);
      int inWidth = getValueBitWidth(instr->getOperand(0));
      
      wiring = {{"in", {true, inWidth, "zext_in_" + rStr}}};
      outWires = {{"out", {false, 64, "zext_out_" + rStr}}};
      modParams = {{"IN_WIDTH", to_string(inWidth)}, {"OUT_WIDTH", to_string(outWidth)}};
    } else {
      cout << "Unsupported instruction = " << instructionString(instr) << endl;
      assert(false);
    }

    FunctionalUnit unit = {{modParams, modName, {}, defaults}, unitName, wiring, outWires, isExternal};

    return unit;
  }
  
  std::map<Instruction*, FunctionalUnit>
  assignFunctionalUnits(const STG& stg,
                        HardwareConstraints& hcs) {

    std::map<Instruction*, FunctionalUnit> units;

    auto memSrcs = memoryOpLocations(stg.getFunction());
    // map<Value*, std::string> fifoNames;
    // for (int fifoNum = 0; fifoNum < (int) stg.getFunction()->arg_size(); fifoNum++) {
    //   auto arg = getArg(stg.getFunction(), fifoNum);
    //   fifoNames[arg] = "fifo_" + to_string(fifoNum);
    // }

    map<Value*, std::string> memNames;
    int i = 0;
    for (auto src : memSrcs) {
      if ((src.first)->getName() != "") {
        memNames.insert({src.second, (src.second)->getName()});
      } else {
        memNames.insert({src.second, "ram_" + to_string(i)});
        i++;
      }
    }

    // A few issues:
    //  1. Limited vs unlimited
    //  2. Internal (adders) vs external (some memories)
    //  3. Creating predictable API for external resource ports
    //  4. Units that handle more than one operation per cycle on different ports

    int globalSuffix = 0;

    for (auto state : stg.opStates) {

      int readNum = 0; // Keeping these state-unique, need global suffix as well
      int writeNum = 0;
      int resSuffix = 0;
    
      for (auto instrG : stg.instructionsStartingAt(state.first)) {

        Instruction* instr = instrG;

        auto rStr = to_string(resSuffix);
        if (!hcs.isLimitedResource(opType(instr))) {
          rStr = to_string(globalSuffix);
        }

        string unitName = string(instr->getOpcodeName()) + "_" + rStr;
        auto unit =
          createUnit(unitName, memNames, memSrcs, hcs, readNum, writeNum, instr);
        units[instr] = unit;

        resSuffix++;
        globalSuffix++;
      }
    }
    
    return units;
  }

  map<Instruction*, Wire> createInstrNames(const STG& stg) {
    map<Instruction*, Wire> resultNames;

    int resSuffix = 0;
    for (auto state : stg.opStates) {
      for (auto instrG : state.second) {
        Instruction* instr = instrG;

        // TODO: Replace with hasOutput?
        if (StoreInst::classof(instr) ||
            BranchInst::classof(instr) ||
            AllocaInst::classof(instr) ||
            (CallInst::classof(instr) && !isBuiltinFifoRead(instr) && !isBuiltinPortRead(instr)) ||
            BitCastInst::classof(instr)) {
          continue;
        }
        
        if (ReturnInst::classof(instr)) {
          resultNames[instr] = {true, 1, string(instr->getOpcodeName()) + "_tmp_" + to_string(resSuffix)};
          resSuffix++;
          continue;
        }

        auto schedVars = map_find(instr, stg.sched.instrTimes);

        if (state.first == schedVars.front()) {
          resultNames[instr] = {true, getValueBitWidth(instr), string(instr->getOpcodeName()) + "_tmp_" + to_string(resSuffix)};
          resSuffix++;
        }
      }
    }

    return resultNames;
  }

  class ControlFlowPosition {

    StateId state;
    bool inPipe;
    int pipeStage;

  public:
    llvm::Instruction* instr;

    ControlFlowPosition(const StateId state_,
                        const bool inPipe_,
                        const int pipeStage_,
                        llvm::Instruction* const instr_) :
      state(state_), inPipe(inPipe_), pipeStage(pipeStage_), instr(instr_) {
    }

    bool inPipeline() const {
      return inPipe;
    }

    StateId stateId() const {
      return state;
    }

    BasicBlock* getBB() const {
      return instr->getParent();
    }

    int pipelineStage() const {
      return pipeStage;
    }
  };

  ControlFlowPosition position(const StateId state, Instruction* const instr) {
    return {state, false, -1, instr};
  }

  ControlFlowPosition pipelinePosition(Instruction* const instr,
                                       const StateId state,
                                       const int stage) {
    return {state, true, stage, instr};
  }

  bool producedInPipeline(llvm::Instruction* instr,
                          ElaboratedPipeline& p,
                          MicroArchitecture& arch) {
    for (auto st : p.p.getStates()) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st)) {
        if (instrG == instr) {
          return true;
        }
      }
    }
    return false;
  }

  std::string mostRecentStorageLocation(Instruction* result,
                                        ControlFlowPosition& currentPosition,
                                        MicroArchitecture& arch) {


    //cout << "Getting most recent location of " << valueString(result) << " for instruction " << valueString(currentPosition.instr) << endl;

    
    if (currentPosition.inPipeline()) {
      //cout << "We are in a pipeline" << endl;

      int stage = currentPosition.pipelineStage();
      auto p = arch.getPipeline(currentPosition.stateId());

      if (!producedInPipeline(result, p, arch)) {
        Wire tmpRes = map_find(result, arch.names);
        return tmpRes.name;
      }

      StateId argState = map_find(result, arch.stg.sched.instrTimes).back();
      StateId thisState = map_find(currentPosition.instr, arch.stg.sched.instrTimes).front();

      if (argState == thisState) {

        BasicBlock* argBB = result->getParent();
        BasicBlock* userBB = currentPosition.instr->getParent();

        assert(argBB == userBB);

        OrderedBasicBlock obb(argBB);

        if (obb.dominates(result, currentPosition.instr)) {
          Wire tmpRes = map_find(result, p.pipelineRegisters[stage]);
          return tmpRes.name;
        } else {
          //cout << "Getting data from previous stage" << endl;
          int stagePlusII = stage + p.II();
          if (stagePlusII >= (int) p.pipelineRegisters.size()) {
            assert(contains_key(result, arch.names));
                   
            Wire tmpRes = map_find(result, arch.names);

            cout << "Wire name = " << tmpRes.name << endl;
            return tmpRes.name;
          } else {
            Wire tmpRes = map_find(result, p.pipelineRegisters[stage + p.II()]);
            return tmpRes.name;
          }
        }

      } else {
        Wire tmpRes = map_find(result, p.pipelineRegisters[stage]);
        return tmpRes.name;
      }
    }

    cout << "Getting the value of " << valueString(result) << " from arch.names" << endl;

    assert(contains_key(result, arch.names));
    
    Wire tmpRes = map_find(result, arch.names);

    //cout << "Name is " << tmpRes.name << endl;
    
    return tmpRes.name;
  }

  std::string dataOutput(llvm::Instruction* instr0, const MicroArchitecture& arch) {
    auto unit0Src =
      map_find(instr0, arch.unitAssignment);

    if (isBuiltinFifoRead(instr0)) {
      return map_find(string("out_data"), unit0Src.outWires).name;
    } else if (isBuiltinPortRead(instr0)) {
      auto portName = getPortName(instr0);
      //cout << "looking for " << portName << endl;
      return map_find(string(portName), unit0Src.outWires).name;
    } else {
      if (!(unit0Src.outWires.size() == 1)) {
        cout << "Error: Cannot find 1 output wire for " << valueString(instr0) << endl;
      }
      assert(unit0Src.outWires.size() == 1);
      string valName = unit0Src.onlyOutputVar();
      return valName;
    }
  }

  std::string outputName(Value* val,
                         ControlFlowPosition& currentPosition,
                         MicroArchitecture& arch) {

    //cout << "Getting name of " << valueString(val) << endl;
    if (Instruction::classof(val)) {

      // Pointers to allocations (RAMs) always have a base
      // address of zero
      if (AllocaInst::classof(val)) {
        return "0";
      }

      assert(!AllocaInst::classof(val));


      Instruction* instr = currentPosition.instr;
      auto instr0 = dyn_cast<Instruction>(val);

      if (instr0 == instr) {
        return dataOutput(instr0, arch);
      }

      StateId argState = map_find(instr0, arch.stg.sched.instrTimes).back();
      StateId thisState = map_find(instr, arch.stg.sched.instrTimes).front();

      if (argState == thisState) {

        BasicBlock* argBB = instr0->getParent();
        BasicBlock* userBB = instr->getParent();

        assert(argBB == userBB);

        OrderedBasicBlock obb(argBB);

        if (obb.dominates(instr0, instr)) {
          return dataOutput(instr0, arch);
        } else {
          return mostRecentStorageLocation(instr0, currentPosition, arch);
        }
        
      } else {
        return mostRecentStorageLocation(instr0, currentPosition, arch);
      }


    } else if (Argument::classof(val)) {
      assert(contains_key(val, arch.memoryMap));
      
      return to_string(map_find(val, arch.memoryMap));
    } else if (ConstantInt::classof(val)) {
      
      auto valC = dyn_cast<ConstantInt>(val);
      auto apInt = valC->getValue();

      // Get num bits
      // TODO: Clean up number printouts
      int tpWidth = getValueBitWidth(val);
      string iStr = to_string(dyn_cast<ConstantInt>(val)->getSExtValue());
      if (iStr[0] == '-') {
        return "-" + parens(to_string(tpWidth) + "'d" + iStr.substr(1));
      }
      return parens(to_string(tpWidth) + "'d" + iStr);
      
    } else {
      cout << "Getting name of value " << valueString(val) << " of type " << typeString(val->getType()) << endl;
      assert(ConstantFP::classof(val));

      ConstantFP* fpVal = dyn_cast<ConstantFP>(val);

      cout << "Float value = " << valueString(fpVal) << endl;
      string floatBits = fpVal->getValueAPF().bitcastToAPInt().toString(2, false);

      cout << "Bitcast     = " << floatBits << endl;

      return "32'b" + zeroExtend(floatBits, 32);
    }

    
  }
  
  std::string verilogForCondition(Condition& cond,
                                  ControlFlowPosition pos,
                                  MicroArchitecture& arch) {
    string condStr = "";

    if (cond.isTrue()) {
      return "1";
    }

    int clNum = 0;
    for (auto cl : cond.clauses) {

      int aNum = 0;
      for (auto a : cl) {
        bool isNeg = a.negated;

        map<llvm::Value*, int> memoryMap;
        string valueStr = outputName(a.cond, pos, arch);
        
        if (isNeg) {
          condStr += "!";
        }

        condStr += "(";
        condStr += valueStr;
        condStr += ")";

        if (aNum < ((int) cl.size()) - 1) {
          condStr += " && ";
        }
        
        aNum++;
      }

      if (clNum < ((int) cond.clauses.size()) - 1) {
        condStr += " || ";
      }

      clNum++;
    }
    
    return condStr;
  }
  
  std::map<std::string, std::string>
  instructionPortAssignments(ControlFlowPosition pos,
                             MicroArchitecture& arch) {

    //cout << "Generating code for " << valueString(pos.instr) << endl;

    auto instr = pos.instr;
    auto addUnit = map_find(instr, arch.unitAssignment);

    map<string, string> assignments;

    string rS = "_reg";
        
    if (ReturnInst::classof(instr)) {
      assert(addUnit.isExternal());
      
      assignments.insert({addUnit.inputWire("valid"), "1"});
    } else if (StoreInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto wdataName = outputName(arg0, pos, arch);
      
      Value* location = instr->getOperand(1);
      auto locValue = outputName(location, pos, arch);

      assignments.insert({addUnit.inputWire("waddr"), locValue});
      assignments.insert({addUnit.inputWire("wdata"), wdataName});
      assignments.insert({addUnit.inputWire("wen"), "1"});

    } else if (LoadInst::classof(instr)) {

      Value* location = instr->getOperand(0);
      auto locValue = outputName(location, pos, arch);

      assignments.insert({addUnit.inputWire("raddr"), locValue});      

      if (contains_key(string("ren"), addUnit.portWires)) {
        assignments.insert({addUnit.inputWire("ren"), "1"});
      }

    } else if (BinaryOperator::classof(instr) ||
               CmpInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputName(arg0, pos, arch);

      auto arg1 = instr->getOperand(1);
      auto arg1Name = outputName(arg1, pos, arch);

      if (instr->getOpcode() == Instruction::FAdd) {
        assignments.insert({addUnit.portWires["en"].name, "1"});        
      }
      assignments.insert({addUnit.portWires["in0"].name, arg0Name});
      assignments.insert({addUnit.portWires["in1"].name, arg1Name});      
            
    } else if(GetElementPtrInst::classof(instr)) {

      auto numOperands = instr->getNumOperands();

      assert((numOperands == 2) || (numOperands == 3));

      auto arg0 = instr->getOperand(0);

      //cout << "arg0 = " << valueString(arg0) << endl;

      auto arg0Name = outputName(arg0, pos, arch);

      assignments.insert({addUnit.portWires["base_addr"].name, arg0Name});

      for (int i = 1; i < (int) numOperands; i++) {
        auto arg1 = instr->getOperand(i);
        //cout << "Getting operand " << valueString(arg1) << endl;
        auto arg1Name =
          outputName(arg1, pos, arch);

        assignments.insert({addUnit.portWires["in" + to_string(i)].name, arg1Name});
      }

    } else if (PHINode::classof(instr)) {
      PHINode* phi = dyn_cast<PHINode>(instr);

      //int w0 = getValueBitWidth(phi);

      string input = "{";
      string s = "{";      

      for (int i = 0; i < (int) phi->getNumIncomingValues(); i++) {
        BasicBlock* b0 = phi->getIncomingBlock(i);
        int b0Val = arch.cs.getBasicBlockNo(b0);

        Value* v0 = phi->getIncomingValue(i);

        string val0Name = outputName(v0, pos, arch);

        // if (ConstantInt::classof(v0)) {
        //   val0Name = to_string(w0) + "'d" + val0Name;
        // }

        input += val0Name;
        s += "32'd" + to_string(b0Val);

        if (i < ((int) phi->getNumIncomingValues()) - 1) {
          input += ", ";
          s += ", ";
        }
      }

      input += "}";
      s += "}";

      assignments.insert({addUnit.portWires["in"].name, input});
      assignments.insert({addUnit.portWires["s"].name, s});
      
      assignments.insert({addUnit.portWires["last_block"].name, "last_BB_reg"});

    } else if (SelectInst::classof(instr)) {
      SelectInst* sel = dyn_cast<SelectInst>(instr);

      Value* cond = sel->getCondition();
      string condName = outputName(cond, pos, arch);

      Value* trueVal = sel->getTrueValue();
      string trueName = outputName(trueVal, pos, arch);

      Value* falseVal = sel->getFalseValue();
      string falseName = outputName(falseVal, pos, arch);

      assignments.insert({addUnit.portWires["in0"].name, falseName});
      assignments.insert({addUnit.portWires["in1"].name, trueName});
      assignments.insert({addUnit.portWires["sel"].name, condName});            

    } else if (CallInst::classof(instr)) {
      // if (isBuiltinFifoCall(instr)) {

      //   if (isBuiltinFifoWrite(instr)) {
      //     assert(false);
          
      //   } else if (isBuiltinFifoRead(instr)) {
      //     assert(false);

      //   } else {
      //     assert(false);
      //   }
      // } else

      if (isBuiltinPortWrite(instr)) {
        //cout << "Operand 0 = " << valueString(instr->getOperand(0)) << endl;
          //assert(contains_key(instr->getOperand(0), arch.hcs.modSpecs));

          std::string portName = getPortName(instr);
          //cout << "Port name = " << portName << endl;
          string val = outputName(instr->getOperand(1), pos, arch);

          assignments.insert({addUnit.inputWire(portName), val});

      } else if (isBuiltinPortRead(instr)) {

      } else {
      }
    } else if (AllocaInst::classof(instr) ||
               BitCastInst::classof(instr) ||
               BranchInst::classof(instr)) {
      // No-ops
    } else if(SExtInst::classof(instr)) {

      Value* trueVal = instr->getOperand(0);
      string trueName = outputName(trueVal, pos, arch);

      assignments.insert({addUnit.portWires["in"].name, trueName});
    } else if (ZExtInst::classof(instr)) {
      Value* inVal = instr->getOperand(0);
      string inName = outputName(inVal, pos, arch);
      assignments.insert({addUnit.portWires["in"].name, inName});
    } else {

      std::string str;
      llvm::raw_string_ostream ss(str);
      ss << *(instr);

      cout << "Error: Emitting code for unknown instruction " << ss.str() << std::endl;
      assert(false);
    }

    return assignments;
  }
    

  void instructionVerilog(std::ostream& out,
                          ControlFlowPosition pos,
                          MicroArchitecture& arch) {

    auto assignments = instructionPortAssignments(pos, arch);
    
    for (auto asg : assignments) {
      out << tab(4) << asg.first << " = " << asg.second << ";" << endl;
    }
    
  }

  map<BasicBlock*, int> numberBasicBlocks(Function* const f) {
    map<BasicBlock*, int> basicBlockNos;

    int blockNo = 0;
    for (auto& bb : f->getBasicBlockList()) {
      basicBlockNos[&bb] = blockNo;
      blockNo += 1;
    }

    return basicBlockNos;

  }

  ElaboratedPipeline getPipeline(const StateId id,
                                 const std::vector<ElaboratedPipeline>& pipelines) {
    for (auto p : pipelines) {
      for (auto st : p.p.getStates()) {
        if (id == st) {
          return p;
        }
      }
    }

    assert(false);
  }

  bool isPipelineState(const StateId id,
                       const std::vector<ElaboratedPipeline>& pipelines) {
    for (auto p : pipelines) {
      for (auto st : p.p.getStates()) {
        if (id == st) {
          return true;
        }
      }
    }

    return false;
  }

  bool needsTempStorage(llvm::Instruction* const instr,
                        MicroArchitecture& arch) {

    const BasicBlock* instrBB = instr->getParent();
    OrderedBasicBlock obb(instrBB);

    for (auto& user : instr->uses()) {
      assert(Instruction::classof(user));
      Instruction* userInstr = dyn_cast<Instruction>(user.getUser());

      StateId userStart = arch.stg.instructionStartState(userInstr);
      StateId instrEnd = arch.stg.instructionEndState(instr);

      //cout << tab(1) << "User starts in " << userStart << endl;
      //cout << tab(1) << "Instr ends in " << instrEnd << endl;      
      if ((userInstr->getParent() == instrBB) &&
          (userStart == instrEnd)) {

        //cout << tab(2) << "In same basic block and same state" << endl;

        // If in same basic block but user is before instr we need temp storage
        if ((userInstr != instr) && !obb.dominates(instr, userInstr)) {
          //cout << tab(3) << "Instruction does not dominate user" << endl;
          return true;
        } else {
          continue;
        }
      } else {
        return true;
      }
    }

    return false;
  }
  
  void emitTempStorage(std::ostream& out,
                       const StateId state,
                       MicroArchitecture& arch) {

    auto& names = arch.names;
    auto& pipelines = arch.pipelines;
    auto& unitAssignment = arch.unitAssignment;
    
    out << "\t\t\t\t// Store data computed at the stage" << endl;

    auto lastI = lastInstructionInState(state, arch);
    auto pos = position(state, lastI);
    for (auto instrG : arch.stg.instructionsFinishingAt(state)) {
      Instruction* instr = instrG;

      if (hasOutput(instr)) {

        assert(contains_key(instr, names));
        
        string instrName = map_find(instr, names).name;
        
        if (isPipelineState(state, pipelines)) {
          auto p = getPipeline(state, pipelines);
          int stage = p.stageForState(state);
          pos = pipelinePosition(lastI, state, stage);
          if (stage < p.numStages() - 1) {
            instrName = map_find(instr, p.pipelineRegisters[stage + 1]).name;
            //cout << "Now instrName = " << instrName << endl;
          }
        }

        if (needsTempStorage(instr, arch)) {
          auto unit = map_find(instr, unitAssignment);

          out << tab(5) << instrName << " <= " << dataOutput(instr, arch) << ";" << endl;

        }
          
      }
    }

  }

  std::string pipelineClearOnNextCycleCondition(const ElaboratedPipeline& p) {
    string s = "";

    for (int i = 0; i < (p.numStages() - 1); i++) {
      s += "!" + p.valids.at(i).name;
      if (i < (p.numStages() - 2)) {
        s += " && ";
      }
    }

    return parens(s);
  }

  Instruction* lastInstructionInState(const StateId state,
                                      MicroArchitecture& arch) {
    Instruction* last = nullptr;
    BasicBlock* lastBB = nullptr;

    for (auto instrG : map_find(state, arch.stg.opStates)) {
      if (last == nullptr) {
        last = instrG;
        lastBB = last->getParent();
      }

      assert(instrG->getParent() == lastBB);

      OrderedBasicBlock obb(lastBB);
      if (obb.dominates(last, instrG)) {
        last = instrG;
      }
    }

    return last;
  }

  void emitPipelineStateCode(std::ostream& out,
                             const StateId state,
                             const std::vector<StateTransition>& destinations,
                             MicroArchitecture& arch) {

    auto& pipelines = arch.pipelines;

    out << tab(3) << "if (" << atState(state, arch) << ") begin " << endl;    
    out << "\t\t\t\t// Next state transition logic" << endl;

    ControlFlowPosition pos = position(state, lastInstructionInState(state, arch));
    
    if (isPipelineState(state, pipelines)) {
      auto p = getPipeline(state, pipelines);
      pos = pipelinePosition(p.getExitBranch(), state, p.numStages() - 1);
    }
    
    if (isPipelineState(state, pipelines)) {
      auto p = getPipeline(state, pipelines);

      for (auto transitionDest : destinations) {

        if (isPipelineState(transitionDest.dest, pipelines)) {

          auto destP = getPipeline(transitionDest.dest, pipelines);

          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          out << tab(4) << "if (" << verilogForCondition(transitionDest.cond, pos, arch) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " << destP.stateId << ";" << endl;

          out << "\t\t\t\tend" << endl;
          
        } else {
          int ind = p.stageForState(state);
          assert(ind == (p.numStages() - 1));

          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          // TODO: Check whether true or false on transitionDest.cond
          // causes an exit from the block
          // Rein
          out << tab(4) << "if (" << verilogForCondition(transitionDest.cond, pos, arch) << " && " << pipelineClearOnNextCycleCondition(p) << ") begin" << endl;

          out << "\t\t\t\t\tglobal_state <= " + to_string(transitionDest.dest) + + ";" << endl;
          out << "\t\t\t\tend" << endl;
        }
      }


    } else {

      for (auto transitionDest : destinations) {

        if (isPipelineState(transitionDest.dest, pipelines)) {

          auto p = getPipeline(transitionDest.dest, pipelines);

          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          out << tab(4) << "if (" << verilogForCondition(transitionDest.cond, pos, arch) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " << p.stateId << ";" << endl;

          out << "\t\t\t\t\t" << p.valids.at(0).name << " <= 1;" << endl;
          out << "\t\t\t\tend" << endl;
          
        } else {
          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          out << tab(4) << "if (" << verilogForCondition(transitionDest.cond, pos, arch) << ") begin" << endl;

          // TODO: Add multiple stall condition handling, and add stall logic
          // to other cases in control logic

          vector<string> stallConds;
          for (auto instr : arch.stg.instructionsStartingAt(state)) {

            if (isBuiltinStallCall(instr)) {

              cout << "Getting builtin stall cond for " << instr->getOperand(0) << endl;
              string cond = outputName(instr->getOperand(0),
                                       pos,
                                       arch);

              cout << "Builtin stall cond = " << cond << endl;
              stallConds.push_back(cond);
            }
          }


          if (stallConds.size() > 0) {
            out << tab(4) << "if (" << andStrings(stallConds) << ") begin " << endl;
          }
          out << "\t\t\t\t\tglobal_state <= " + to_string(transitionDest.dest) + + ";" << endl;

          if (stallConds.size() > 0) {          
            out << tab(4) << "end" << endl;
          }

          out << "\t\t\t\tend" << endl;
        }
      }


    }


    emitTempStorage(out,
                    state,
                    arch);
    
    out << "\t\t\tend" << endl;
    
  }
  
  void emitControlCode(std::ostream& out,
                       MicroArchitecture& arch,
                       const STG& stg,
                       map<Instruction*, FunctionalUnit>& unitAssignment,
                       map<Instruction*, Wire>& names,
                       const std::vector<ElaboratedPipeline>& pipelines) {

    if (arch.hasGlobalStall()) {
      out << tab(2) << "if (!global_stall) begin" << endl;
    }

    for (auto state : stg.opTransitions) {

      emitPipelineStateCode(out, state.first, state.second, arch);

    }

    if (arch.hasGlobalStall()) {
      out << tab(2) << "end" << endl;
    }
    
    out << "\t\tend" << endl;

  }

  void emitConditionalInstruction(std::ostream& out,
                                  Instruction* instrG,
                                  const StateId state,
                                  ElaboratedPipeline& p,
                                  const int i,
                                  MicroArchitecture& arch) {

    Wire valid = p.valids[i];
    
    out << "\talways @(*) begin" << endl;

    out << tab(2) << "if (" << atState(state, arch) << ") begin" << endl;
    auto pos = pipelinePosition(instrG, state, i);

    instructionVerilog(out, pos, arch);

    out << "\t\tend" << endl;
    out << "\tend" << endl;
  }

  void emitPipelineInstructionCode(std::ostream& out,
                                   const std::vector<ElaboratedPipeline>& pipelines,
                                   MicroArchitecture& arch) {
    
    out << "\t// Start pipeline instruction code" << endl;

    out << "\t// Start pipeline stages" << endl;
    for (auto p : pipelines) {

      for (int i = 0; i < (int) p.valids.size(); i++) {
        Wire valid = p.valids[i];
        StateId state = p.p.getStates().at(i);

        // Omit branch code on last stage
        for (auto instrG : arch.stg.instructionsStartingAt(state)) {
          emitConditionalInstruction(out, instrG, state, p, i, arch);
        }
      }
    }
    out << "\t// End pipeline instruction code" << endl << endl;
  }

  class UnitController {
  public:
    FunctionalUnit unit;
    std::map<StateId, std::vector<Instruction*> > instructions;
  };

  // TODO: Experiment with adding defaults to all functional unit inputs
  void emitInstructionCode(std::ostream& out,
                           MicroArchitecture& arch,
                           const std::vector<ElaboratedPipeline>& pipelines) {

    vector<UnitController> assignment;
    // Add output check
    for (auto state : arch.stg.opStates) {

      if (!isPipelineState(state.first, pipelines)) {
        for (auto instrG : arch.stg.instructionsStartingAt(state.first)) {

          Instruction* instr = instrG;

          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          bool alreadyIn = false;
          for (auto& u : assignment) {
            if (u.unit.instName == unit.instName) {
              alreadyIn = true;
              map_insert(u.instructions, state.first, instrG);
              break;
            }
          }

          if (!alreadyIn) {
            map<StateId, vector<Instruction*> > instrs;
            instrs[state.first] = {instrG};
            assignment.push_back({unit, instrs});
          }

        }
      }

    }

    for (auto controller : assignment) {

      FunctionalUnit unit = controller.unit;

      if (unit.getModName() == "br_dummy") {
        continue;
      }

      out << "\talways @(*) begin" << endl;        

      int i = 0;
      int numInstrs = 0;
      for (auto stInstrG : controller.instructions) {
        StateId state = stInstrG.first;

        if (!isPipelineState(state, pipelines)) {
          numInstrs++;
        }
      }
      bool isExternal = unit.isExternal();

      for (auto stInstrG : controller.instructions) {
        StateId state = stInstrG.first;
        auto instrsAtState = stInstrG.second;

        if (!isPipelineState(state, pipelines)) {

          out << tab(2) << ifStr(atState(state, arch)) << " begin " << endl;
          std::set<string> usedPorts;
          for (auto instrG : instrsAtState) {
            Instruction* instr = instrG;

            out << tab(4) << "// " << instructionString(instr) << endl;

            // TODO: Extract stall calculation
            vector<std::string> stallConds;

            // Stalls do not get stalled by themselves
            if (!isBuiltinStallCall(instr)) {
              for (auto instrK : arch.stg.instructionsStartingAt(state)) {
                //cout << "Instruction = " << valueString(instrK.instruction) << endl;
                if (isBuiltinStallCall(instrK)) {

                  auto stallPos = position(state, instrK);
                  string cond = outputName(instrK->getOperand(0),
                                           stallPos,
                                           arch);

                  stallConds.push_back(cond);
                }
              }
            }
            if (stallConds.size() > 0) {
              out << tab(4) << "if (" << andStrings(stallConds) << ") begin" << endl;
            }
            auto pos = position(state, instr);
            auto assigns = instructionPortAssignments(pos, arch);
            for (auto asg : assigns) {
              cout << "Using port " << asg.first << " in state " << state << endl;
              usedPorts.insert(asg.first);
            }
            instructionVerilog(out, pos, arch);

            if (stallConds.size() > 0) {            
              out << tab(4) << "end" << endl;
            }

          }

          for (auto def : unit.module.defaultValues) {
            string name = def.first;
            string ptName = map_find(name, unit.portWires).name;
            if (unit.isExternal()) {
              ptName += "_reg";
            }
            if (!elem(ptName, usedPorts)) {
              out << tab(3) << ptName << " = " << def.second << ";" << endl;
            }
          }
          out << "\t\tend else ";
          if (i == (numInstrs - 1)) {
            out << "begin " << endl;
          }

          i++;
        }

      }

      out << "\t\t\t// Default values" << endl;
      for (auto wd : unit.module.defaultValues) {
        if (isExternal) {
          out << tab(4) << unit.portWires[wd.first].name << "_reg = " << wd.second << ";" << endl;
        } else {
          out << tab(4) << unit.portWires[wd.first].name << " = " << wd.second << ";" << endl;
        }
      }
      
      out << "\t\tend" << endl;

      out << "\tend" << endl;
      
    }

  }
  
  void emitPorts(std::ostream& out,
                 const vector<Port>& allPorts) {

    for (auto pt : allPorts) {
      if (!pt.isInput) {
        out << "\treg [" << to_string(pt.width - 1) << ":0] " << pt.name << "_reg;" << endl;
      }
    }

    out << endl;

    for (auto pt : allPorts) {
      if (!pt.isInput && !pt.isDebug) {
        out << "\tassign " << pt.name << " = " << pt.name << "_reg;" << endl;
      }
    }

  }
  
  void emitFunctionalUnits(std::ostream& out,
                           map<Instruction*, FunctionalUnit>& unitAssignment) {

    // The issue of how to create builtins also comes up here. Should I have
    // parametric modules I can use for each one?
    // A: I dont need parameters yet, so lets delay that. For now just output
    //    32 bit functional units
    out << endl << "\t// Start Functional Units" << endl;
    std::set<std::string> alreadyEmitted;
    
    for (auto iUnit : unitAssignment) {
      auto unit = iUnit.second;

      if (elem(unit.instName, alreadyEmitted)) {
        continue;
      }

      alreadyEmitted.insert(unit.instName);

      // These are external functional units
      if (unit.isExternal()) {
        continue;
      }

      map<string, string> wireConns;
      for (auto w : unit.portWires) {
        out << "\t" << w.second << ";" << endl;
        wireConns.insert({w.first, w.second.name});        
      }

      // TODO: Put sequential vs combinational distincion in module description
      if ((unit.getModName() == "RAM") ||
          (unit.getModName() == "register") ||
          (unit.getModName() == "adder")) {
        wireConns.insert({"clk", "clk"});
        wireConns.insert({"rst", "rst"});
      }

      if (unit.getModName() == "fadd") {
        wireConns.insert({"clk", "clk"});
      }

      string modName = unit.getModName();
      auto params = unit.getParams();
      string instName = unit.instName;

      for (auto w : unit.outWires) {
        out << "\twire [" << w.second.width - 1 << ":0] " << w.second.name << ";" << endl;
        wireConns.insert({w.first, w.second.name});
      }

      print(out, 1, {modName, params, instName, wireConns});
      out << endl;
    }
    out << "\t// End Functional Units" << endl;
    out << endl;
  }

  void emitRegisterStorage(std::ostream& out,
                           MicroArchitecture& arch) {

    std::map<Instruction*, Wire>& names = arch.names;
    out << "\t// Start instruction result storage" << endl;
    for (auto n : names) {
      if (needsTempStorage(n.first, arch)) {
        out << "\treg [" << n.second.width - 1 << ":0] " << n.second.name << ";" << endl;
      }
    }
    out << "\t// End instruction result storage" << endl;

    out << endl;

  }

  void emitPipelineResetBlock(std::ostream& out,
                              const std::vector<ElaboratedPipeline>& pipelines) {
    
    out << "\t// Start pipeline reset block" << endl;
    out << "\talways @(posedge clk) begin" << endl;
    out << "\t\tif (rst) begin" << endl;
    for (auto p : pipelines) {

      for (auto validVar : p.valids) {
        out << "\t\t\t" << validVar.name << " <= 0;" << endl;
      }
    }
    out << "\t\tend" << endl;
    out << "\tend" << endl;
    out << "\t// End pipeline reset block" << endl << endl;
  }

  void
  emitPipelineInitiationBlock(std::ostream& out,
                              MicroArchitecture& arch) {

    auto& pipelines = arch.pipelines;

    out << "\t// Start pipeline initiation block" << endl;
    out << "\talways @(posedge clk) begin" << endl;

    for (auto p : pipelines) {
      int stage = p.II() - 1;
      StateId st = p.stateForStage(stage);

      out << tab(3) << "if (" << atState(st, arch) << ") begin" << endl;
      std::map<llvm::Value*, int> memMap;

      assert(Instruction::classof(p.getExitCondition()));
      ControlFlowPosition pos =
        pipelinePosition(dyn_cast<Instruction>(p.getExitCondition()), p.stateForStage(p.II() - 1), p.II() - 1);

      string testCond = outputName(p.getExitCondition(), pos, arch);
      auto br = p.getExitBranch();

      auto trueBlock = br->getSuccessor(0);
      BasicBlock* pBlock = p.getEntryBlock();

      // Does a true value in the branch conditional imply doing another iteration
      // of the loop
      if (trueBlock == pBlock) {
        testCond = "!" + parens(testCond);
      }
      out << "\t\t\t\t\tif(" << testCond  << ") begin" << endl;
      vector<RAM> rams;
      out << "\t\t\t\t\t\t" << p.valids.at(0).name << " <= 0;" << endl;

      out << "\t\t\t\t\tend else begin" << endl;

      out << "\t\t\t\t\t\t" << p.valids.at(0).name << " <= 1;" << endl;
      out << "\t\t\t\t\tend" << endl;
      out << "\t\t\t\tend else if (" << p.inPipe.name << ") begin " << p.valids.at(0).name << " <= 0; end" << endl;

    }

    out << "\tend" << endl;
    out << "\t// End pipeline initiation block" << endl << endl;
    
  }

  void emitPipelineRegisterChains(std::ostream& out,
                                  MicroArchitecture& arch) {
    out << tab(1) << "always @(posedge clk) begin" << endl;
    for (auto p : arch.pipelines) {

      out << tab(2) << "// Pipeline register chain" << endl;
      for (int i = 0; i < ((int) p.pipelineRegisters.size()) - 1; i++) {

        out << tab(2) << "// Register transfer from stage " << i << " to " << (i + 1) << endl;
        map<Instruction*, Wire> nameMap =
          p.pipelineRegisters[i];

        map<Instruction*, Wire> nextNameMap =
          p.pipelineRegisters[i + 1];

        set<Instruction*> instructionsFinishing;
        for (auto instrG : arch.stg.instructionsFinishingAt(p.stateForStage(i))) {
          instructionsFinishing.insert(instrG);
        }
        
        for (auto instrS : nameMap) {
          Instruction* i = instrS.first;

          // Instructions finishing in this stage have values stored in a separate
          // block
          if (!elem(i, instructionsFinishing)) {
            Wire current = instrS.second;

            assert(contains_key(i, nextNameMap));
            Wire next = map_find(i, nextNameMap);
            out << tab(2) << next.name << " <= " << current.name << ";" << endl;
          }
        }
        
      }

      out << tab(2) << "// Register transfer from stage " << (p.pipelineRegisters.size() - 1) << " to regular storage" << endl;
      for (auto instrS : p.pipelineRegisters.back()) {
        Instruction* i = instrS.first;
        if (needsTempStorage(i, arch)) {
          out << tab(2) << map_find(i, arch.names).name << " <= " << instrS.second.name << ";" << endl;
        }
      }
    }
    out << tab(1) << "end" << endl;
  }
  
  void emitPipelineValidChainBlock(std::ostream& out,
                                   MicroArchitecture& arch) {
    auto pipelines = arch.pipelines;
    
    out << "\t// Start pipeline valid chain block" << endl;
    out << "\talways @(posedge clk) begin" << endl;

    for (auto p : pipelines) {

      out << tab(1) << "if (" << p.inPipe.name << ") begin";
      out << "\t\t$display(\"// CLK Cycle\");" << endl;
      out << "\t\t$display(\"" << p.inPipe.name << " = %d\", " << p.inPipe.name << ");" << endl;
      for (int i = 0; i < (int) p.valids.size(); i++) {
        out << "\t\t$display(\"" << p.valids[i].name << " = %d\", " << p.valids[i].name << ");" << endl;
      }

      out << tab(1) << "end" << endl;
    }

    out << endl;

    out << "\t\tif (!rst) begin" << endl;
    for (auto p : pipelines) {

      //      for (auto validVar : p.valids) {
      for (int i = 0; i < ((int) p.valids.size()) - 1; i++) {
        out << "\t\t\t" << p.valids[i + 1].name << " <= " << p.valids[i].name << ";" << endl;
      }
    }
    out << "\t\tend" << endl;
    out << "\tend" << endl;
    out << "\t// End pipeline valid chain block" << endl << endl;
  }

  void emitPipelineVariables(std::ostream& out,
                             const std::vector<ElaboratedPipeline>& pipelines) {
    out << "\t// Start pipeline variables" << endl;
    for (auto p : pipelines) {
      out << "\t// -- Pipeline, II = " << p.p.II() << endl;
      out << "\t" << p.inPipe << ";" << endl;

      for (auto validVar : p.valids) {
        out << "\t" << validVar << ";" << endl;
      }

      // for (auto lastBBVar : p.lastBBs) {
      //   out << "\t" << lastBBVar << ";" << endl;
      // }
      
      out << "\t// Start stage registers" << endl;
      for (auto stage : p.pipelineRegisters) {
        out << "\t// Start stage" << endl;
        for (auto is : stage) {
          out << "\t" << is.second << ";" << endl;
        }
        out << "\t// End stage" << endl;
      }
      out << "\t// End stage registers" << endl;      
    }
    out << "\t// End pipeline variables" << endl << endl;

  }

  void emitGlobalStateVariables(std::ostream& out,
                                MicroArchitecture& arch) {
    out << tab(1) << arch.cs.getGlobalState() << ";" << endl;
    out << tab(1) << arch.cs.getLastBB() << ";" << endl;    
  }

  std::vector<ElaboratedPipeline>
  buildPipelines(llvm::Function* f, const STG& stg) {
    std::vector<ElaboratedPipeline> pipelines;

    int i = 0;
    // TODO: Add real next state number check
    int pipeState = 200000;
    for (auto p : stg.pipelines) {
      string iStr = to_string(i);
      
      ElaboratedPipeline ep(p);
      ep.stateId = pipeState + i;
      ep.inPipe = Wire(1, "in_pipeline_" + iStr);

      vector<map<Instruction*, Wire> > pipelineRegisters;
      std::set<Instruction*> pastValues;
      int regNum = 0;
      for (int j = 0; j < p.depth(); j++) {
        string jStr = to_string(j);
        ep.valids.push_back(Wire(true, 1, "pipeline_stage_" + jStr + "_valid"));

        StateId st = ep.p.getStates().at(j);
        assert(st >= 0);

        map<Instruction*, Wire> regs;
        for (auto val : pastValues) {
          regs[val] = Wire(true, 32, string("pipeline_") + val->getOpcodeName() + "_" + iStr + "_" + jStr + "_" + to_string(regNum));
          regNum++;
        }

        for (auto instrG : stg.instructionsFinishingAt(st)) {
          Instruction* i = instrG;
          if (hasOutput(i)) {          
            regs[i] = Wire(true, 32, string("pipeline_") + i->getOpcodeName() + iStr + "_" + jStr + "_" + to_string(regNum));
            pastValues.insert(i);
            regNum++;
          }
        }

        pipelineRegisters.push_back(regs);
      }

      bool foundTerm = false;
      for (auto instrG : stg.instructionsFinishingAt(p.getStates().back())) {
        if (BranchInst::classof(instrG)) {
          foundTerm = true;
          ep.exitBranch = instrG;
          break;
        }
      }

      assert(foundTerm);

      // TODO: Check that the terminator condition is evaluated in the first
      // state of the basic block

      ep.pipelineRegisters = pipelineRegisters;
      pipelines.push_back(ep);

      pipeState++;
    }

    return pipelines;
  }

  void emitComponents(std::ostream& out,
                      const VerilogComponents& debugInfo) {

    for (auto w : debugInfo.debugWires) {
      out << tab(1) << w << ";" << endl;
    }

    out << endl;

    out << tab(1) << "initial begin" << endl;
    for (auto stmt : debugInfo.initStmts) {
      out << tab(2) << stmt << endl;
    }
    out << tab(1) << "end" << endl;

    out << endl;

    for (auto mem : debugInfo.memories) {
      print(out, 1, mem);
      out << endl;
    }
    
    for (auto asg : debugInfo.debugAssigns) {
      out << tab(1) << "assign " << asg.first << " = " << asg.second << ";" << endl;
    }

    out << endl;

    for (auto blk : debugInfo.blocks) {
      print(out, 1, blk);
      out << endl;
    }

    out << endl;

    for (auto blk : debugInfo.delayBlocks) {
      print(out, 1, blk);
      out << endl;
    }

    out << endl;

    for (auto mod : debugInfo.instances) {
      print(out, 1, mod);
      out << endl;
    }
    
  }

  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<std::string, int>& memoryMap) {
    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    emitVerilog(f, stg, memoryMap, info);
  }

  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap) {
    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    emitVerilog(f, stg, memoryMap, info);
  }
  
  void emitLastBBCode(std::ostream& out,
                      llvm::Function* f,
                      const std::vector<ElaboratedPipeline>& pipelines,
                      MicroArchitecture& arch) {
    out << "\talways @(posedge clk) begin" << endl;

    if (arch.hasGlobalStall()) {
      out << tab(2) << "if (!global_stall) begin" << endl;
    }

    out << "\t\tif (rst) begin" << endl;
    out << "\t\t\tlast_BB_reg <= " << arch.cs.getBasicBlockNo(&(f->getEntryBlock())) << ";" << endl;
      //map_find(&(f->getEntryBlock()), arch.basicBlockNos) << ";" << endl;
    out << "\t\tend else begin" << endl;

    for (auto st : arch.stg.opStates) {
      if (st.second.size() > 0) {

        map<BasicBlock*, Instruction*> instructionsForBlocks;
        for (auto instrG : st.second) {
          Instruction* instr = instrG;
          BasicBlock* bb = instr->getParent();
          if (!contains_key(bb, instructionsForBlocks) && TerminatorInst::classof(instr)) {
            instructionsForBlocks.insert({bb, instrG});
          }

        }

        if (isPipelineState(st.first, pipelines)) {
          if (instructionsForBlocks.size() > 0) {
            assert(instructionsForBlocks.size() == 1);

            ElaboratedPipeline p = getPipeline(st.first, pipelines);
            auto bbI = *begin(instructionsForBlocks);

            out << tab(3) << ifStr(atState(p.stateId, arch)) << " begin" << endl;
            auto bbNo = arch.cs.getBasicBlockNo(bbI.first);
            out << tab(4) << "last_BB_reg <= " << bbNo << ";" << endl;

            out << tab(3) << "end" << endl;
          }

        } else {
          out << tab(3) << ifStr(atState(st.first, arch)) << " begin" << endl;  
          for (auto bbI : instructionsForBlocks) {

            auto bbNo = arch.cs.getBasicBlockNo(bbI.first);
            out << tab(5) << "last_BB_reg <= " << bbNo << ";" << endl;

          }
          out << tab(3) << "end" << endl;
        }
      }
    }

    out << "\t\tend" << endl;

    if (arch.hasGlobalStall()) {
      out << tab(2) << "end" << endl;
    }

    out << "\tend" << endl;
  }

  void
  emitResetCode(std::ostream& out,
                const MicroArchitecture& arch) {
    out << "\t\tif (rst) begin" << endl;
    for (auto val : arch.resetValues) {
      out << tab(3) << val.first.name << " <= " << val.second << ";" << endl;
    }

    out << "\t\tend else begin" << endl;
  }

  // TODO: Remove f, it can be retrieved from STG
  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<llvm::Value*, int>& memMap,
                         //const ArchOptions& options,
                         HardwareConstraints& hcs) {
    
    map<BasicBlock*, int> basicBlockNos = numberBasicBlocks(f);
    map<Instruction*, Wire> names = createInstrNames(stg);
    vector<ElaboratedPipeline> pipelines =
      buildPipelines(f, stg);

    map<Instruction*, FunctionalUnit> unitAssignment =
      assignFunctionalUnits(stg, hcs);

    ControlState cs;
    for (auto bb : basicBlockNos) {
      cs.setBasicBlockNo(bb.first, bb.second);
    }

    MicroArchitecture arch(cs, stg, unitAssignment, memMap, names, pipelines, hcs);

    assert(arch.stg.opStates.size() == stg.opStates.size());
    assert(arch.stg.opTransitions.size() == stg.opTransitions.size());
    return arch;
  }  

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         //const ArchOptions& options,
                         HardwareConstraints& hcs) {

    map<llvm::Value*, int> memMap;
    for (int i = 0; i < (int) f->arg_size(); i++) {
      auto& arg = *(f->arg_begin() + i);
      string name = arg.getName();
      assert(contains_key(name, memoryMap));

      memMap[dyn_cast<Value>(&arg)] = map_find(name, memoryMap);
    }

    return buildMicroArchitecture(f, stg, memMap, hcs);
  }

  // MicroArchitecture
  // buildMicroArchitecture(llvm::Function* f,
  //                        const STG& stg,
  //                        std::map<std::string, int>& memoryMap,
  //                        HardwareConstraints& hcs) {
  //   //ArchOptions options;
  //   return buildMicroArchitecture(f, stg, memoryMap, hcs);
  // }  

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap) {
                         //const ArchOptions& options) {
    HardwareConstraints hcs;
    return buildMicroArchitecture(f, stg, memoryMap, hcs);
  }
  
  // MicroArchitecture
  // buildMicroArchitecture(llvm::Function* f,
  //                        const STG& stg,
  //                        std::map<std::string, int>& memoryMap) {
  //   //ArchOptions options;
  //   HardwareConstraints hcs;
  //   return buildMicroArchitecture(f, stg, memoryMap, hcs);
  // }

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<llvm::Value*, int>& memoryMap) {
    //ArchOptions options;
    HardwareConstraints hcs;
    return buildMicroArchitecture(f, stg, memoryMap, hcs);
  }
  
  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<std::string, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo) {
    auto arch = buildMicroArchitecture(f, stg, memoryMap);
    emitVerilog(f, arch, debugInfo);
  }

  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo) {
    auto arch = buildMicroArchitecture(f, stg, memoryMap);
    emitVerilog(f, arch, debugInfo);
  }
  
  void emitVerilog(llvm::Function* f,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo) {

    cout << "Emitting verilog for" << endl;
    cout << valueString(f) << endl;
    
    string fn = f->getName();
    emitVerilog(fn, f, arch, debugInfo);
  }

  void emitVerilog(const std::string& fn,
                   llvm::Function* f,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo) {

    cout << "Emitting verilog for" << endl;
    cout << valueString(f) << endl;
    
    // string fn = f->getName();
    
    // This is a very flawed way to handle memory ports. For a few reasons
    //   1. It does not know anything about read / write port widths
    //   2. It does not know anything about read / write port resource limits
    vector<Port> allPorts = getPorts(arch);
    for (auto w : debugInfo.wiresToWatch) {
      allPorts.push_back(outputDebugPort(w.width, w.name));
    }

    if (arch.hasGlobalStall()) {
      Wire stallVar = arch.cs.getGlobalStall();
      allPorts.push_back(inputPort(stallVar.width, stallVar.name));
    }
    
    vector<string> portStrings;
    for (auto pt : allPorts) {
      portStrings.push_back(pt.toString());
    }

    ofstream out(fn + ".v");

    string fnInner = fn + "_inner";

    // Emit inner module
    out << "module " << fnInner << "(" + commaListString(portStrings) + ");" << endl;

    out << endl;

    emitPorts(out, allPorts);

    out << endl << tab(1) << "// Start debug wires and ports" << endl;
    emitComponents(out, debugInfo);
    out << endl << tab(1) << "// End debug wires and ports" << endl;
    
    emitFunctionalUnits(out, arch.unitAssignment);
    emitRegisterStorage(out, arch);

    emitPipelineVariables(out, arch.pipelines);
    emitGlobalStateVariables(out, arch);

    emitPipelineResetBlock(out, arch.pipelines);
    emitPipelineValidChainBlock(out, arch);
    emitPipelineRegisterChains(out, arch);

    emitPipelineInitiationBlock(out, arch);

    // TODO: Remove pipelines arch, it is now a field of arch
    emitLastBBCode(out, f, arch.pipelines, arch);

    out << endl;
    for (auto p : arch.pipelines) {
      out << "\tassign " << p.inPipe.name << " = global_state == " << p.stateId << ";"<< endl;
    }

    out << "\talways @(posedge clk) begin" << endl;

    emitResetCode(out, arch);

    emitControlCode(out, arch, arch.stg, arch.unitAssignment, arch.names, arch.pipelines);

    out << "\tend" << endl;
    out << endl << endl;

    emitPipelineInstructionCode(out, arch.pipelines, arch);
    emitInstructionCode(out, arch, arch.pipelines);

    out << "endmodule" << endl << endl;

    VerilogComponents comps;
    map<string, string> portConns;
    vector<Port> outerPorts;

    vector<std::string> outerPortStrings;
    outerPorts = allPorts;

    for (auto pt : outerPorts) {
      portConns.insert({pt.name, pt.name});
    }
      
    for (auto pt : outerPorts) {
      outerPortStrings.push_back(pt.toString());
    }
    
    ModuleInstance mi(fnInner, "inner", portConns);


    comps.instances.push_back(mi);

    out << "module " << fn << "(" + commaListString(outerPortStrings) + ");" << endl;
    out << endl;

    emitComponents(out, comps);

    out << "endmodule" << endl;    

    out.close();
  }

  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<std::string, int>& memoryMap) {
    Schedule s = scheduleFunction(f, hdc);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog(f, graph, memoryMap);
  }

  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<llvm::Value*, int>& memoryMap) {
    Schedule s = scheduleFunction(f, hdc);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog(f, graph, memoryMap);
  }

  std::string emitTestRAM(std::ostream& out,
                          const TestBenchSpec& tb,
                          MicroArchitecture& arch,
                          const std::map<std::string, int>& layout) {
    // TODO: Do not hardcode these values, read them from hardware constraints
    int readDelay = 1;
    int writeDelay = 3;
    int depth = 32;
    int width = 32;
    int addrWidth = 5;

    VerilogComponents ramComps;

    string memUpdate = "if (wen_del) begin data[waddr_del] <= wdata_del; end if (debug_write_en) begin data[debug_write_addr] <= debug_write_data; end ";
    for (int i = 0; i < arch.numReadPorts(); i++) {
      string iStr = to_string(i);
      memUpdate += "rdata" + iStr + "_reg <= data[raddr_" + iStr + "];";
    }

    addAlwaysBlock({"clk"}, memUpdate, ramComps);

    string ramName = "RAM_" + to_string(readDelay) + "_" + to_string(writeDelay) + "_" + to_string(depth) + "_" + to_string(width);

    vector<Port> ports;
    ports.push_back(inputPort(1, "clk"));
    ports.push_back(inputPort(1, "rst"));

    ramComps.memories.push_back({width, "data", depth});
    ramComps.debugAssigns.push_back({"debug_data", "data[debug_addr]"});
    
    for (int i = 0; i < arch.numReadPorts(); i++) {
      auto iStr = to_string(i);
      ramComps.debugWires.push_back({true, width, "rdata" + iStr + "_reg"});
      
      ports.push_back(outputPort(width, "rdata_" + iStr));
      ports.push_back(inputPort(addrWidth, "raddr_" + iStr));
      ports.push_back(inputPort(1, "ren_" + iStr));

      ramComps.debugAssigns.push_back({"rdata_" + iStr, "rdata" + iStr + "_reg"});
    }

    for (int i = 0; i < arch.numWritePorts(); i++) {
      auto iStr = to_string(i);
      ports.push_back(inputPort(width, "wdata_" + iStr));
      ports.push_back(inputPort(addrWidth, "waddr_" + iStr));
      ports.push_back(inputPort(1, "wen_" + iStr));
    }

    ports.push_back(inputPort(addrWidth, "debug_addr"));
    ports.push_back(outputPort(width, "debug_data"));

    ports.push_back(inputPort(addrWidth, "debug_write_addr"));
    ports.push_back(inputPort(width, "debug_write_data"));
    ports.push_back(inputPort(1, "debug_write_en"));        

    ramComps.debugWires.push_back({false, addrWidth, "waddr_del"});
    ramComps.debugWires.push_back({false, width, "wdata_del"});    
    ramComps.debugWires.push_back({false, 1, "wen_del"});


    // TODO: Generalize to arbitrary numbers of writes
    map<string, string> wenConns{{"clk", "clk"}, {"in", "wen_0"}, {"out", "wen_del"}};
    map<string, string> wenParams{{"WIDTH", "1"}};
    ramComps.instances.push_back({"delay", wenParams, "wen_delay", wenConns});

    map<string, string> wdataConns{{"clk", "clk"}, {"in", "wdata_0"}, {"out", "wdata_del"}};
    map<string, string> wdataParams{{"WIDTH", "32"}};
    ramComps.instances.push_back({"delay", wdataParams, "wdata_delay", wdataConns});

    map<string, string> waddrConns{{"clk", "clk"}, {"in", "waddr_0"}, {"out", "waddr_del"}};
    map<string, string> waddrParams{{"WIDTH", "5"}};
    ramComps.instances.push_back({"delay", waddrParams, "waddr_delay", waddrConns});
    
    emitModule(out, ramName, ports, ramComps);

    return ramName;
  }

  // What is the problem I'm having? blur_no_lb_tb auto generated RAM
  // has no ports for reads and writes. I need to actually instantiate
  // the module that corresponds to 
  void emitVerilogTestBench(const TestBenchSpec& tb,
                            MicroArchitecture& arch,
                            const std::map<std::string, int>& layout) {
    string modName = tb.name + "_tb";
    ofstream out(modName + ".v");

    bool hasRAM = layout.size() > 0;

    string ramName = "noRam";
    if (hasRAM && !tb.useModSpecs) {
      ramName = emitTestRAM(out, tb, arch, layout);
    }
    
    VerilogComponents comps;

    if (hasRAM && !tb.useModSpecs) {
      comps.debugWires.push_back({true, 1, "in_set_mem_phase"});
      comps.debugWires.push_back({true, 1, "in_run_phase"});
      comps.debugWires.push_back({true, 1, "in_check_mem_phase"});

      comps.debugWires.push_back({true, 32, "clocks_in_set_mem_phase"});
      comps.debugWires.push_back({true, 32, "clocks_in_run_phase"});
      comps.debugWires.push_back({true, 32, "clocks_in_check_mem_phase"});
    }

    comps.debugWires.push_back({true, 32, "num_clocks_after_reset"});
    comps.debugWires.push_back({true, 32, "total_cycles"});
    comps.debugWires.push_back({true, 32, "max_cycles"});

    if (!tb.useModSpecs) {    
      for (auto pt : getPorts(arch)) {
        comps.debugWires.push_back({false, pt.width, pt.name});

        if (elem(pt.name, tb.settableWires)) {
          comps.debugWires.push_back({true, pt.width, pt.name + "_reg"});
          comps.debugAssigns.push_back({pt.name, pt.name + "_reg"});
        }
      }
    }

    if (hasRAM && !tb.useModSpecs) {

      comps.debugWires.push_back({true, 5, "dbg_wr_addr"});
      comps.debugWires.push_back({true, 32, "dbg_wr_data"});
      comps.debugWires.push_back({true, 1, "dbg_wr_en"});

      comps.debugWires.push_back({true, 5, "dbg_addr"});    
      comps.debugWires.push_back({false, 32, "dbg_data"});

    }

    comps.delayBlocks.push_back({3, "clk_reg = !clk_reg;"});

    for (auto actionList : tb.actionsOnCycles) {
      int cycleNo = actionList.first;
      for (auto action : actionList.second) {
        addAlwaysBlock({"clk"}, "if (" + to_string(cycleNo) + " == total_cycles) begin " + action + " end", comps);
      }
    }

    for (auto actionList : tb.actionsInCycles) {
      int cycleNo = actionList.first;
      for (auto action : actionList.second) {
        addAlwaysBlock({}, "if (" + to_string(cycleNo) + " == total_cycles) begin " + action + " end", comps);
      }
    }
    
    addAlwaysBlock({"clk"}, "total_cycles <= total_cycles + 1;", comps);

    if (hasRAM && !tb.useModSpecs) {
      addAlwaysBlock({"clk"}, "if (total_cycles >= max_cycles) begin if (valid == 1 && in_check_mem_phase) begin $display(\"Passed\"); $finish(); end else begin $display(\"valid == %d. Ran out of cycles, finishing.\", valid); $finish(); end end", comps);
    } else {
      addAlwaysBlock({"clk"}, "if (total_cycles >= max_cycles) begin $display(\"Passed\"); $finish(); end", comps);
    }

    if (hasRAM && !tb.useModSpecs) {
      addAlwaysBlock({"clk"}, "if (!in_set_mem_phase) begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", comps);

      addAlwaysBlock({"clk"}, "if (in_set_mem_phase) begin clocks_in_set_mem_phase <= clocks_in_set_mem_phase + 1; end ", comps);
    }
    
    comps.initStmts.push_back("#1 clk_reg = 0;");
    comps.initStmts.push_back("#1 rst_reg = 1;");
    comps.initStmts.push_back("#1 total_cycles = 0;");

    if (hasRAM && !tb.useModSpecs) {
      comps.initStmts.push_back("#1 in_set_mem_phase = 1;");
      comps.initStmts.push_back("#1 in_check_mem_phase = 0;");
      comps.initStmts.push_back("#1 in_run_phase = 0;");
    }

    comps.initStmts.push_back("#1 max_cycles = " + to_string(tb.maxCycles) + ";");
    comps.initStmts.push_back("#1 num_clocks_after_reset = 0;");

    if (hasRAM && !tb.useModSpecs) {
      comps.initStmts.push_back("#1 clocks_in_set_mem_phase = 0;");
      comps.initStmts.push_back("#1 clocks_in_run_phase = 0;");        
      comps.initStmts.push_back("#1 clocks_in_check_mem_phase = 0;");
    }

    if (hasRAM && !tb.useModSpecs) {
      map<string, string> ramConnections{{"clk", "clk"}, {"rst", "rst"}, {"debug_addr", "dbg_addr"}, {"debug_data", "dbg_data"}, {"debug_write_addr", "dbg_wr_addr"}, {"debug_write_data", "dbg_wr_data"}, {"debug_write_en", "dbg_wr_en"}};    
      for (int i = 0; i < arch.numReadPorts(); i++) {
        auto iStr = to_string(i);
        ramConnections.insert({"raddr_" + iStr, "raddr_" + to_string(i)});
        ramConnections.insert({"rdata_" + iStr, "rdata_" + to_string(i)});
      }

      for (int i = 0; i < arch.numWritePorts(); i++) {
        auto iStr = to_string(i);
        ramConnections.insert({"waddr_" + iStr, "waddr_" + to_string(i)});
        ramConnections.insert({"wdata_" + iStr, "wdata_" + to_string(i)});
        ramConnections.insert({"wen_" + iStr, "wen_" + to_string(i)});
      }
    
      comps.instances.push_back({ramName, "ram", ramConnections});
    }
    
    if (hasRAM && !tb.useModSpecs) {
      int cyclesInRun = tb.runCycles;

      addAlwaysBlock({"clk"}, "if (in_check_mem_phase) begin if (!valid) begin $display(\"Failed: Checking memory, but the module is not done running\"); $finish(); end end", comps);

      addAlwaysBlock({"clk"}, "if (clocks_in_run_phase == (" + to_string(cyclesInRun - 1) + ")) begin in_check_mem_phase <= 1; in_run_phase <= 0; end ", comps);

      addAlwaysBlock({"clk"}, "if (in_run_phase) begin clocks_in_run_phase <= clocks_in_run_phase + 1; end", comps);

      addAlwaysBlock({"clk"}, "if (in_check_mem_phase) begin clocks_in_check_mem_phase <= clocks_in_check_mem_phase + 1; end", comps);    

      int setNum = 0;
      for (auto memName : tb.memoryInit) {
        for (int i = 0; i < (int) memName.second.size(); i++) {
          // TODO: Add memory layout info
          assert(contains_key(memName.first, layout));

          addAlwaysBlock({"clk"}, "if (in_set_mem_phase && clocks_in_set_mem_phase == " + to_string(setNum) + ") begin dbg_wr_en <= 1; dbg_wr_addr <= " + to_string(map_find(memName.first, layout) + i) + "; dbg_wr_data <= " + to_string(memName.second[i]) + "; end", comps);

          setNum++;
        
        }
      }

      int cyclesInSetMem = setNum;
      addAlwaysBlock({"clk"}, "if (clocks_in_set_mem_phase == (" + to_string(cyclesInSetMem) + ")) begin in_run_phase <= 1; rst_reg <= 0; dbg_wr_en <= 0; in_set_mem_phase <= 0; end", comps);

      addAlwaysBlock({"clk"}, "if (!in_set_mem_phase) begin dbg_wr_en <= 0; end", comps);
    
      int checkNum = 0;
      int lastNum = -1;
    
      for (auto memName : tb.memoryExpected) {
        for (int i = 0; i < (int) memName.second.size(); i++) {
          // TODO: Add memory layout info
          assert(contains_key(memName.first, layout));

          addAlwaysBlock({"clk"}, "if (in_check_mem_phase && clocks_in_check_mem_phase == " + to_string(checkNum) + ") begin dbg_addr <= " + to_string(map_find(memName.first, layout) + i) + "; end", comps);

          string str = "if (in_check_mem_phase && clocks_in_check_mem_phase == " + to_string(checkNum) + ") begin ";
          if (lastNum >= 0) {
            str += "$display(\"mem[%d] == %d\", dbg_addr, dbg_data);";

            str += "  if (dbg_data == " + to_string(memName.second[lastNum]) + ") begin $display(\"Correct.\"); end else begin $display(\"Assert failed\"); $finish(); end ";
          }
          str += "end";

          addAlwaysBlock({"clk"}, str, comps);

          lastNum = checkNum;
          checkNum++;
        }

        // Final code to check last value
        string str = "if (in_check_mem_phase && clocks_in_check_mem_phase == " + to_string(checkNum) + ") begin ";
        str += "$display(\"mem[%d] == %d\", dbg_addr, dbg_data);";

        str += "  if (dbg_data == " + to_string(memName.second[lastNum]) + ") begin $display(\"Correct.\"); end else begin $display(\"Assert failed\"); $finish(); end ";
        str += "end";
        addAlwaysBlock({"clk"}, str, comps);
      }
    }

    // Add module instances for arguments to function

    if (tb.useModSpecs) {
      auto f = arch.stg.getFunction();

      comps.debugWires.push_back({true, 1, "clk_reg"});
      comps.debugWires.push_back({true, 1, "rst_reg"});

      comps.debugWires.push_back({false, 1, "clk"});
      comps.debugWires.push_back({false, 1, "rst"});      

      comps.debugAssigns.push_back({"clk", "clk_reg"});
      comps.debugAssigns.push_back({"rst", "rst_reg"});      

      for (int i = 0; i < (int) f->arg_size(); i++) {
        //if (contains_key(getArg(f, i), arch.hcs.modSpecs)) {
        if (arch.hcs.hasArgumentSpec(getArg(f, i)) ||
            contains_key(getArg(f, i), arch.hcs.modSpecs)) {
          cout << valueString(getArg(f, i)) << "is modspeced" << endl;

          ModuleSpec s;
          if (arch.hcs.hasArgumentSpec(getArg(f, i))) {
            s = arch.hcs.getArgumentSpec(getArg(f, i)); //map_find(getArg(f, i), arch.hcs.modSpecs);
          } else {
            s = map_find(getArg(f, i), arch.hcs.modSpecs);            
          }

          string instName = getArg(f, i)->getName();
          if (instName == "") {
            instName = "arg_" + to_string(i);
          }
          map<string, string> conns;
          for (auto p : s.ports) {
            if (p.first != "rst") {
              Wire w;
              string wireName = instName + "_" + p.second.name;
              if (!elem(wireName, tb.settableWires)) {
                w = wire(p.second.width, wireName);
                comps.debugWires.push_back(w);
              } else {
                cout << "Settable wire " << p.first << endl;
                w = reg(p.second.width, wireName);
                comps.debugWires.push_back(w);
              }
              conns[p.first] = w.name;
            } else {
              conns[p.first] = "rst";
            }
          }

          conns.insert({"clk", "clk"});
          conns.insert({"rst", "rst"});
          ModuleInstance arg{s.name, instName, conns};
          comps.instances.push_back(arg);
        }
      }
    }

    map<string, string > dutConns;
    ModuleInstance dut{tb.name, "dut", dutConns};
    for (auto pt : getPorts(arch)) {
      cout << "port = " << pt.name << endl;
      if (!tb.useModSpecs || (!elem(pt.name, tb.settableWires) || (pt.name == "clk") || (pt.name == "rst"))) {
        cout << "not settable = " << pt.name << endl;        
        dut.portConnections.insert({pt.name, pt.name});
      }
    }

    comps.instances.push_back(dut);
    
    vector<Port> pts;
    emitModule(out, modName, pts, comps);

    out.close();
  }

  void noStoredValuesXWhenUsed(const MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (StoreInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string wireName = map_find(string("wdata"), unit.portWires).name;
          addAssert(notAtState(activeState, arch) + " || " +
                    wireName + " !== 'dx",
                    debugInfo);
        }
      }
    }

  }

  void noLoadedValuesXWhenUsed(const MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (LoadInst::classof(instr)) {

          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          printInstrAtState(instr, activeState, arch, debugInfo); 

          string wireName = map_find(string("rdata"), unit.outWires).name;
          addAssert(notAtState(activeState, arch) + " || " +
                    wireName + " !== 'dx",
                    debugInfo);
        }
      }
    }

  }

  void noLoadAddressesXWhenUsed(const MicroArchitecture& arch,
                                VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (LoadInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string wireName = map_find(string("raddr"), unit.portWires).name;
          addAssert(notAtState(activeState, arch) + " || " +
                    wireName + " !== 'dx",
                    debugInfo);
        }
      }
    }

  }
  
  void printInstrAtState(Instruction* instr,
                         StateId st,
                         const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    auto iStr = sanitizeFormatForVerilog(instructionString(instr));

    if (hasOutput(instr)) {
      auto unitOutput = dataOutput(instr, arch);
      addAlwaysBlock({"clk"}, "if(" + atState(st, arch) + ") begin $display(\"" + iStr + " == %d\", " + unitOutput + "); end", debugInfo);
    } else {
      addAlwaysBlock({"clk"}, "if(" + atState(st, arch) + ") begin $display(\"" + iStr + "\"); end", debugInfo);
    }
  }

  std::string atState(const StateId state, const MicroArchitecture& arch) {
    string active = parens(arch.cs.getGlobalState().name + " == " + to_string(state));
    if (arch.isPipelineState(state)) {
      auto p = arch.getPipeline(state);
      int stage = p.stageForState(state);
      active = parens(p.inPipe.name + " && " + p.valids.at(stage).name);
    }
    return active;
  }

  std::string notAtState(const StateId state, const MicroArchitecture& arch) {
    return "!" + parens(atState(state, arch));
  }

  void noPhiOutputsXWhenUsed(const MicroArchitecture& arch,
                             VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (PHINode::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string iStr = instructionString(instr);
          printInstrAtState(instr, activeState, arch, debugInfo);
          
          string wireName = unit.onlyOutputVar();

          string valCheck = wireName + " !== 'dx";
          string notActive = notAtState(st.first, arch);
          addAssert(notActive + " || " + valCheck, debugInfo);
        }
      }
    }
  }

  void noFifoReadsX(const MicroArchitecture& arch,
                    VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (isBuiltinFifoRead(instr)) {
          StateId activeState = st.first;
          string iStr = instructionString(instr);

          printInstrAtState(instr, activeState, arch, debugInfo);
          
          string wireName = dataOutput(instr, arch);

          string valCheck = wireName + " !== 'dx";
          string active = atState(st.first, arch);

          addAssert(notStr(active) + " || " + valCheck, debugInfo);
          
        }
      }
    }
  }

  void noFifoWritesX(const MicroArchitecture& arch,
                     VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (isBuiltinFifoWrite(instr)) {
          StateId activeState = st.first;
          string iStr = instructionString(instr);

          printInstrAtState(instr, activeState, arch, debugInfo);

          FunctionalUnit unit = map_find(instr, arch.unitAssignment);   
          string in0Name = map_find(string("in_data"), unit.portWires).name;

          string valCheck = in0Name + " !== " + to_string(getValueBitWidth(instr->getOperand(0))) + "'dx";
          string active = atState(st.first, arch);

          addAssert(notStr(active) + " || " + valCheck, debugInfo);
        }
      }
    }
  }
  
  void noBinopsTakeXInputs(const MicroArchitecture& arch,
                           VerilogDebugInfo& debugInfo,
                           const std::string& opName) {
    
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (BinaryOperator::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == opName) {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);
          
            string in0Name = map_find(string("in0"), unit.portWires).name;
            string in1Name = map_find(string("in1"), unit.portWires).name;

            addAssert(notAtState(activeState, arch) + " || " +
                      in0Name + " !== " + to_string(getValueBitWidth(instr)) + "'dx",
                      debugInfo);

            addAssert(notAtState(activeState, arch) + " || " +
                      in1Name + " !== " + to_string(getValueBitWidth(instr)) + "'dx",
                      debugInfo);
            
          }
        }
      }
    }

  }  

  void noBinopsProduceXOutputs(const MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo,
                               const std::string& opName) {
    
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (BinaryOperator::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == opName) {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);

            string outName = map_find(string("out"), unit.outWires).name;
            addAssert(notAtState(activeState, arch) + " || " +
                      outName + " !== " + to_string(getValueBitWidth(instr)) + "'dx",
                      debugInfo);
            
          }
        }
      }
    }

  }  
  
  void noCompareOpsTakeXInputs(const MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo,
                               const std::string& opName) {
    
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (CmpInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == opName) {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);
          
            string in0Name = map_find(string("in0"), unit.portWires).name;
            string in1Name = map_find(string("in1"), unit.portWires).name;

            addAssert(notAtState(activeState, arch) + " || " +
                      in0Name + " !== " + to_string(getValueBitWidth(instr->getOperand(0))) + "'dx",
                      debugInfo);

            addAssert(notAtState(activeState, arch) + " || " +
                      in1Name + " !== " + to_string(getValueBitWidth(instr->getOperand(1))) + "'dx",
                      debugInfo);
            
          }
        }
      }
    }

  }  
  
  void noAddsTakeXInputs(const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    noBinopsTakeXInputs(arch, debugInfo, "add");
  }

  void noMulsTakeXInputs(const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    noBinopsTakeXInputs(arch, debugInfo, "mul");
  }

  void emitModule(std::ostream& out,
                  const std::string& name,
                  std::vector<Port>& ports,
                  VerilogComponents& comps) {
    vector<string> portStrings;
    for (auto pt : ports) {
      portStrings.push_back(pt.toString());
    }
    out << "module " << name << "(" << commaListString(portStrings) << ");" << endl;
    emitComponents(out, comps);
    out << "endmodule" << endl;
  }

  void addNoXChecks(const MicroArchitecture& arch,
                    VerilogDebugInfo& info) {
    noBinopsTakeXInputs(arch, info, "fadd");
    noBinopsProduceXOutputs(arch, info, "fadd");
    noFifoReadsX(arch, info);
    noFifoWritesX(arch, info);    
    noCompareOpsTakeXInputs(arch, info, "ne");
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noLoadedValuesXWhenUsed(arch, info);
    noLoadAddressesXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);
  }

  std::string argName(llvm::Argument* arg) {
    Function* f = arg->getParent();
    bool found = false;
    int argNum = 0;
    for (auto& a : f->args()) {
      if (&a == arg) {
        found = true;
        break;
      }
      argNum++;
    }

    assert(found);
    
    return (arg->getName() == "") ? ("arg_" + to_string(argNum)) : string(arg->getName());
  }

  void TestBenchSpec::setArgPort(llvm::Argument* arg, std::string port, int cycleNo, std::string value) {
    auto argN = argName(arg) + "_" + port;
    map_insert(actionsInCycles, cycleNo, argN + " = " + value + ";");
  }

  void TestBenchSpec::setArgPort(llvm::Argument* arg, std::string port, int cycleNo, const int value) {
    setArgPort(arg, port, cycleNo, to_string(value));
  }

  void TestBenchSpec::settablePort(llvm::Argument* arg, std::string port) {
    settableWires.insert(argName(arg) + "_" + port);
  }
  
}
