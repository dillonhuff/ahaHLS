#include "verilog_backend.h"

#include "utils.h"

#include <fstream>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Instructions.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

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

  class Port {
  public:
    bool isInput;
    int width;
    std::string name;
    bool isDebug;

    std::string toString() {
      return string(isInput ? "input" : "output") + " [" + to_string(width - 1) + ":0] " + name;
    }
  };

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
  
  class FunctionalUnit {
  public:
    std::string modName;
    std::string instName;

    std::map<std::string, Wire> portWires;
    std::map<std::string, Wire> outWires;

    std::string onlyOutputVar() const {
      assert(outWires.size() == 1);

      return (*begin(outWires)).second.name;
    }
  };

  std::ostream& operator<<(std::ostream& out, const FunctionalUnit& unit) {
    out << unit.modName;
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

  class ElaboratedPipeline {
  public:
    Pipeline p;
    std::vector<Wire> valids;
    Wire inPipe;
    StateId stateId;

    std::vector<std::map<Instruction*, Wire> > pipelineRegisters;
    GuardedInstruction exitBranch;

    ElaboratedPipeline(const Pipeline& p_) : p(p_) {}

    llvm::Value* getExitCondition() const {
      Instruction* repeat = exitBranch.instruction;
      assert(BranchInst::classof(repeat));
      BranchInst* pipelineB = dyn_cast<BranchInst>(repeat);

      assert(pipelineB->isConditional());

      return pipelineB->getCondition();
    }

    int numStages() const {
      return p.getStates().size();
    }

    int stateIndex(const StateId id) const {
      for (int i = 0; i < p.getStates().size(); i++) {
        if (p.getStates().at(i) == id) {
          return i;
        }
      }

      return -1;
    }

    int stageForState(const StateId id) const {
      return stateIndex(id);
    }

  };

  class RAM {
    
  public:

    std::string name;
    int width;
    int depth;

    RAM(const std::string& name_,
        const int width_,
        const int depth_) : name(name_), width(width_), depth(depth_) {}
  };

  class MicroArchitecture {
  public:


    STG stg;
    map<Instruction*, FunctionalUnit> unitAssignment;
    map<string, int> memoryMap;
    map<Instruction*, Wire> names;
    map<BasicBlock*, int> basicBlockNos;
    std::vector<RAM> rams;

    MicroArchitecture(
                      const STG& stg_,
                      const map<Instruction*, FunctionalUnit>& unitAssignment_,
                      const map<string, int>& memoryMap_,
                      const map<Instruction*, Wire>& names_,
                      const map<BasicBlock*, int>& basicBlockNos_,
                      const std::vector<RAM>& rams_) :
      stg(stg_),
      unitAssignment(unitAssignment_),
      memoryMap(memoryMap_),
      names(names_),
      basicBlockNos(basicBlockNos_),
      rams(rams_) {}
  };
  
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

  std::vector<Port> getPorts(const STG& stg) {
    vector<Port> pts = {inputPort(1, "clk"), inputPort(1, "rst"), outputPort(1, "valid")};
    int numReadPorts = 0;
    int numWritePorts = 0;

    for (auto state : stg.opStates) {
      int numReadsInState = 0;
      int numWritesInState = 0;
      for (auto gInstr : state.second) {
        Instruction* i = gInstr.instruction;

        if (StoreInst::classof(i)) {
          numWritesInState++;
        }

        if (LoadInst::classof(i)) {
          numReadsInState++;
        }

      }

      if (numReadsInState > numReadPorts) {
        numReadPorts = numReadsInState;
      }

      if (numWritesInState > numWritePorts) {
        numWritePorts = numWritesInState;
      }
    }


    // TODO: Accomodate different width reads / writes
    int width = 32;    
    for (int i = 0; i < numReadPorts; i++) {
      pts.push_back(inputPort(width, "rdata_" + to_string(i)));
      pts.push_back(outputPort(clog2(width), "raddr_" + to_string(i)));
    }

    for (int i = 0; i < numWritePorts; i++) {
      pts.push_back(outputPort(width, "wdata_" + to_string(i)));
      pts.push_back(outputPort(clog2(width), "waddr_" + to_string(i)));
      pts.push_back(outputPort(1, "wen_" + to_string(i)));
    }

    return pts;
  }

  std::string getRAMName(Value* location,
                         std::map<llvm::Instruction*, std::string>& ramNames) {

    if (Instruction::classof(location)) {
      Instruction* locInstr = dyn_cast<Instruction>(location);

      if (!AllocaInst::classof(locInstr)) {
        if (!contains_key(locInstr, ramNames)) {
          return "";
        }

        string src = map_find(locInstr, ramNames);
        return src;
      } else {
        return locInstr->getName();
      }
      
    } else if (Argument::classof(location)) {

      string src = location->getName();

      return src;
    } else {
      return "";
    }

  }

  int numMemOps(const std::vector<GuardedInstruction>& instrs) {
    int ind = 0;
    for (auto instr : instrs) {
      if (StoreInst::classof(instr.instruction) ||
          LoadInst::classof(instr.instruction)) {
        ind++;
      }
    }
    return ind;
  }

  std::map<llvm::Instruction*, std::string>
  memoryOpLocations(const STG& stg) {
    map<Instruction*, string> mems;

    for (auto state : stg.opStates) {

      std::set<Instruction*> foundOps;
      while (foundOps.size() < numMemOps(stg.instructionsStartingAt(state.first))) {
        cout << "FoundInstrs =  "<< foundOps.size() << endl;

        for (auto instrG : stg.instructionsStartingAt(state.first)) {
          auto instr = instrG.instruction;

          if (elem(instr, foundOps)) {
            continue;
          }



          cout << "Getting source for " << instructionString(instr) << endl;
          if (LoadInst::classof(instr)) {
            Value* location = instr->getOperand(0);
            string name = getRAMName(location, mems);
            if (name != "") {
              mems[instr] = getRAMName(location, mems);
              foundOps.insert(instr);
            } else {
              cout << "No source for " << instructionString(instr) << endl;
            }
          } else if (StoreInst::classof(instr)) {
            Value* location = instr->getOperand(1);

            string name = getRAMName(location, mems);
            if (name != "") {
              mems[instr] = getRAMName(location, mems);
              foundOps.insert(instr);              
            } else {
              cout << "No source for " << instructionString(instr) << endl;
            }

          } else if (GetElementPtrInst::classof(instr)) {
            Value* location = instr->getOperand(0);
            string name = getRAMName(location, mems);
            if (name != "") {
              mems[instr] = getRAMName(location, mems);
              foundOps.insert(instr);                            
            } else {
              cout << "No source for " << instructionString(instr) << endl;
            }
          }
        }
      }
    }

    return mems;
  }

  std::map<Instruction*, FunctionalUnit>
  assignFunctionalUnits(const STG& stg,
                        std::map<std::string, int>& memoryMap) {

    std::map<Instruction*, FunctionalUnit> units;

    int readNum = 0;
    int writeNum = 0;

    auto memSrcs = memoryOpLocations(stg);

    cout << "-- Memory sources" << endl;
    for (auto src : memSrcs) {
      cout << tab(1) << instructionString(src.first) << " -> " << src.second << endl;
    }

    // For now create a different unit for every single operation
    int resSuffix = 0;
    for (auto state : stg.opStates) {

      // For now create a different unit for every single operation
      //int resSuffix = 0;

      for (auto instrG : stg.instructionsStartingAt(state.first)) {

        Instruction* instr = instrG.instruction;
        auto rStr = to_string(resSuffix);

        // For loads and stores the name of the assigned functional unit
        // needs to be determined by looking at the argument to the load
        // or store and checking if it is an argument to the function
        // or an internally declared RAM
        string unitName = string(instr->getOpcodeName()) + "_" +
          to_string(resSuffix);

        if (LoadInst::classof(instr) || StoreInst::classof(instr)) {
          assert(contains_key(instr, memSrcs));

          string memSrc = map_find(instr, memSrcs);

          // If we are loading from an internal RAM, not an argument
          if (!contains_key(memSrc, memoryMap)) {
            cout << "Using unit " << memSrc << " for " << instructionString(instr) << endl;
            unitName = memSrc;

            // Now also need to set wiring and outwires
          }
        }
        string modName = "add";

        //map<string, string> wiring;
        map<string, Wire> wiring;
        map<string, Wire> outWires;
          
        if (StoreInst::classof(instr)) {

          string memSrc = map_find(instr, memSrcs);
          if (!contains_key(memSrc, memoryMap)) {
            cout << "Using unit " << memSrc << " for " << instructionString(instr) << endl;
            modName = "RAM";
            unitName = memSrc;
            // These names need to match names created in the portlist. So
            // maybe this should be used to create the port list? Generate the
            // names here and then write ports for them?
            wiring = {{"wen", {true, 1, "wen_" + unitName + "_reg"}},
                      {"waddr", {true, 32, "waddr_" + unitName + "_reg"}},
                      {"wdata", {true, 32, "wdata_" + unitName + "_reg"}},
                      {"raddr", {true, 32, "raddr_" + unitName + "_reg"}}};
            outWires = {{"rdata", {false, 32, "rdata_" + unitName}}};

          } else {
            modName = "store";
            
            // These names need to match names created in the portlist. So
            // maybe this should be used to create the port list? Generate the
            // names here and then write ports for them?
            wiring = {{"wen", {true, 1, "wen_0_reg"}}, {"waddr", {true, 32, "waddr_0_reg"}}, {"wdata", {true, 32, "wdata_0_reg"}}};
            outWires = {{"rdata", {false, 32, "rdata_" + unitName}}};
            
            writeNum++;
          }

        } else if (LoadInst::classof(instr)) {
          string memSrc = map_find(instr, memSrcs);

          // If we are loading from an internal RAM, not an argument
          if (!contains_key(memSrc, memoryMap)) {
            cout << "Using unit " << memSrc << " for " << instructionString(instr) << endl;
            modName = "RAM";
            unitName = memSrc;

            wiring = {{"raddr", {true, 32, "raddr_" + unitName + "_reg"}}, {"wen", {true, 1, "wen_" + unitName + "_reg"}}, {"waddr", {true, 32, "waddr_" + unitName + "_reg"}}, {"wdata", {true, 32, "wdata_" + unitName + "_reg"}}};
            outWires = {{"rdata", {false, 32, "rdata_" + unitName}}};
            
          } else {

            modName = "load";

            wiring = {{"raddr", {true, 32, "raddr_" + to_string(readNum) + "_reg"}}};
            outWires = {{"rdata", {false, 32, "rdata_" + to_string(readNum)}}};

            readNum++;
          }

        } else if (BinaryOperator::classof(instr)) {
          assert(instr->getOpcode() == Instruction::Add);
          modName = "add";
          wiring = {{"in0", {true, 32, "add_in0_" + rStr}},
                    {"in1", {true, 32, "add_in1_" + rStr}}};
          outWires = {{"out", {false, 32, "add_out_" + rStr}}};
        } else if (ReturnInst::classof(instr)) {
          modName = "ret";

          wiring = {{"valid", {true, 1, "valid_reg"}}};
          outWires = {};
          
        } else if (CmpInst::classof(instr)) {
          CmpInst::Predicate pred = dyn_cast<CmpInst>(instr)->getPredicate();
          if (pred == CmpInst::ICMP_EQ) {
            modName = "eq";
            wiring = {{"in0", {true, 32, "eq_in0_" + rStr}}, {"in1", {true, 32, "eq_in1_" + rStr}}};
            outWires = {{"out", {false, 1, "eq_out_" + rStr}}};
          } else if (pred == CmpInst::ICMP_SGT) {
            modName = "sgt";
            wiring = {{"in0", {true, 32, "sgt_in0_" + rStr}}, {"in1", {true, 32, "sgt_in1_" + rStr}}};
            outWires = {{"out", {false, 1, "sgt_out_" + rStr}}};
          } else {
            cout << "Error: Unsupported predicate in cmp: " << pred << endl;
            assert(false);
          }
        } else if (BranchInst::classof(instr)) {
          modName = "br_dummy";
          // Branches are not scheduled, they are encoded in the
          // STG transitions
        } else if (GetElementPtrInst::classof(instr)) {
          modName = "getelementptr_" + to_string(instr->getNumOperands() - 1);
          wiring = {{"base_addr", {true, 32, "base_addr_" + to_string(resSuffix)}}};

          for (int i = 1; i < instr->getNumOperands(); i++) {
            wiring.insert({"in" + to_string(i),
                  {true, 32, "add_in" + to_string(i) + "_" + to_string(resSuffix)}});
          }
          outWires = {{"out", {false, 32, "getelementptr_out_" + rStr}}};
        } else if (PHINode::classof(instr)) {
          PHINode* phi = dyn_cast<PHINode>(instr);
          assert(phi->getNumIncomingValues() == 2);

          modName = "phi_2";
          wiring = {{"s0", {true, 32, "phi_s0_" + rStr}},
                    {"s1", {true, 32, "phi_s1_" + rStr}},
                    {"in0", {true, 32, "phi_in0_" + rStr}},
                    {"in1", {true, 32, "phi_in1_" + rStr}},
                    {"last_block", {true, 32, "phi_last_block_" + rStr}}};
          outWires = {{"out", {false, 32, "phi_out_" + rStr}}};

        } else if (ZExtInst::classof(instr)) {

          cout << "Error: zext not yet supported" << endl;
          assert(false);

        } else if (SelectInst::classof(instr)) {
          modName = "select";
          wiring = {{"in0", {true, 32, "sel_in0_" + rStr}},
                    {"in1", {true, 32, "sel_in1_" + rStr}},
                    {"sel", {true, 32, "sel_sel_" + rStr}}};
          outWires = {{"out", {false, 32, "sel_out_" + rStr}}};
            
        } else if (AllocaInst::classof(instr)) {
          // Create a memory module?

        } else if (BitCastInst::classof(instr) ||
                   CallInst::classof(instr)) {
          // No action for these instruction types
        } else {
          cout << "Unsupported instruction = " << instructionString(instr) << endl;
          assert(false);
        }

        units[instr] = {modName, unitName, wiring, outWires};

        resSuffix++;
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
        cout << "Getting type of " << instructionString(instr) << endl;
        
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
                         std::map<std::string, int>& memoryMap) {
    if (Instruction::classof(arg0)) {

      auto unit0Src =
        map_find(dyn_cast<Instruction>(arg0), unitAssignment);
      assert(unit0Src.outWires.size() == 1);

      string arg0Name = unit0Src.onlyOutputVar();

      return arg0Name;
    } else if (Argument::classof(arg0)) {
      string name = arg0->getName();
      return to_string(map_find(name, memoryMap));
    } else {
      assert(ConstantInt::classof(arg0));
      auto arg0C = dyn_cast<ConstantInt>(arg0);
      auto apInt = arg0C->getValue();

      assert(!apInt.isNegative());

      return to_string(dyn_cast<ConstantInt>(arg0)->getSExtValue());
    }
  }

  std::string outputName(Value* arg0,
                         Instruction* instr,
                         const STG& stg,
                         map<Instruction*, FunctionalUnit>& unitAssignment,
                         map<Instruction*, Wire>& names,                         
                         std::map<std::string, int>& memoryMap) {
    if (Instruction::classof(arg0)) {

      auto instr0 = dyn_cast<Instruction>(arg0);
      StateId argState = map_find(instr0, stg.sched.instrTimes).back();
      StateId thisState = map_find(instr, stg.sched.instrTimes).front();

      if (argState == thisState) {

        auto unit0Src =
          map_find(instr0, unitAssignment);
        assert(unit0Src.outWires.size() == 1);
        string arg0Name = unit0Src.onlyOutputVar();
        return arg0Name;
        
      } else {

        Wire tmpRes = map_find(instr0, names);
        return tmpRes.name;

      }


    } else if (Argument::classof(arg0)) {
      string name = arg0->getName();
      return to_string(map_find(name, memoryMap));
    } else {
      assert(ConstantInt::classof(arg0));
      auto arg0C = dyn_cast<ConstantInt>(arg0);
      auto apInt = arg0C->getValue();

      assert(!apInt.isNegative());

      return to_string(dyn_cast<ConstantInt>(arg0)->getSExtValue());
    }
  }

  std::string outputName(Value* arg0,
                         Instruction* instr,
                         const STG& stg,
                         map<Instruction*, FunctionalUnit>& unitAssignment,
                         map<Instruction*, Wire>& names,                         
                         std::map<std::string, int>& memoryMap,
                         const std::vector<RAM>& rams) {
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

        auto unit0Src =
          map_find(instr0, unitAssignment);
        assert(unit0Src.outWires.size() == 1);
        string arg0Name = unit0Src.onlyOutputVar();
        return arg0Name;
        
      } else {

        Wire tmpRes = map_find(instr0, names);
        return tmpRes.name;

      }


    } else if (Argument::classof(arg0)) {
      string name = arg0->getName();
      return to_string(map_find(name, memoryMap));
    } else {
      assert(ConstantInt::classof(arg0));
      auto arg0C = dyn_cast<ConstantInt>(arg0);
      auto apInt = arg0C->getValue();

      assert(!apInt.isNegative());

      return to_string(dyn_cast<ConstantInt>(arg0)->getSExtValue());
    }
  }
  
  std::string outputNameLast(Value* arg0,
                             map<Instruction*, FunctionalUnit> unitAssignment,
                             map<Instruction*, Wire>& names,
                             std::map<std::string, int>& memoryMap) {
    if (Instruction::classof(arg0)) {

      auto resWire =
        map_find(dyn_cast<Instruction>(arg0), names);
      return resWire.name;

    } else if (Argument::classof(arg0)) {
      string name = arg0->getName();
      return to_string(map_find(name, memoryMap));
    } else {
      assert(ConstantInt::classof(arg0));
      auto arg0C = dyn_cast<ConstantInt>(arg0);
      auto apInt = arg0C->getValue();

      assert(!apInt.isNegative());

      return to_string(dyn_cast<ConstantInt>(arg0)->getSExtValue());
    }
  }
  
  std::string verilogForCondition(Condition& cond,
                                  const StateId currentState,
                                  const STG& stg,
                                  const map<Instruction*, FunctionalUnit>& unitAssignment,
                                  const map<Instruction*, Wire>& names) {
    string condStr = "";

    if (cond.isTrue()) {
      return "1";
    }

    int clNum = 0;
    for (auto cl : cond.clauses) {

      int aNum = 0;
      for (auto a : cl) {
        bool isNeg = a.negated;
        assert(Instruction::classof(a.cond));
        Instruction* iValue = dyn_cast<Instruction>(a.cond);
        StateId atomCompletionTime = map_find(iValue, stg.sched.instrTimes).back();

        if (isNeg) {
          condStr += "!";
        }

        condStr += "(";
        if (atomCompletionTime == currentState) {
          condStr += map_find(iValue, unitAssignment).onlyOutputVar();
        } else {
          condStr += map_find(iValue, names).name;
        }
        condStr += ")";

        if (aNum < cl.size() - 1) {
          condStr += " && ";
        }
        
        aNum++;
      }

      if (clNum < cond.clauses.size() - 1) {
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

    cout << "Instruction verilog for " << instructionString(instr) << endl;
    
    if (ReturnInst::classof(instr)) {
      out << "\t\t\tvalid_reg = 1;" << endl;
    } else if (StoreInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto wdataName = outputName(arg0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);            
      Value* location = instr->getOperand(1);
      auto locValue = outputName(location, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);      
            
      out << "\t\t\t" << addUnit.portWires["waddr"].name << " = " << locValue << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["wdata"].name << " = " << wdataName << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["wen"].name << " = 1;" << endl;

    } else if (LoadInst::classof(instr)) {

      Value* location = instr->getOperand(0);
      auto locValue = outputName(location, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);

      out << "\t\t\t" << addUnit.portWires["raddr"].name << " = " << locValue << ";" << endl;
    } else if (BinaryOperator::classof(instr) ||
               CmpInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputName(arg0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);

      auto arg1 = instr->getOperand(1);
      auto arg1Name = outputName(arg1, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);

      out << "\t\t\t" << addUnit.portWires["in0"].name << " = " << arg0Name << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"].name << " = " << arg1Name << ";" << endl;
            
    } else if(GetElementPtrInst::classof(instr)) {

      auto numOperands = instr->getNumOperands();

      assert((numOperands == 2) || (numOperands == 3));

      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputName(arg0, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap, arch.rams);

      out << tab(3) << addUnit.portWires["base_addr"].name << " = " << arg0Name << ";" << endl;

      for (int i = 1; i < numOperands; i++) {
        auto arg1 = instr->getOperand(i);
        auto arg1Name =
          outputName(arg1, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);

        out << "\t\t\t" << addUnit.portWires["in" + to_string(i)].name << " = " << arg1Name << ";" << endl;
      }

    } else if (BranchInst::classof(instr)) {
      out << "\t\t\t\t" << "last_BB = " << map_find(instr->getParent(), arch.basicBlockNos) << ";" << endl;
            
    } else if (PHINode::classof(instr)) {
      PHINode* phi = dyn_cast<PHINode>(instr);
      assert(phi->getNumIncomingValues() == 2);

      BasicBlock* b0 = phi->getIncomingBlock(0);
      int b0Val = map_find(b0, arch.basicBlockNos);

      BasicBlock* b1 = phi->getIncomingBlock(1);
      int b1Val = map_find(b1, arch.basicBlockNos);

      Value* v0 = phi->getIncomingValue(0);
      string val0Name = outputNameLast(v0, arch.unitAssignment, arch.names, arch.memoryMap);

      Value* v1 = phi->getIncomingValue(1);
      string val1Name = outputNameLast(v1, arch.unitAssignment, arch.names, arch.memoryMap);
            
      out << "\t\t\t" << addUnit.portWires["in0"].name << " = " << val0Name << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"].name << " = " << val1Name << ";" << endl;

      out << "\t\t\t" << addUnit.portWires["s0"].name << " = " << b0Val << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["s1"].name << " = " << b1Val << ";" << endl;

      out << "\t\t\t" << addUnit.portWires["last_block"].name << " = last_BB_reg;" << endl;
    } else if (SelectInst::classof(instr)) {
      SelectInst* sel = dyn_cast<SelectInst>(instr);

      Value* cond = sel->getCondition();
      string condName = outputName(cond, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);

      Value* trueVal = sel->getTrueValue();
      string trueName = outputName(trueVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);

      Value* falseVal = sel->getFalseValue();
      string falseName = outputName(falseVal, instr, arch.stg, arch.unitAssignment, arch.names, arch.memoryMap);
      
      out << "\t\t\t" << addUnit.portWires["in0"].name << " = " << falseName << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"].name << " = " << trueName << ";" << endl;

      out << "\t\t\t" << addUnit.portWires["sel"].name << " = " << condName << ";" << endl;

    } else if (AllocaInst::classof(instr) ||
               CallInst::classof(instr) ||
               BitCastInst::classof(instr)) {
      // No-ops
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

        cout << "Getting output " << instructionString(instr) << endl;

        string instrName = map_find(instr, names).name;
        auto unit = map_find(instr, unitAssignment);

        out << "\t\t\t\tif (" << verilogForCondition(instrG.cond, state, stg, unitAssignment, names) << ") begin" << endl;

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
                       const STG& stg,
                       map<Instruction*, FunctionalUnit>& unitAssignment,
                       map<Instruction*, Wire>& names,
                       const std::vector<ElaboratedPipeline>& pipelines) {
    for (auto state : stg.opTransitions) {

      emitPipelineStateCode(out, state.first, state.second, stg, unitAssignment, names, pipelines);

    }


    out << "\t\tend" << endl;

  }  

  void emitPipelineInstructionCode(std::ostream& out,
                                   const std::vector<ElaboratedPipeline>& pipelines,
                                   const STG& stg,
                                   map<Instruction*, FunctionalUnit>& unitAssignment,
                                   map<string, int>& memoryMap,
                                   map<Instruction*, Wire>& names,
                                   map<BasicBlock*, int>& basicBlockNos) {

    vector<RAM> rams;
    // TODO: Add loop over instructions searching for alloca instructions.
    // Then I will need to add RAM assignments to the appropriate
    // load and store operations (via adding them to the functional
    // unit assignment?)
    MicroArchitecture arch(stg, unitAssignment, memoryMap, names, basicBlockNos, rams);

    out << "\t// Start pipeline instruction code" << endl;

    out << "\t// Start pipeline stages" << endl;
    for (auto p : pipelines) {
      for (int i = 0; i < p.valids.size(); i++) {
        Wire valid = p.valids[i];
        StateId state = p.p.getStates().at(i);

        if (i == 0) {
          out << "\talways @(*) begin" << endl;
          out << "\t\tif (" << p.inPipe.name << " && " << valid.name << ") begin" << endl;

          auto instrG = p.exitBranch;
          Instruction* instr = instrG.instruction;

          out << "\t\t\tif (" << verilogForCondition(instrG.cond, state, stg, unitAssignment, names) << ") begin" << endl;

          instructionVerilog(out, instr, arch); //stg, unitAssignment, memoryMap, names, basicBlockNos);

          out << "\t\t\tend" << endl;
          out << "\t\tend" << endl;
          out << "\tend" << endl;
        }

        // Omit branch code on last stage
        for (auto instrG : stg.instructionsStartingAt(state)) {
          out << "\talways @(*) begin" << endl;
          out << "\t\tif (" << p.inPipe.name << " && " << valid.name << ") begin" << endl;

          Instruction* instr = instrG.instruction;

          out << "\t\t\tif (" << verilogForCondition(instrG.cond, state, stg, unitAssignment, names) << ") begin" << endl;

          
          instructionVerilog(out, instr, arch); //, stg, unitAssignment, memoryMap, names, basicBlockNos);

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
              map_insert(u.instructions, state.first, instrG); //[state.first] = instrG;
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

      out << "\talways @(*) begin" << endl;        

      int i = 0;
      int numInstrs = 0;
      for (auto stInstrG : controller.instructions) {
        StateId state = stInstrG.first;
        //auto instrsAtState = stInstrG.second;
        //GuardedInstruction instrG = stInstrG.second;

        if (!isPipelineState(state, pipelines)) {
          numInstrs++;
        }
      }

      for (auto stInstrG : controller.instructions) {
        StateId state = stInstrG.first;
        //GuardedInstruction instrG = stInstrG.second;
        auto instrsAtState = stInstrG.second;

        if (!isPipelineState(state, pipelines)) {


          out << "\t\tif (global_state == " + to_string(state) + ") begin" << endl;

          for (auto instrG : instrsAtState) {
            Instruction* instr = instrG.instruction;

            out << "\t\t\tif (" << verilogForCondition(instrG.cond, state, arch.stg, arch.unitAssignment, arch.names) << ") begin" << endl;

            instructionVerilog(out, instr, arch);

            out << "\t\t\tend else begin " << endl;
            out << "\t\t\t// Default values" << endl;
            for (auto w : unit.portWires) {
              out << tab(4) << w.second.name << " = 0;" << endl;
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
      if ((unit.modName == "load") ||
          (unit.modName == "store") ||
          (unit.modName == "ret")) {
        continue;
      }

      vector<string> wireDecls;
      for (auto w : unit.portWires) {
        out << "\t" << w.second << ";" << endl;
        wireDecls.push_back("." + w.first + "(" + w.second.name + ")");
      }

      if (unit.modName == "RAM") {
        wireDecls.push_back(".clk(clk)");
        wireDecls.push_back(".rst(rst)");        
      }

      for (auto w : unit.outWires) {
        out << "\twire [" << w.second.width - 1 << ":0] " << w.second.name << ";" << endl;
        wireDecls.push_back("." + w.first + "(" + w.second.name + ")");
      }
      
      out << "\t" << unit.modName << " " << unit.instName << "(" << commaListString(wireDecls) << ");" << endl << endl;
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
                              map<Instruction*, FunctionalUnit>& unitAssignment,
                              const std::vector<ElaboratedPipeline>& pipelines) {
    out << "\t// Start pipeline initiation block" << endl;
    out << "\talways @(posedge clk) begin" << endl;

    for (auto p : pipelines) {
      out << "\t\t\t\tif (" << p.valids.at(0).name << " && " << p.inPipe.name << ") begin" << endl;
      std::map<std::string, int> memMap;
      out << "\t\t\t\t\tif(" << outputName(p.getExitCondition(), unitAssignment, memMap) << ") begin" << endl;
      out << "\t\t\t\t\t\t" << p.valids.at(0).name << " <= 0;" << endl;
      out << "\t\t\t\t\tend else begin" << endl;
      out << "\t\t\t\t\t\t" << p.valids.at(0).name << " <= 1;" << endl;
      out << "\t\t\t\t\tend" << endl;
      out << "\t\t\t\tend" << endl;

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
      for (int i = 0; i < p.valids.size(); i++) {
        out << "\t\t$display(\"" << p.valids[i].name << " = %d\", " << p.valids[i].name << ");" << endl;
      }
    }

    out << endl;

    out << "\t\tif (!rst) begin" << endl;
    for (auto p : pipelines) {

      //      for (auto validVar : p.valids) {
      for (int i = 0; i < p.valids.size() - 1; i++) {
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
    }

    return pipelines;
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
                   std::map<std::string, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo) {

    map<BasicBlock*, int> basicBlockNos = numberBasicBlocks(f);
    map<Instruction*, Wire> names = createInstrNames(stg);
    vector<ElaboratedPipeline> pipelines =
      buildPipelines(f, stg);
    map<Instruction*, FunctionalUnit> unitAssignment =
      assignFunctionalUnits(stg, memoryMap);

    // TODO: Add rams
    vector<RAM> rams;

    MicroArchitecture arch(stg, unitAssignment, memoryMap, names, basicBlockNos, rams);
    string fn = f->getName();
    vector<Port> allPorts = getPorts(stg);
    for (auto w : debugInfo.wiresToWatch) {
      allPorts.push_back(outputDebugPort(w.width, w.name));
    }

    vector<string> portStrings;
    for (auto pt : allPorts) {
      portStrings.push_back(pt.toString());
    }

    ofstream out(fn + ".v");
    out << "module " << fn << "(" + commaListString(portStrings) + ");" << endl;

    out << endl;

    emitPorts(out, allPorts);

    out << endl << tab(1) << "// Start debug wires and ports" << endl;
    for (auto w : debugInfo.debugWires) {
      out << tab(1) << w << ";" << endl;
    }

    for (auto asg : debugInfo.debugAssigns) {
      out << tab(1) << "assign " << asg.first << " = " << asg.second << ";" << endl;
    }

    for (auto blk : debugInfo.blocks) {
      print(out, 1, blk);
    }
    out << tab(1) << "// End debug wires and ports" << endl;
    
    emitFunctionalUnits(out, unitAssignment);
    emitRegisterStorage(out, names);

    emitPipelineVariables(out, pipelines);
    emitGlobalStateVariables(out);

    emitPipelineResetBlock(out, pipelines);
    emitPipelineValidChainBlock(out, pipelines);
    emitPipelineInitiationBlock(out, unitAssignment, pipelines);

    out << endl;
    for (auto p : pipelines) {
      out << "\tassign " << p.inPipe.name << " = global_state == " << p.stateId << ";"<< endl;
    }

    out << "\talways @(posedge clk) begin" << endl;

    out << "\t\t$display(\"global_state = %d\", global_state);" << endl;

    // Insert state transition logic
    out << "\t\tif (rst) begin" << endl;

    // TODO: Change this from 0 to the global state that contains the entry block
    out << "\t\t\tglobal_state <= 0;" << endl;

    out << "\t\t\tlast_BB_reg <= " << map_find(&(f->getEntryBlock()), basicBlockNos) << ";" << endl;

    out << "\t\tend else begin" << endl;

    out << "\t\t\tlast_BB_reg <= last_BB;" << endl;
      

    emitControlCode(out, stg, unitAssignment, names, pipelines);

    out << "\tend" << endl;
    out << endl << endl;

    emitPipelineInstructionCode(out, pipelines, stg, unitAssignment, memoryMap, names, basicBlockNos);
    emitInstructionCode(out, arch, pipelines);

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

}
