#include "verilog_backend.h"

#include "utils.h"

#include <llvm/Analysis/OrderedBasicBlock.h>

#include <fstream>

using namespace dbhc;
using namespace llvm;
using namespace std;

// Pull zip file for z3 via travis? https://github.com/Z3Prover/z3/releases/download/z3-4.8.4/z3-4.8.4.d6df51951f4c-x64-ubuntu-14.04.zip

// Now: I have a new problem because of memories:
// I need to be able to describe latencies of different memories. and
// I need to be able to give the layout of inputs with multiple
// pointers pointing to the same ram, and I need to be able
// to give the latency to the in-module declared RAMs.
// The other thing is that the correspondence between RAMs and LLVM names
// is one to one inside the module, but many to one in the argument list.

namespace DHLS {

  std::ostream& operator<<(std::ostream& out, const Wire w) {
    out << w.toString();
    return out;
  }

  std::string declareReg(const std::string name, const int width) {
    return "reg [" + to_string(width - 1) + ":0] " + name;
  }

  Port inputPort(const int width, const std::string& name) {
    return {true, width, name, false};
  }

  Port outputPort(const int width, const std::string& name) {
    return {false, width, name, false};
  }

  Port outputDebugPort(const int width, const std::string& name) {
    return {false, width, name, true};
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
        CallInst::classof(instr)) {
      return false;
    }

    return true;
  }

  std::vector<Port>
  getPorts(MicroArchitecture& arch,
           std::map<llvm::Value*, int>& memLayout) {

    auto& unitAssignment = arch.unitAssignment;

    vector<Port> pts = {inputPort(1, "clk"), inputPort(1, "rst"), outputPort(1, "valid")};
    int numReadPorts = 0;
    int numWritePorts = 0;

    std::set<std::string> alreadyChecked;
    for (auto instr : unitAssignment) {
      Instruction* i = instr.first;
      auto unit = instr.second;

      if (!elem(unit.instName, alreadyChecked) && ((unit.getModName() == "load") || (unit.getModName() == "store"))) {
        alreadyChecked.insert(unit.instName);

        if (StoreInst::classof(i)) {
          int addrWidth = getValueBitWidth(i->getOperand(0));
          int width = 32;
          pts.push_back(outputPort(addrWidth, "wdata_" + to_string(numWritePorts)));
          pts.push_back(outputPort(clog2(width), "waddr_" + to_string(numWritePorts)));
          pts.push_back(outputPort(1, "wen_" + to_string(numWritePorts)));

          numWritePorts++;
        }

        if (LoadInst::classof(i)) {
          int addrWidth = getValueBitWidth(i);
          int width = 32;          
          pts.push_back(inputPort(addrWidth, "rdata_" + to_string(numReadPorts)));
          pts.push_back(outputPort(clog2(width), "raddr_" + to_string(numReadPorts)));
          pts.push_back(outputPort(1, "ren_" + to_string(numReadPorts)));

          numReadPorts++;
        }
      }


    }

    // TODO: Accomodate different width reads / writes
    // int width = 32;    
    // for (int i = 0; i < numReadPorts; i++) {
    //   pts.push_back(inputPort(width, "rdata_" + to_string(i)));
    //   pts.push_back(outputPort(clog2(width), "raddr_" + to_string(i)));
    //   pts.push_back(outputPort(1, "ren_" + to_string(i)));
    // }

    // for (int i = 0; i < numWritePorts; i++) {
    //   pts.push_back(outputPort(width, "wdata_" + to_string(i)));
    //   pts.push_back(outputPort(clog2(width), "waddr_" + to_string(i)));
    //   pts.push_back(outputPort(1, "wen_" + to_string(i)));
    // }

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
          //return "";
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
      //return "";
      return nullptr;
    }

  }

  int numMemOps(const std::vector<GuardedInstruction>& instrs) {
    int ind = 0;
    for (auto instr : instrs) {
      if (StoreInst::classof(instr.instruction) ||
          LoadInst::classof(instr.instruction) ||
          GetElementPtrInst::classof(instr.instruction)) {
        ind++;
      }
    }
    return ind;
  }

  int numMemOps(BasicBlock& bb) {
    int ind = 0;
    //for (auto instr : instrs) {
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
    //map<Instruction*, string> mems;
    map<Instruction*, llvm::Value*> mems;

    //for (auto state : stg.opStates) {

    for (auto& bb : f->getBasicBlockList()) {

      std::set<Instruction*> foundOps;
      while (((int) foundOps.size()) < numMemOps(bb)) {
        cout << "FoundInstrs =  "<< foundOps.size() << endl;

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
    } else {
      cout << "Error: Unsupported predicate in cmp: " << pred << endl;
      assert(false);
    }
    return modName;
  }

  bool canUseFor(const FunctionalUnit& unit, llvm::Instruction* const instr) {
    if (GetElementPtrInst::classof(instr)) {
      return false;
    }
    return true;
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

    auto rStr = unitName;
    map<string, string> modParams;

    map<string, Wire> wiring;
    map<string, Wire> outWires;

    if (StoreInst::classof(instr)) {

      Value* memVal = map_find(instr, memSrcs);
      string memSrc = memName(instr, memSrcs, memNames);

      if (!Argument::classof(memVal)) {
        cout << "Using unit " << memSrc << " for " << instructionString(instr) << endl;
        cout << "Getting underlying value" << endl;
        for (auto v : hcs.memoryMapping) {
          cout << "\t" << valueString(v.first) << " -> " << valueString(v.second) << endl;
        }
        Value* op = map_find(instr, hcs.memoryMapping);

        assert(contains_key(op, hcs.memSpecs));
        MemorySpec spec = map_find(op, hcs.memSpecs);
        modName = spec.modSpec.name;
        int dataWidth = spec.width;

        int inputWidth = getValueBitWidth(instr->getOperand(0));

        assert(inputWidth == dataWidth);

        cout << "Got name forop" << endl;
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

        int inputWidth = getValueBitWidth(instr->getOperand(0));

            
        // These names need to match names created in the portlist. So
        // maybe this should be used to create the port list? Generate the
        // names here and then write ports for them?
        //string wStr = "0";
        string wStr = to_string(writeNum);

        unitName = string(instr->getOpcodeName()) + "_" + wStr;
                                                                        
        wiring = {{"wen", {true, 1, "wen_" + wStr + "_reg"}}, {"waddr", {true, 32, "waddr_" + wStr + "_reg"}}, {"wdata", {true, inputWidth, "wdata_" + wStr + "_reg"}}};
        outWires = {{"rdata", {false, inputWidth, "rdata_" + unitName}}};
            
        writeNum++;
      }

    } else if (LoadInst::classof(instr)) {

      Value* memVal = map_find(instr, memSrcs);          
      string memSrc = memName(instr, memSrcs, memNames);

      // If we are loading from an internal RAM, not an argument
      if (!Argument::classof(memVal)) {          
        cout << "Using unit " << memSrc << " for " << instructionString(instr) << endl;
        Value* op = map_find(instr, hcs.memoryMapping);
        assert(contains_key(op, hcs.memSpecs));
        MemorySpec spec = map_find(op, hcs.memSpecs);
        modName = spec.modSpec.name;

        int dataWidth = spec.width;
        int inputWidth = getValueBitWidth(instr);

        assert(dataWidth == inputWidth);
            
        unitName = memSrc;

        wiring = {{"raddr", {true, 32, "raddr_" + unitName + "_reg"}}, {"wen", {true, 1, "wen_" + unitName + "_reg"}}, {"waddr", {true, 32, "waddr_" + unitName + "_reg"}}, {"wdata", {true, dataWidth, "wdata_" + unitName + "_reg"}}};
        outWires = {{"rdata", {false, dataWidth, "rdata_" + unitName}}};
            
      } else {

        modName = "load";

        unitName = string(instr->getOpcodeName()) + "_" + to_string(readNum);            
        int inputWidth = getValueBitWidth(instr);
        wiring = {{"raddr", {true, 32, "raddr_" + to_string(readNum) + "_reg"}}, {"ren", {true, 1, "ren_" + to_string(readNum) + "_reg"}}};
        outWires = {{"rdata", {false, inputWidth, "rdata_" + to_string(readNum)}}};

        readNum++;
      }

    }

    FunctionalUnit unit = {{modParams, modName}, unitName, wiring, outWires};
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

    map<string, Wire> wiring;
    map<string, Wire> outWires;

    cout << "FU for Instruction " << valueString(instr) << endl;

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
      modParams = {{"WIDTH", to_string(width)}};
      wiring = {{"in0", {true, width, opCodeName + "_in0_" + rStr}},
                {"in1", {true, width, opCodeName + "_in1_" + rStr}}};
      outWires = {{"out", {false, width, opCodeName + "_out_" + rStr}}};
    } else if (ReturnInst::classof(instr)) {
      modName = "ret";

      wiring = {{"valid", {true, 1, "valid_reg"}}};
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

      modName = "phi_" + to_string(phi->getNumIncomingValues());

      wiring = {{"last_block", {true, 32, "phi_last_block_" + rStr}}};
      for (int i = 0; i < (int) phi->getNumIncomingValues(); i++) {
        auto iStr = to_string(i);
        wiring.insert({"s" + iStr, {true, 32, "phi_s" + iStr + "_" + rStr}});
        wiring.insert({"in" + iStr, {true, 32, "phi_in" + iStr + "_" + rStr}});
      }
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
            
    } else if (AllocaInst::classof(instr) ||
               BitCastInst::classof(instr) ||
               CallInst::classof(instr)) {
      // TODO: Add test case that uses real function calls and casts
      // No action for these instruction types (YET)
    } else if (SExtInst::classof(instr)) {
      modName = "sext";
      wiring = {{"in", {true, 32, "sgt_in0_" + rStr}}};
      outWires = {{"out", {false, 64, "sgt_out_" + rStr}}};
    } else {
      cout << "Unsupported instruction = " << instructionString(instr) << endl;
      assert(false);
    }

    FunctionalUnit unit = {{modParams, modName}, unitName, wiring, outWires};

    return unit;
  }
  
  std::map<Instruction*, FunctionalUnit>
  assignFunctionalUnits(const STG& stg,
                        HardwareConstraints& hcs) {

    std::map<Instruction*, FunctionalUnit> units;

    auto memSrcs = memoryOpLocations(stg.getFunction());
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

        Instruction* instr = instrG.instruction;

        // int resS = resSuffix;
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
        Instruction* instr = instrG.instruction;

        if (StoreInst::classof(instr) ||
            BranchInst::classof(instr) ||
            AllocaInst::classof(instr) ||
            CallInst::classof(instr) ||
            BitCastInst::classof(instr)) {
          continue;
        }
        
        if (ReturnInst::classof(instr)) {
          resultNames[instr] = {true, 1, string(instr->getOpcodeName()) + "_tmp_" + to_string(resSuffix)};
          resSuffix++;
          continue;
        }

        auto schedVars = map_find(instr, stg.sched.instrTimes);
        auto* tp = instr->getType();

        cout << "type = " << typeString(tp) << endl;
        int width;
        if (IntegerType::classof(tp)) {
          IntegerType* iTp = dyn_cast<IntegerType>(tp);
          width = iTp->getBitWidth();
        } else if (PointerType::classof(tp)) {
          PointerType* pTp = dyn_cast<PointerType>(tp);


          cout << "Element type = " << typeString(pTp->getElementType()) << endl;

          assert(IntegerType::classof(pTp->getElementType()));

          IntegerType* iTp = dyn_cast<IntegerType>(pTp->getElementType());
          width = iTp->getBitWidth();

        } else {
          assert(ArrayType::classof(tp));
          Type* iTp = dyn_cast<ArrayType>(tp)->getElementType();
          assert(IntegerType::classof(iTp));
          width = dyn_cast<IntegerType>(iTp)->getBitWidth();
          
          //cout << "Array width = " << dyn_cast<ArrayType>(tp)->getElementType() << endl;
          //assert(false);
        }
        
        if (state.first == schedVars.front()) {
          resultNames[instr] = {true, width, string(instr->getOpcodeName()) + "_tmp_" + to_string(resSuffix)};
          resSuffix++;
        }
      }
    }

    return resultNames;
  }

  std::string outputName(Value* arg0,
                         map<Instruction*, FunctionalUnit> unitAssignment,
                         std::map<llvm::Value*, int>& memoryMap) {
                         //std::map<std::string, int>& memoryMap) {
    if (Instruction::classof(arg0)) {

      auto unit0Src =
        map_find(dyn_cast<Instruction>(arg0), unitAssignment);
      assert(unit0Src.outWires.size() == 1);

      string arg0Name = unit0Src.onlyOutputVar();

      return arg0Name;
    } else if (Argument::classof(arg0)) {
      // The "name" of an argument is the string representation of its
      // address in memory
      return to_string(map_find(arg0, memoryMap));
      // string name = arg0->getName();
      // return to_string(map_find(name, memoryMap));
    } else {
      assert(ConstantInt::classof(arg0));
      auto arg0C = dyn_cast<ConstantInt>(arg0);
      auto apInt = arg0C->getValue();

      assert(!apInt.isNegative());

      return to_string(dyn_cast<ConstantInt>(arg0)->getSExtValue());
    }
  }

  std::string outputName(Value* arg0,
                         StateId thisState,
                         const STG& stg,
                         map<Instruction*, FunctionalUnit>& unitAssignment,
                         map<Instruction*, Wire>& names,
                         std::map<llvm::Value*, int>& memoryMap) {
                         //std::map<std::string, int>& memoryMap) {
    if (Instruction::classof(arg0)) {

      auto instr0 = dyn_cast<Instruction>(arg0);
      StateId argState = map_find(instr0, stg.sched.instrTimes).back();

      if (argState == thisState) {

        assert(contains_key(instr0, unitAssignment));

        auto unit0Src =
          map_find(instr0, unitAssignment);

        if (unit0Src.outWires.size() != 1) {
          cout << "Error: Getting name of " << valueString(arg0) << endl;
        }
        assert(unit0Src.outWires.size() == 1);
        string arg0Name = unit0Src.onlyOutputVar();
        return arg0Name;
        
      } else {

        Wire tmpRes = map_find(instr0, names);
        return tmpRes.name;

      }


    } else if (Argument::classof(arg0)) {
      return to_string(map_find(arg0, memoryMap));
      // string name = arg0->getName();
      // return to_string(map_find(name, memoryMap));
    } else {
      assert(ConstantInt::classof(arg0));
      auto arg0C = dyn_cast<ConstantInt>(arg0);
      auto apInt = arg0C->getValue();

      //assert(!apInt.isNegative());

      return to_string(dyn_cast<ConstantInt>(arg0)->getSExtValue());
    }

  }

  // Random thought: Infinite streams + address generation?
  // Is that another way to think about what halide is doing?
  
  std::string outputName(Value* arg0,
                         Instruction* instr,
                         const STG& stg,
                         map<Instruction*, FunctionalUnit>& unitAssignment,
                         map<Instruction*, Wire>& names,
                         std::map<llvm::Value*, int>& memoryMap) {
                         //std::map<std::string, int>& memoryMap) {
                         //const std::vector<RAM>& rams) {
    cout << "Getting output" << endl;
    
    if (Instruction::classof(arg0)) {

      // Pointers to allocations (RAMs) always have a base
      // address of zero
      if (AllocaInst::classof(arg0)) {
        return "0";
      }

      assert(!AllocaInst::classof(arg0));
      
      auto instr0 = dyn_cast<Instruction>(arg0);
      StateId argState = map_find(instr0, stg.sched.instrTimes).back();
      StateId thisState = map_find(instr, stg.sched.instrTimes).front();

      if (argState == thisState) {

        BasicBlock* argBB = instr0->getParent();
        BasicBlock* userBB = instr->getParent();

        assert(argBB == userBB);

        OrderedBasicBlock obb(argBB);

        if (obb.dominates(instr0, instr)) {
          auto unit0Src =
            map_find(instr0, unitAssignment);
          assert(unit0Src.outWires.size() == 1);
          string arg0Name = unit0Src.onlyOutputVar();
          return arg0Name;
        } else {
          Wire tmpRes = map_find(instr0, names);
          return tmpRes.name;
        }
        
        // auto unit0Src =
        //   map_find(instr0, unitAssignment);
        // assert(unit0Src.outWires.size() == 1);
        // string arg0Name = unit0Src.onlyOutputVar();
        // return arg0Name;
        
      } else {

        Wire tmpRes = map_find(instr0, names);
        return tmpRes.name;

      }


    } else if (Argument::classof(arg0)) {
      return to_string(map_find(arg0, memoryMap));
      // cout << "Argument " << valueString(arg0) << endl;
      // string name = arg0->getName();
      // assert(contains_key(name, memoryMap));
      // return to_string(map_find(name, memoryMap));
    } else {
      assert(ConstantInt::classof(arg0));
      auto arg0C = dyn_cast<ConstantInt>(arg0);
      auto apInt = arg0C->getValue();

      //assert(!apInt.isNegative());

      return to_string(dyn_cast<ConstantInt>(arg0)->getSExtValue());
    }
  }

  std::string outputName(Value* arg0,
                         Instruction* instr,
                         const STG& stg,
                         map<Instruction*, FunctionalUnit>& unitAssignment,
                         map<Instruction*, Wire>& names,      
                         //std::map<std::string, int>& memoryMap,
                         std::map<llvm::Value*, int>& memoryMap,
                         const std::vector<RAM>& rams) {
    return outputName(arg0,
                      instr,
                      stg,
                      unitAssignment,
                      names,      
                      memoryMap);
    
  }
  
  std::string verilogForCondition(Condition& cond,
                                  const StateId currentState,
                                  const STG& stg,
                                  map<Instruction*, FunctionalUnit>& unitAssignment,
                                  map<Instruction*, Wire>& names) {
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
        std::vector<RAM> rams;     
        string valueStr = outputName(a.cond,
                                     currentState,
                                     stg,
                                     unitAssignment,
                                     names,
                                     memoryMap);
        
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

  void instructionVerilog(std::ostream& out,
                          Instruction* instr,
                          MicroArchitecture& arch) {

    auto addUnit = map_find(instr, arch.unitAssignment);

    //cout << "Getting verilog for " << instructionString(instr) << endl;
    if (ReturnInst::classof(instr)) {
      out << "\t\t\tvalid_reg = 1;" << endl;
    } else if (StoreInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto wdataName = outputName(arg0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);      
      
      Value* location = instr->getOperand(1);

      auto locValue = outputName(location, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);
            
      out << "\t\t\t" << addUnit.portWires["waddr"].name << " = " << locValue << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["wdata"].name << " = " << wdataName << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["wen"].name << " = 1;" << endl;

    } else if (LoadInst::classof(instr)) {

      Value* location = instr->getOperand(0);
      auto locValue = outputName(location, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      out << "\t\t\t" << addUnit.portWires["raddr"].name << " = " << locValue << ";" << endl;

      if (contains_key(string("ren"), addUnit.portWires)) {
        out << "\t\t\t" << addUnit.portWires["ren"].name << " = 1;" << endl;
      }
    } else if (BinaryOperator::classof(instr) ||
               CmpInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      //auto arg0Name = outputName(arg0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
      auto arg0Name = outputName(arg0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      auto arg1 = instr->getOperand(1);
      //auto arg1Name = outputName(arg1, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
      auto arg1Name = outputName(arg1, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      out << "\t\t\t" << addUnit.portWires["in0"].name << " = " << arg0Name << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"].name << " = " << arg1Name << ";" << endl;
            
    } else if(GetElementPtrInst::classof(instr)) {

      auto numOperands = instr->getNumOperands();

      assert((numOperands == 2) || (numOperands == 3));

      auto arg0 = instr->getOperand(0);

      cout << "arg0 = " << valueString(arg0) << endl;      

      auto arg0Name = outputName(arg0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      out << tab(3) << addUnit.portWires["base_addr"].name << " = " << arg0Name << ";" << endl;


      for (int i = 1; i < (int) numOperands; i++) {
        auto arg1 = instr->getOperand(i);
        cout << "Getting operand " << valueString(arg1) << endl;
        // auto arg1Name =
        //   outputName(arg1, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
        auto arg1Name =
          outputName(arg1, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);
        
        out << "\t\t\t" << addUnit.portWires["in" + to_string(i)].name << " = " << arg1Name << ";" << endl;
      }

    } else if (BranchInst::classof(instr)) {
      //out << "\t\t\t\t" << "last_BB = " << map_find(instr->getParent(), arch.basicBlockNos) << ";" << endl;
            
    } else if (PHINode::classof(instr)) {
      PHINode* phi = dyn_cast<PHINode>(instr);
      //assert(phi->getNumIncomingValues() == 2);

      for (int i = 0; i < (int) phi->getNumIncomingValues(); i++) {
        BasicBlock* b0 = phi->getIncomingBlock(i);
        int b0Val = map_find(b0, arch.basicBlockNos);

        Value* v0 = phi->getIncomingValue(i);
        string val0Name = outputName(v0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

        out << "\t\t\t" << addUnit.portWires["in" + to_string(i)].name << " = " << val0Name << ";" << endl;
        out << "\t\t\t" << addUnit.portWires["s" + to_string(i)].name << " = " << b0Val << ";" << endl;
      }

      out << "\t\t\t" << addUnit.portWires["last_block"].name << " = last_BB_reg;" << endl;
    } else if (SelectInst::classof(instr)) {
      SelectInst* sel = dyn_cast<SelectInst>(instr);

      Value* cond = sel->getCondition();
      //string condName = outputName(cond, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
      string condName = outputName(cond, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      Value* trueVal = sel->getTrueValue();
      //string trueName = outputName(trueVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
      string trueName = outputName(trueVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      Value* falseVal = sel->getFalseValue();
      //string falseName = outputName(falseVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
      string falseName = outputName(falseVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);      
      
      out << "\t\t\t" << addUnit.portWires["in0"].name << " = " << falseName << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"].name << " = " << trueName << ";" << endl;

      out << "\t\t\t" << addUnit.portWires["sel"].name << " = " << condName << ";" << endl;

    } else if (AllocaInst::classof(instr) ||
               CallInst::classof(instr) ||
               BitCastInst::classof(instr)) {
      // No-ops
    } else if(SExtInst::classof(instr)) {

      Value* trueVal = instr->getOperand(0);
      //string trueName = outputName(trueVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
      string trueName = outputName(trueVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      out << "\t\t\t" << addUnit.portWires["in"].name << " = " << trueName << ";" << endl;

    } else {

      std::string str;
      llvm::raw_string_ostream ss(str);
      ss << *(instr);

      cout << "Error: Emitting code for unknown instruction " << ss.str() << std::endl;
      assert(false);

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

  void emitTempStorage(std::ostream& out,
                       const StateId state,
                       const std::vector<StateTransition>& destinations,
                       const STG& stg,
                       map<Instruction*, FunctionalUnit>& unitAssignment,
                       map<Instruction*, Wire>& names,
                       const std::vector<ElaboratedPipeline>& pipelines) {

    out << "\t\t\t\t// Store data computed at the stage" << endl;

    for (auto instrG : stg.instructionsFinishingAt(state)) {
      Instruction* instr = instrG.instruction;

      if (ReturnInst::classof(instr)) {

        // No data to store on return

      } else if (hasOutput(instr)) {

        //cout << "Getting output " << instructionString(instr) << endl;

        string instrName = map_find(instr, names).name;
        auto unit = map_find(instr, unitAssignment);

        out << "\t\t\t\tif (" << verilogForCondition(instrG.cond, state, stg, unitAssignment, names) << ") begin" << endl;
        //out << "\t\t\t\tif (" << verilogForCondition(instrG.cond, instr, stg, unitAssignment, names) << ") begin" << endl;

        out << "\t\t\t\t\t" << instrName << " <= " << unit.onlyOutputVar() << ";" << endl;
        out << "\t\t\t\tend" << endl;
          
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

  void emitPipelineStateCode(std::ostream& out,
                             const StateId state,
                             const std::vector<StateTransition>& destinations,
                             const STG& stg,
                             map<Instruction*, FunctionalUnit>& unitAssignment,
                             map<Instruction*, Wire>& names,
                             const std::vector<ElaboratedPipeline>& pipelines) {

    if (isPipelineState(state, pipelines)) {
      auto p = getPipeline(state, pipelines);
      out << "\t\t\tif (" << p.inPipe.name << " && " << p.valids.at(p.stateIndex(state)).name << ") begin" << endl;
      out << "\t\t\t\t// Next state transition logic" << endl;
      for (auto transitionDest : destinations) {

        if (isPipelineState(transitionDest.dest, pipelines)) {

          auto destP = getPipeline(transitionDest.dest, pipelines);

          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          out << "\t\t\t\tif (" << verilogForCondition(transitionDest.cond, state, stg, unitAssignment, names) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " << destP.stateId << ";" << endl;

          out << "\t\t\t\tend" << endl;
          
        } else {
          int ind = p.stageForState(state);
          assert(ind == (p.numStages() - 1));

          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          // TODO: Check whether true or false on transitionDest.cond
          // causes an exit from the block
          out << "\t\t\t\tif (" << verilogForCondition(transitionDest.cond, state, stg, unitAssignment, names) << " && " << pipelineClearOnNextCycleCondition(p) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " + to_string(transitionDest.dest) + + ";" << endl;
          out << "\t\t\t\tend" << endl;
        }
      }


    } else {
      out << "\t\t\tif (global_state == " + to_string(state) + ") begin" << endl;

      out << "\t\t\t\t// Next state transition logic" << endl;
      for (auto transitionDest : destinations) {

        if (isPipelineState(transitionDest.dest, pipelines)) {

          auto p = getPipeline(transitionDest.dest, pipelines);

          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          out << "\t\t\t\tif (" << verilogForCondition(transitionDest.cond, state, stg, unitAssignment, names) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " << p.stateId << ";" << endl;

          out << "\t\t\t\t\t" << p.valids.at(0).name << " <= 1;" << endl;
          //out << "\t\t\t\t\tend" << endl;
          out << "\t\t\t\tend" << endl;
          
        } else {
          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          out << "\t\t\t\tif (" << verilogForCondition(transitionDest.cond, state, stg, unitAssignment, names) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " + to_string(transitionDest.dest) + + ";" << endl;
          out << "\t\t\t\tend" << endl;
        }
      }


    }


    emitTempStorage(out,
                    state,
                    destinations,
                    stg,
                    unitAssignment,
                    names,
                    pipelines);
    
    out << "\t\t\tend" << endl;
    
  }
  
  void emitControlCode(std::ostream& out,
                       const MicroArchitecture& arch,
                       const STG& stg,
                       map<Instruction*, FunctionalUnit>& unitAssignment,
                       map<Instruction*, Wire>& names,
                       const std::vector<ElaboratedPipeline>& pipelines) {

    if (arch.hasGlobalStall()) {
      out << tab(2) << "if (!global_stall) begin" << endl;
    }

    for (auto state : stg.opTransitions) {

      emitPipelineStateCode(out, state.first, state.second, stg, unitAssignment, names, pipelines);

    }

    if (arch.hasGlobalStall()) {
      out << tab(2) << "end" << endl;
    }
    
    out << "\t\tend" << endl;

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

        if (i == 0) {
          out << "\talways @(*) begin" << endl;
          out << "\t\tif (" << p.inPipe.name << " && " << valid.name << ") begin" << endl;

          auto instrG = p.exitBranch;
          Instruction* instr = instrG.instruction;

          out << "\t\t\tif (" << verilogForCondition(instrG.cond, state, arch.stg, arch.unitAssignment, arch.names) << ") begin" << endl;

          instructionVerilog(out, instr, arch);

          out << "\t\t\tend" << endl;
          out << "\t\tend" << endl;
          out << "\tend" << endl;
        }

        // Omit branch code on last stage
        for (auto instrG : arch.stg.instructionsStartingAt(state)) {
          out << "\talways @(*) begin" << endl;
          out << "\t\tif (" << p.inPipe.name << " && " << valid.name << ") begin" << endl;

          Instruction* instr = instrG.instruction;

          out << "\t\t\tif (" << verilogForCondition(instrG.cond, state, arch.stg, arch.unitAssignment, arch.names) << ") begin" << endl;

          
          instructionVerilog(out, instr, arch);

          out << "\t\t\tend" << endl;
          out << "\t\tend" << endl;
          out << "\tend" << endl;
        }
      }
    }
    out << "\t// End pipeline instruction code" << endl << endl;
  }

  class UnitController {
  public:
    FunctionalUnit unit;
    std::map<StateId, std::vector<GuardedInstruction> > instructions;
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

          Instruction* instr = instrG.instruction;

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
            map<StateId, vector<GuardedInstruction> > instrs;
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

      for (auto stInstrG : controller.instructions) {
        StateId state = stInstrG.first;
        auto instrsAtState = stInstrG.second;

        if (!isPipelineState(state, pipelines)) {

          out << "\t\tif (global_state == " + to_string(state) + ") begin" << endl;

          for (auto instrG : instrsAtState) {
            Instruction* instr = instrG.instruction;

            out << "\t\t\tif (" << verilogForCondition(instrG.cond, state, arch.stg, arch.unitAssignment, arch.names) << ") begin" << endl;

            out << tab(4) << "// " << instructionString(instr) << endl;
            instructionVerilog(out, instr, arch);

            out << "\t\t\tend else begin " << endl;
            out << "\t\t\t// Default values" << endl;
            for (auto w : unit.portWires) {
              out << tab(4) << w.second.name << " = 0;" << endl;
            }

            if (BranchInst::classof(instr)) {
              out << tab(4) << "last_BB = last_BB_reg;" << endl;
            }
            out << "\t\t\tend" << endl;
          }

          out << "\t\tend else ";
          if (i == (numInstrs - 1)) {
            out << "begin " << endl;
          }

          i++;
        }

      }

      out << "\t\t\t// Default values" << endl;
      for (auto w : unit.portWires) {
        out << "\t\t\t" << w.second.name << " = 0;" << endl;
      }

      if (unit.getModName() == "br_dummy") {
        out << tab(4) << "last_BB = last_BB_reg;" << endl;
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
      if ((unit.getModName() == "load") ||
          (unit.getModName() == "store") ||
          (unit.getModName() == "ret")) {
        continue;
      }

      map<string, string> wireConns;
      for (auto w : unit.portWires) {
        out << "\t" << w.second << ";" << endl;
        wireConns.insert({w.first, w.second.name});        
      }

      // TODO: Put sequential vs combinational distincion in module description
      if ((unit.getModName() == "RAM") || (unit.getModName() == "register")) {
        wireConns.insert({"clk", "clk"});
        wireConns.insert({"rst", "rst"});
      }

      string modName = unit.getModName();
      auto params = unit.getParams();
      string instName = unit.instName;

      for (auto w : unit.outWires) {
        out << "\twire [" << w.second.width - 1 << ":0] " << w.second.name << ";" << endl;
        wireConns.insert({w.first, w.second.name});
      }

      print(out, 1, {modName, params, instName, wireConns});
    }
    out << "\t// End Functional Units" << endl;
    out << endl;
  }

  void emitRegisterStorage(std::ostream& out,
                           std::map<Instruction*, Wire>& names) {
    out << "\t// Start instruction result storage" << endl;
    for (auto n : names) {
      out << "\treg [" << n.second.width - 1 << ":0] " << n.second.name << ";" << endl;
    }
    out << "\t// End instruction result storage" << endl;

    // out << "\t// Start instruction result resets" << endl;
    // out << tab(1) << "always @(posedge clk) begin" << endl;
    // out << tab(2) << "if (rst) begin" << endl;
    // for (auto n : names) {
    //   out << tab(3) << n.second.name << " <= 0;" << endl;
    // }
    // out << tab(2) << "end" << endl;
    // out << tab(1) << "end" << endl;
    // out << "\t// End instruction result resets" << endl;

    out << endl;

  }

  void emitPipelineResetBlock(std::ostream& out,
                              const std::vector<ElaboratedPipeline>& pipelines) {
    
    out << "\t// Start pipeline reset block" << endl;
    out << "\talways @(posedge clk) begin" << endl;
    out << "\t\tif (rst) begin" << endl;
    for (auto p : pipelines) {

      //out << "\t\t\t" << p.inPipe.name << " <= 0;" << endl;

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
                              STG& stg,
                              map<Instruction*, FunctionalUnit>& unitAssignment,
                              std::map<Instruction*, Wire>& names,
                              const std::vector<ElaboratedPipeline>& pipelines) {

    out << "\t// Start pipeline initiation block" << endl;
    out << "\talways @(posedge clk) begin" << endl;

    for (auto p : pipelines) {
      out << "\t\t\t\tif (" << p.valids.at(p.II() - 1).name << " && " << p.inPipe.name << ") begin" << endl;
      std::map<llvm::Value*, int> memMap;
      string testCond = outputName(p.getExitCondition(), unitAssignment, memMap);
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
      out << "\t\t\t\tend else begin " << p.valids.at(0).name << " <= 0; end" << endl;

    }

    out << "\tend" << endl;
    out << "\t// End pipeline initiation block" << endl << endl;
    
  }
  
  void emitPipelineValidChainBlock(std::ostream& out,
                                   const std::vector<ElaboratedPipeline>& pipelines) {
    
    out << "\t// Start pipeline valid chain block" << endl;
    out << "\talways @(posedge clk) begin" << endl;

    for (auto p : pipelines) {

      out << "\t\t$display(\"// CLK Cycle\");" << endl;
      out << "\t\t$display(\"" << p.inPipe.name << " = %d\", " << p.inPipe.name << ");" << endl;
      for (int i = 0; i < (int) p.valids.size(); i++) {
        out << "\t\t$display(\"" << p.valids[i].name << " = %d\", " << p.valids[i].name << ");" << endl;
      }
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

  void emitGlobalStateVariables(std::ostream& out) {
    out << "\treg [31:0] global_state;" << endl << endl;
    out << "\treg [31:0] last_BB_reg;" << endl << endl;
    out << "\treg [31:0] last_BB;" << endl << endl;    
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
          regs[val] = Wire(true, 32, "pipeline_reg_" + iStr + "_" + jStr + "_" + to_string(regNum));
          regNum++;
        }

        for (auto instrG : stg.instructionsFinishingAt(st)) {
          Instruction* i = instrG.instruction;
          if (hasOutput(i)) {          
            regs[i] = Wire(true, 32, "pipeline_reg_" + iStr + "_" + jStr + "_" + to_string(regNum));
            pastValues.insert(i);
            regNum++;
          }
        }

        pipelineRegisters.push_back(regs);
      }

      bool foundTerm = false;
      for (auto instrG : stg.instructionsFinishingAt(p.getStates().back())) {
        if (BranchInst::classof(instrG.instruction)) {
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
    out << "\t\t\tlast_BB_reg <= " << map_find(&(f->getEntryBlock()), arch.basicBlockNos) << ";" << endl;
    out << "\t\tend else begin" << endl;

    for (auto st : arch.stg.opStates) {
      assert(st.second.size() > 0);

      map<BasicBlock*, GuardedInstruction> instructionsForBlocks;
      for (auto instrG : st.second) {
        Instruction* instr = instrG.instruction;
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

          out << tab(3) << "if (global_state == " << p.stateId << ") begin" << endl;

          auto bbNo = map_find(bbI.first, arch.basicBlockNos);
          out << tab(4) << "last_BB_reg <= " << bbNo << ";" << endl;
          //out << tab(4) << "end" << endl;
          out << tab(3) << "end" << endl;
        }

      } else {
        out << tab(3) << "if (global_state == " << st.first << ") begin" << endl;
        for (auto bbI : instructionsForBlocks) {
          out << tab(4) << "if (" << verilogForCondition(bbI.second.cond, st.first, arch.stg, arch.unitAssignment, arch.names) << ") begin" << endl;
          auto bbNo = map_find(bbI.first, arch.basicBlockNos);
          out << tab(5) << "last_BB_reg <= " << bbNo << ";" << endl;
          out << tab(4) << "end" << endl;
        }
        out << tab(3) << "end" << endl;
      }
    }

    out << "\t\tend" << endl;

    if (arch.hasGlobalStall()) {
      out << tab(2) << "end" << endl;
    }

    out << "\tend" << endl;
  }

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<llvm::Value*, int>& memMap,
                         const ArchOptions& options,
                         HardwareConstraints& hcs) {
    
    map<BasicBlock*, int> basicBlockNos = numberBasicBlocks(f);
    map<Instruction*, Wire> names = createInstrNames(stg);
    vector<ElaboratedPipeline> pipelines =
      buildPipelines(f, stg);

    map<Instruction*, FunctionalUnit> unitAssignment =
      assignFunctionalUnits(stg, hcs);

    // TODO: Add rams
    vector<RAM> rams;
    MicroArchitecture arch(options, stg, unitAssignment, memMap, names, basicBlockNos, pipelines, rams);

    if (options.globalStall) {
      arch.globalStall.push_back({false, 1, "global_stall"});
    }

    assert(arch.stg.opStates.size() == stg.opStates.size());
    assert(arch.stg.opTransitions.size() == stg.opTransitions.size());
    return arch;
  }  

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         const ArchOptions& options,
                         HardwareConstraints& hcs) {

    map<llvm::Value*, int> memMap;
    for (int i = 0; i < (int) f->arg_size(); i++) {
      auto& arg = *(f->arg_begin() + i);
      string name = arg.getName();
      assert(contains_key(name, memoryMap));

      memMap[dyn_cast<Value>(&arg)] = map_find(name, memoryMap);
    }

    return buildMicroArchitecture(f, stg, memMap, options, hcs);
  }

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         HardwareConstraints& hcs) {
    ArchOptions options;
    return buildMicroArchitecture(f, stg, memoryMap, options, hcs);
  }  

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         const ArchOptions& options) {
    HardwareConstraints hcs;
    return buildMicroArchitecture(f, stg, memoryMap, options, hcs);
  }
  
  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap) {
    ArchOptions options;
    HardwareConstraints hcs;
    return buildMicroArchitecture(f, stg, memoryMap, options, hcs);
  }

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<llvm::Value*, int>& memoryMap) {
    ArchOptions options;
    HardwareConstraints hcs;
    return buildMicroArchitecture(f, stg, memoryMap, options, hcs);
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

    string fn = f->getName();

    // This is a very flawed way to handle memory ports. For a few reasons
    //   1. It does not know anything about read / write port widths
    //   2. It does not know anything about read / write port resource limits
    vector<Port> allPorts = getPorts(arch, arch.memoryMap);
    for (auto w : debugInfo.wiresToWatch) {
      allPorts.push_back(outputDebugPort(w.width, w.name));
    }

    if (arch.globalStall.size() > 0) {
      assert(arch.globalStall.size() == 1);
      Wire stallVar = arch.globalStall[0];
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
    emitRegisterStorage(out, arch.names);

    emitPipelineVariables(out, arch.pipelines);
    emitGlobalStateVariables(out);

    emitPipelineResetBlock(out, arch.pipelines);
    emitPipelineValidChainBlock(out, arch.pipelines);

    emitPipelineInitiationBlock(out, arch.stg, arch.unitAssignment, arch.names, arch.pipelines);
    // TODO: Remove pipelines arch, it is now a field of arch
    emitLastBBCode(out, f, arch.pipelines, arch);

    out << endl;
    for (auto p : arch.pipelines) {
      out << "\tassign " << p.inPipe.name << " = global_state == " << p.stateId << ";"<< endl;
    }

    out << "\talways @(posedge clk) begin" << endl;

    out << "\t\tif (rst) begin" << endl;
    // TODO: Change this from 0 to the global state that contains the entry block
    
    out << "\t\t\tglobal_state <= 0;" << endl;
    out << "\t\tend else begin" << endl;

    emitControlCode(out, arch, arch.stg, arch.unitAssignment, arch.names, arch.pipelines);

    out << "\tend" << endl;
    out << endl << endl;

    emitPipelineInstructionCode(out, arch.pipelines, arch);
    emitInstructionCode(out, arch, arch.pipelines);

    out << "endmodule" << endl << endl;

    // Emit outer module with memory controller
    VerilogComponents comps;    
    map<string, string> portConns;
    vector<Port> outerPorts;

    vector<std::string> outerPortStrings;
    if (arch.archOptions.memInterface == MEM_INTERFACE_DIRECT) {

      outerPorts = allPorts;

      for (auto pt : outerPorts) {
        //        outerPortStrings.push_back(pt.toString());
        portConns.insert({pt.name, pt.name});
      }
      
      
    } else if (arch.archOptions.memInterface == MEM_INTERFACE_AXI4_LITE) {
      outerPorts.push_back(inputPort(1, "clk"));
      outerPorts.push_back(inputPort(1, "rst"));
      outerPorts.push_back(outputPort(1, "valid"));

      outerPorts.push_back(outputPort(3, "s_axil_awprot"));
      outerPorts.push_back(outputPort(3, "s_axil_arprot"));

      outerPorts.push_back(inputPort(1, "s_axil_arready"));
      outerPorts.push_back(inputPort(1, "s_axil_rvalid"));
      outerPorts.push_back(inputPort(2, "s_axil_rresp"));
      outerPorts.push_back(inputPort(32, "s_axil_rdata"));

      outerPorts.push_back(outputPort(32, "s_axil_araddr"));
      outerPorts.push_back(outputPort(1, "s_axil_arvalid"));

      outerPorts.push_back(outputPort(32, "s_axil_awaddr"));
      outerPorts.push_back(outputPort(1, "s_axil_awvalid"));
      outerPorts.push_back(inputPort(1, "s_axil_awready"));            

      outerPorts.push_back(outputPort(5, "s_axil_wstrb"));
      outerPorts.push_back(outputPort(32, "s_axil_wdata"));            
      outerPorts.push_back(outputPort(1, "s_axil_wvalid"));            

      outerPorts.push_back(inputPort(1, "s_axil_wready"));
      outerPorts.push_back(inputPort(1, "s_axil_wresp"));                        
      outerPorts.push_back(inputPort(1, "s_axil_vvalid"));                        

      outerPorts.push_back(outputPort(1, "s_axil_bready"));
      outerPorts.push_back(inputPort(1, "s_axil_bresp"));

      outerPorts.push_back(inputPort(1, "s_axil_bvalid"));
      outerPorts.push_back(outputPort(1, "s_axil_rready"));

      portConns.insert({"valid", "valid"});
      portConns.insert({"clk", "clk"});
      portConns.insert({"rst", "rst"});
      portConns.insert({"raddr_0", "raddr_0"});
      portConns.insert({"rdata_0", "rdata_0"});
      portConns.insert({"waddr_0", "waddr_0"});
      portConns.insert({"wdata_0", "wdata_0"});
      portConns.insert({"wen_0", "wen_0"});
      portConns.insert({"ren_0", "ren_0"});      

      portConns.insert({"global_stall", "global_stall"});

      std::map<string, string> rhConns;
      rhConns.insert({"clk", "clk"});
      rhConns.insert({"rst", "rst"});

      rhConns.insert({"read_data", "rdata_0"});
      rhConns.insert({"read_addr", "raddr_0"});
      rhConns.insert({"start_read", "ren_0"});

      rhConns.insert({"s_axil_rready", "s_axil_rready"});
      rhConns.insert({"s_axil_arvalid", "s_axil_arvalid"});
      rhConns.insert({"s_axil_araddr", "s_axil_araddr"});
      rhConns.insert({"s_axil_arready", "s_axil_arready"});
      rhConns.insert({"s_axil_rvalid", "s_axil_rvalid"});
      rhConns.insert({"s_axil_rresp", "s_axil_rresp"});
      rhConns.insert({"s_axil_rready", "s_axil_rready"});
      rhConns.insert({"s_axil_rdata", "s_axil_rdata"});                    
      rhConns.insert({"valid", "read_valid"});
      ModuleInstance readHandler("axi_read_handler", "read_handler", rhConns);

      std::map<string, string> whConns;
      whConns.insert({"clk", "clk"});
      whConns.insert({"rst", "rst"});

      whConns.insert({"s_axil_awvalid", "s_axil_awvalid"});
      whConns.insert({"s_axil_wvalid", "s_axil_wvalid"});

      whConns.insert({"s_axil_wdata", "s_axil_wdata"});
      whConns.insert({"s_axil_awaddr", "s_axil_awaddr"});

      whConns.insert({"s_axil_bvalid", "s_axil_bvalid"});
      whConns.insert({"s_axil_bresp", "s_axil_bresp"});

      whConns.insert({"s_axil_wstrb", "s_axil_wstrb"});
      whConns.insert({"s_axil_bready", "s_axil_bready"});

      whConns.insert({"write_addr", "waddr_0"});
      whConns.insert({"write_data", "wdata_0"});      
      whConns.insert({"start_write", "wen_0"});
      whConns.insert({"ready", "write_ready"});
      whConns.insert({"valid", "write_valid"});

      ModuleInstance writeHandler("axi_write_handler", "write_handler", whConns);

      std::map<string, string> smConns;
      smConns.insert({"clk", "clk"});
      smConns.insert({"rst", "rst"});
      smConns.insert({"start_read", "ren_0"});
      smConns.insert({"start_write", "wen_0"});
      smConns.insert({"read_finished", "read_valid"});
      smConns.insert({"write_finished", "write_valid"});
      smConns.insert({"should_stall", "global_stall"});
      ModuleInstance stallManager("axi_stall_manager", "stall_manager", smConns);

      comps.instances.push_back(readHandler);
      comps.instances.push_back(writeHandler);
      comps.instances.push_back(stallManager);

      comps.debugWires.push_back({false, 1, "read_valid"});
      comps.debugWires.push_back({false, 1, "write_ready"});
      comps.debugWires.push_back({false, 1, "write_valid"});            
      comps.debugWires.push_back({false, 1, "ren_0"});
      comps.debugWires.push_back({false, 5, "raddr_0"});
      comps.debugWires.push_back({false, 5, "waddr_0"});
      comps.debugWires.push_back({false, 1, "wen_0"});      
      comps.debugWires.push_back({false, 32, "rdata_0"});
      comps.debugWires.push_back({false, 32, "wdata_0"});
      comps.debugWires.push_back({false, 1, "global_stall"});

    } else {
      assert(false);
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
  
  void emitVerilogTestBench(const TestBenchSpec& tb,
                            MicroArchitecture& arch,
                            const std::map<std::string, int>& layout) {
    string modName = tb.name + "_tb";
    ofstream out(modName + ".v");

    VerilogComponents comps;
    comps.debugWires.push_back({true, 1, "rst"});
    comps.debugWires.push_back({true, 1, "clk"});
    comps.debugWires.push_back({true, 1, "in_set_mem_phase"});
    comps.debugWires.push_back({true, 1, "in_run_phase"});
    comps.debugWires.push_back({true, 1, "in_check_mem_phase"});    

    comps.debugWires.push_back({true, 32, "clocks_in_set_mem_phase"});
    comps.debugWires.push_back({true, 32, "clocks_in_run_phase"});
    comps.debugWires.push_back({true, 32, "clocks_in_check_mem_phase"});    

    comps.debugWires.push_back({true, 32, "num_clocks_after_reset"});
    comps.debugWires.push_back({true, 32, "total_cycles"});
    comps.debugWires.push_back({true, 32, "max_cycles"});

    for (int i = 0; i < arch.numReadPorts(); i++) {
      comps.debugWires.push_back({false, 5, "raddr_" + to_string(i)});    
      comps.debugWires.push_back({false, 32, "rdata_" + to_string(i)});
    }

    comps.debugWires.push_back({true, 5, "dbg_wr_addr"});    
    comps.debugWires.push_back({true, 32, "dbg_wr_data"});
    comps.debugWires.push_back({true, 1, "dbg_wr_en"});

    comps.debugWires.push_back({true, 5, "dbg_addr"});    
    comps.debugWires.push_back({false, 32, "dbg_data"});
    
    comps.debugWires.push_back({false, 5, "waddr_0"});
    comps.debugWires.push_back({false, 32, "wdata_0"});        
    comps.debugWires.push_back({false, 1, "wen_0"});

    comps.debugWires.push_back({false, 1, "valid"});        


    comps.delayBlocks.push_back({3, "clk = !clk;"});

    addAlwaysBlock({"clk"}, "total_cycles <= total_cycles + 1;", comps);
    addAlwaysBlock({"clk"}, "if (total_cycles >= max_cycles) begin if (valid == 1 && in_check_mem_phase) begin $display(\"Passed\"); $finish(); end else begin $display(\"valid == %d. Ran out of cycles, finishing.\", valid); $finish(); end end", comps);

    addAlwaysBlock({"clk"}, "if (!in_set_mem_phase) begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", comps);

    addAlwaysBlock({"clk"}, "if (in_set_mem_phase) begin clocks_in_set_mem_phase <= clocks_in_set_mem_phase + 1; end ", comps);
    
    comps.initStmts.push_back("#1 clk = 0;");
    comps.initStmts.push_back("#1 rst = 1;");

    comps.initStmts.push_back("#1 in_set_mem_phase = 1;");
    comps.initStmts.push_back("#1 in_check_mem_phase = 0;");
    comps.initStmts.push_back("#1 in_run_phase = 0;");        

    comps.initStmts.push_back("#1 total_cycles = 0;");
    comps.initStmts.push_back("#1 max_cycles = " + to_string(tb.maxCycles) + ";");
    comps.initStmts.push_back("#1 num_clocks_after_reset = 0;");
    comps.initStmts.push_back("#1 clocks_in_set_mem_phase = 0;");
    comps.initStmts.push_back("#1 clocks_in_run_phase = 0;");        
    comps.initStmts.push_back("#1 clocks_in_check_mem_phase = 0;");

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
      memUpdate += "rdata" + iStr + "_reg <= data[raddr" + iStr + "];";
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
      
      ports.push_back(outputPort(width, "rdata" + iStr));
      ports.push_back(inputPort(addrWidth, "raddr" + iStr));
      ports.push_back(inputPort(1, "ren" + iStr));

      ramComps.debugAssigns.push_back({"rdata" + iStr, "rdata" + iStr + "_reg"});
    }

    ports.push_back(inputPort(width, "wdata"));
    ports.push_back(inputPort(addrWidth, "waddr"));
    ports.push_back(inputPort(1, "wen"));    

    ports.push_back(inputPort(addrWidth, "debug_addr"));
    ports.push_back(outputPort(width, "debug_data"));

    ports.push_back(inputPort(addrWidth, "debug_write_addr"));
    ports.push_back(inputPort(width, "debug_write_data"));
    ports.push_back(inputPort(1, "debug_write_en"));        

    ramComps.debugWires.push_back({false, addrWidth, "waddr_del"});
    ramComps.debugWires.push_back({false, width, "wdata_del"});    
    ramComps.debugWires.push_back({false, 1, "wen_del"});


    map<string, string> wenConns{{"clk", "clk"}, {"in", "wen"}, {"out", "wen_del"}};
    map<string, string> wenParams{{"WIDTH", "1"}};
    ramComps.instances.push_back({"delay", wenParams, "wen_delay", wenConns});

    map<string, string> wdataConns{{"clk", "clk"}, {"in", "wdata"}, {"out", "wdata_del"}};
    map<string, string> wdataParams{{"WIDTH", "32"}};
    ramComps.instances.push_back({"delay", wdataParams, "wdata_delay", wdataConns});

    map<string, string> waddrConns{{"clk", "clk"}, {"in", "waddr"}, {"out", "waddr_del"}};
    map<string, string> waddrParams{{"WIDTH", "5"}};
    ramComps.instances.push_back({"delay", waddrParams, "waddr_delay", waddrConns});
    
    emitModule(out, ramName, ports, ramComps);

    map<string, string> ramConnections{{"clk", "clk"}, {"rst", "rst"}, {"wen", "wen_0"}, {"waddr", "waddr_0"}, {"wdata", "wdata_0"}, {"debug_addr", "dbg_addr"}, {"debug_data", "dbg_data"}, {"debug_write_addr", "dbg_wr_addr"}, {"debug_write_data", "dbg_wr_data"}, {"debug_write_en", "dbg_wr_en"}};

    for (int i = 0; i < arch.numReadPorts(); i++) {
      auto iStr = to_string(i);
      ramConnections.insert({"raddr" + iStr, "raddr_" + to_string(i)});
      ramConnections.insert({"rdata" + iStr, "rdata_" + to_string(i)});
    }
    
    comps.instances.push_back({ramName, "ram", ramConnections});
    
    // TODO: Move this to be generic code passed in to this function
    ModuleInstance dut{tb.name, "dut", {{"clk", "clk"}, {"rst", "rst"}, {"valid", "valid"}, {"waddr_0", "waddr_0"}, {"wdata_0", "wdata_0"}, {"wen_0", "wen_0"}}};

    for (int i = 0; i < arch.numReadPorts(); i++) {
      auto iStr = to_string(i);
      dut.portConnections.insert({"raddr_" + iStr, "raddr_" + to_string(i)});    
      dut.portConnections.insert({"rdata_" + iStr, "rdata_" + to_string(i)});
    }

    comps.instances.push_back(dut);


    int cyclesInRun = tb.runCycles;

    addAlwaysBlock({"clk"}, "if (in_check_mem_phase) begin if (!valid) begin $display(\"Failed: Checking memory, but the module is not done running\"); $finish(); end end", comps);

    addAlwaysBlock({"clk"}, "if (clocks_in_run_phase == (" + to_string(cyclesInRun - 1) + ")) begin in_check_mem_phase <= 1; in_run_phase <= 0; end ", comps);

    addAlwaysBlock({"clk"}, "if (in_run_phase) begin clocks_in_run_phase <= clocks_in_run_phase + 1; end", comps);

    addAlwaysBlock({"clk"}, "if (in_check_mem_phase) begin clocks_in_check_mem_phase <= clocks_in_check_mem_phase + 1; end", comps);    

    int setNum = 0;
    for (auto memName : tb.memoryInit) {
      for (int i = 0; i < (int) memName.second.size(); i++) {
        // TODO: Add memory layout info
        addAlwaysBlock({"clk"}, "if (in_set_mem_phase && clocks_in_set_mem_phase == " + to_string(setNum) + ") begin dbg_wr_en <= 1; dbg_wr_addr <= " + to_string(map_find(memName.first, layout) + i) + "; dbg_wr_data <= " + to_string(memName.second[i]) + "; end", comps);

        setNum++;
        
      }
    }

    int cyclesInSetMem = setNum;
    addAlwaysBlock({"clk"}, "if (clocks_in_set_mem_phase == (" + to_string(cyclesInSetMem) + ")) begin in_run_phase <= 1; rst <= 0; dbg_wr_en <= 0; in_set_mem_phase <= 0; end", comps);

    addAlwaysBlock({"clk"}, "if (!in_set_mem_phase) begin dbg_wr_en <= 0; end", comps);
    
    int checkNum = 0;
    int lastNum = -1;
    
    for (auto memName : tb.memoryExpected) {
      for (int i = 0; i < (int) memName.second.size(); i++) {
        // TODO: Add memory layout info
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
    
    vector<string> portStrings;    
    out << "module " << modName << "(" + commaListString(portStrings) + ");" << endl;
    out << endl;


    emitComponents(out, comps);

    out << "endmodule" << endl;

    out.close();
    

  }

  void noStoredValuesXWhenUsed(const MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG.instruction;
        if (StoreInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string wireName = map_find(string("wdata"), unit.portWires).name;
          addAssert("global_state !== " + to_string(activeState) + " || " +
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
        auto instr = instrG.instruction;
        if (LoadInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string wireName = map_find(string("rdata"), unit.outWires).name;
          addAssert("global_state !== " + to_string(activeState) + " || " +
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
        auto instr = instrG.instruction;
        if (LoadInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string wireName = map_find(string("raddr"), unit.portWires).name;
          addAssert("global_state !== " + to_string(activeState) + " || " +
                    wireName + " !== 'dx",
                    debugInfo);
        }
      }
    }

  }
  
  std::string sanitizeFormatForVerilog(const std::string& str) {
    string san = "";
    for (auto c : str) {

      if (c == '"') {
        san += "\\\"";
      } else if (c == '%') {
        san += '$';
      } else {
        san += c;
      }
        
    }
    return san;
  }
  
  void printInstrAtState(Instruction* instr,
                         StateId st,
                         const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    auto iStr = sanitizeFormatForVerilog(instructionString(instr));
    FunctionalUnit unit = map_find(instr, arch.unitAssignment);
    auto unitOutput = unit.onlyOutputVar();
    
    addAlwaysBlock({"clk"}, "if(global_state == " + to_string(st) + ") begin $display(\"" + iStr + " == %d\", " + unitOutput + "); end", debugInfo);
  }
  
  void noPhiOutputsXWhenUsed(const MicroArchitecture& arch,
                             VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG.instruction;
        if (PHINode::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string iStr = instructionString(instr);
          printInstrAtState(instr, activeState, arch, debugInfo);
          
          string wireName = unit.onlyOutputVar();
          addAssert("global_state !== " + to_string(activeState) + " || " +
                    wireName + " !== 'dx",
                    debugInfo);
        }
      }
    }
  }

  void noAddsTakeXInputs(const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG.instruction;
        if (BinaryOperator::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == "add") {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);
          
            string in0Name = map_find(string("in0"), unit.portWires).name;
            string in1Name = map_find(string("in1"), unit.portWires).name;
            addAssert("global_state !== " + to_string(activeState) + " || " +
                      in0Name + " !== 'dx",
                      debugInfo);

            addAssert("global_state !== " + to_string(activeState) + " || " +
                      in1Name + " !== 'dx",
                      debugInfo);

          }
        }
      }
    }
  }

  void noMulsTakeXInputs(const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG.instruction;
        if (BinaryOperator::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == "mul") {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);
          
            string in0Name = map_find(string("in0"), unit.portWires).name;
            string in1Name = map_find(string("in1"), unit.portWires).name;
            addAssert("global_state !== " + to_string(activeState) + " || " +
                      in0Name + " !== 'dx",
                      debugInfo);

            addAssert("global_state !== " + to_string(activeState) + " || " +
                      in1Name + " !== 'dx",
                      debugInfo);

          }
        }
      }
    }
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

    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noLoadedValuesXWhenUsed(arch, info);
    noLoadAddressesXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);
  }
  
}
