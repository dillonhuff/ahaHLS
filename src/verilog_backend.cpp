#include "verilog_backend.h"

#include "utils.h"

#include <fstream>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Instructions.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

// Convolution as Toeplitz Matrix multiplication
namespace DHLS {

  class Wire {
  public:
    bool registered;
    int width;
    std::string name;

    Wire() {}
    Wire(const int width_, const std::string& name_) : 
      registered(false), width(width_), name(name_) {}

    Wire(const bool registered_, const int width_, const std::string& name_) : 
      registered(registered_), width(width_), name(name_) {}

    std::string toString() const {
      return string(registered ? "reg" : "wire") + " [" + to_string(width - 1) + ":0] " + name;
    }
  };

  std::ostream& operator<<(std::ostream& out, const Wire w) {
    out << w.toString();
    return out;
  }

  class Port {
  public:
    bool isInput;
    int width;
    std::string name;

    std::string toString() {
      return string(isInput ? "input" : "output") + " [" + to_string(width - 1) + ":0] " + name;
    }
  };

  std::string declareReg(const std::string name, const int width) {
    return "reg [" + to_string(width - 1) + ":0] " + name;
  }

  Port inputPort(const int width, const std::string& name) {
    return {true, width, name};
  }

  Port outputPort(const int width, const std::string& name) {
    return {false, width, name};
  }
  
  class FunctionalUnit {
  public:
    std::string modName;
    std::string instName;
    std::map<std::string, std::string> portWires;
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
      portStrs.push_back("." + pt.first + "(" + pt.second + ")");
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

    ElaboratedPipeline(const Pipeline& p_) : p(p_) {}

    int stateIndex(const StateId id) {
      for (int i = 0; i < p.getStates().size(); i++) {
        if (p.getStates().at(i) == id) {
          return i;
        }
      }

      return -1;
    }
  };

  bool hasOutput(Instruction* instr) {
    if (StoreInst::classof(instr) ||
        ReturnInst::classof(instr) ||
        BranchInst::classof(instr)) {
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

  std::map<Instruction*, FunctionalUnit> assignFunctionalUnits(const STG& stg) {
    std::map<Instruction*, FunctionalUnit> units;

    int readNum = 0;
    int writeNum = 0;

    // For now create a different unit for every single operation
    int resSuffix = 0;
    for (auto state : stg.opStates) {
      for (auto instrG : state.second) {
        Instruction* instr = instrG.instruction;

        auto schedVars = map_find(instr, stg.sched.instrTimes);
        auto rStr = to_string(resSuffix);

        if (state.first == schedVars.front()) {
          string unitName = string(instr->getOpcodeName()) + "_" +
            to_string(resSuffix);

          string modName = "add";

          map<string, string> wiring;
          map<string, Wire> outWires;
          
          if (StoreInst::classof(instr)) {
            modName = "store";

            // These names need to match names created in the portlist. So
            // maybe this should be used to create the port list? Generate the
            // names here and then write ports for them?
            wiring = {{"wen", "wen_0_reg"}, {"waddr", "waddr_0_reg"}, {"wdata", "wdata_0_reg"}};

            writeNum++;

          } else if (LoadInst::classof(instr)) {
            modName = "load";

            wiring = {{"raddr", "raddr_" + to_string(readNum) + "_reg"}};
            outWires = {{"out", {false, 32, "rdata_" + to_string(readNum)}}};

            readNum++;

          } else if (BinaryOperator::classof(instr)) {
            assert(instr->getOpcode() == Instruction::Add);
            modName = "add";
            wiring = {{"in0", "add_in0_" + rStr}, {"in1", "add_in1_" + rStr}};
            outWires = {{"out", {false, 32, "add_out_" + rStr}}};
          } else if (ReturnInst::classof(instr)) {
            modName = "ret";
          } else if (CmpInst::classof(instr)) {
            CmpInst::Predicate pred = dyn_cast<CmpInst>(instr)->getPredicate();
            if (pred == CmpInst::ICMP_EQ) {
              modName = "eq";
              wiring = {{"in0", "eq_in0_" + rStr}, {"in1", "eq_in1_" + rStr}};
              outWires = {{"out", {false, 1, "eq_out_" + rStr}}};
            } else if (pred == CmpInst::ICMP_SGT) {
              modName = "sgt";
              wiring = {{"in0", "sgt_in0_" + rStr}, {"in1", "sgt_in1_" + rStr}};
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
            modName = "add";
            wiring = {{"in0", "add_in0_" + to_string(resSuffix)}, {"in1", "add_in1_" + to_string(resSuffix)}};
            outWires = {{"out", {false, 32, "add_out_" + rStr}}};
          } else if (PHINode::classof(instr)) {
            PHINode* phi = dyn_cast<PHINode>(instr);
            assert(phi->getNumIncomingValues() == 2);

            modName = "phi_2";
            wiring = {{"s0", "phi_s0_" + rStr}, {"s1", "phi_s1_" + rStr}, {"in0", "phi_in0_" + rStr}, {"in1", "phi_in1_" + rStr}, {"last_block", "phi_last_block_" + rStr}};
            outWires = {{"out", {false, 32, "phi_out_" + rStr}}};

          } else if (ZExtInst::classof(instr)) {

            cout << "Error: zext not yet supported" << endl;
            assert(false);

          } else if (SelectInst::classof(instr)) {
            modName = "select";
            wiring = {{"in0", "sel_in0_" + rStr}, {"in1", "sel_in1_" + rStr}, {"sel", "sel_sel_" + rStr}};
            outWires = {{"out", {false, 32, "sel_out_" + rStr}}};
            
          } else {
            cout << "Unsupported instruction = " << instructionString(instr) << endl;
            assert(false);
          }

          units[instr] = {modName, unitName, wiring, outWires};

          resSuffix++;
        }
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

        if (StoreInst::classof(instr) || ReturnInst::classof(instr) || BranchInst::classof(instr)) {
          continue;
        }

        auto schedVars = map_find(instr, stg.sched.instrTimes);
        auto* tp = instr->getType();

        cout << "type = " << typeString(tp) << endl;
        int width;
        if (IntegerType::classof(tp)) {
          IntegerType* iTp = dyn_cast<IntegerType>(tp);
          width = iTp->getBitWidth();
        } else {
          assert(PointerType::classof(tp));
          PointerType* pTp = dyn_cast<PointerType>(tp);

          assert(IntegerType::classof(pTp->getElementType()));

          IntegerType* iTp = dyn_cast<IntegerType>(pTp->getElementType());
          width = iTp->getBitWidth();

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
                          map<Instruction*, FunctionalUnit>& unitAssignment,
                          map<string, int>& memoryMap,
                          map<Instruction*, Wire>& names,
                          map<BasicBlock*, int>& basicBlockNos) {

    auto addUnit = map_find(instr, unitAssignment);

    if (ReturnInst::classof(instr)) {
      //out << "\t\t\tvalid_reg = 1;" << endl;
    } else if (StoreInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      string wdataName = outputName(arg0, unitAssignment, memoryMap);

      Value* location = instr->getOperand(1);            
      auto locValue = outputName(location, unitAssignment, memoryMap);
            
      out << "\t\t\t" << addUnit.portWires["waddr"] << " = " << locValue << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["wdata"] << " = " << wdataName << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["wen"] << " = 1;" << endl;

    } else if (LoadInst::classof(instr)) {

      Value* location = instr->getOperand(0);            
      auto locValue = outputName(location, unitAssignment, memoryMap);

      out << "\t\t\t" << addUnit.portWires["raddr"] << " = " << locValue << ";" << endl;
    } else if (CmpInst::classof(instr)) {


      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputName(arg0, unitAssignment, memoryMap);

      auto arg1 = instr->getOperand(1);
      auto arg1Name = outputName(arg1, unitAssignment, memoryMap);     
      out << "\t\t\t" << addUnit.portWires["in0"] << " = " << arg0Name << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"] << " = " << arg1Name << ";" << endl;

    } else if (BinaryOperator::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputName(arg0, unitAssignment, memoryMap);

      auto arg1 = instr->getOperand(1);
      auto arg1Name = outputName(arg1, unitAssignment, memoryMap);
      out << "\t\t\t" << addUnit.portWires["in0"] << " = " << arg0Name << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"] << " = " << arg1Name << ";" << endl;
            
    } else if (BranchInst::classof(instr)) {
      out << "\t\t\t\t" << "last_BB = " << map_find(instr->getParent(), basicBlockNos) << ";" << endl;;
      // Branch instructions dont map to functional units
    } else if (GetElementPtrInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputName(arg0, unitAssignment, memoryMap);

      auto arg1 = instr->getOperand(1);
      auto arg1Name = outputName(arg1, unitAssignment, memoryMap);
      out << "\t\t\t" << addUnit.portWires["in0"] << " = " << arg0Name << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"] << " = " << arg1Name << ";" << endl;
            
    } else if (PHINode::classof(instr)) {
      PHINode* phi = dyn_cast<PHINode>(instr);
      assert(phi->getNumIncomingValues() == 2);

      BasicBlock* b0 = phi->getIncomingBlock(0);
      int b0Val = map_find(b0, basicBlockNos);

      BasicBlock* b1 = phi->getIncomingBlock(1);
      int b1Val = map_find(b1, basicBlockNos);

      Value* v0 = phi->getIncomingValue(0);
      string val0Name = outputNameLast(v0, unitAssignment, names, memoryMap);

      Value* v1 = phi->getIncomingValue(1);
      string val1Name = outputNameLast(v1, unitAssignment, names, memoryMap);
            
      out << "\t\t\t" << addUnit.portWires["in0"] << " = " << val0Name << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"] << " = " << val1Name << ";" << endl;

      out << "\t\t\t" << addUnit.portWires["s0"] << " = " << b0Val << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["s1"] << " = " << b1Val << ";" << endl;

      out << "\t\t\t" << addUnit.portWires["last_block"] << " = last_BB_reg;" << endl;
    } else if (SelectInst::classof(instr)) {
      SelectInst* sel = dyn_cast<SelectInst>(instr);

      Value* cond = sel->getCondition();
      string condName = outputName(cond, unitAssignment, memoryMap);

      Value* trueVal = sel->getTrueValue();
      string trueName = outputName(trueVal, unitAssignment, memoryMap);

      Value* falseVal = sel->getFalseValue();
      string falseName = outputName(falseVal, unitAssignment, memoryMap);
      
      out << "\t\t\t" << addUnit.portWires["in0"] << " = " << falseName << ";" << endl;
      out << "\t\t\t" << addUnit.portWires["in1"] << " = " << trueName << ";" << endl;

      out << "\t\t\t" << addUnit.portWires["sel"] << " = " << condName << ";" << endl;

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
  
  void emitControlCode(std::ostream& out,
                       const STG& stg,
                       map<Instruction*, FunctionalUnit>& unitAssignment,
                       map<Instruction*, Wire>& names,
                       const std::vector<ElaboratedPipeline>& pipelines) {
    for (auto state : stg.opTransitions) {

      out << "\t\t\tif (global_state == " + to_string(state.first) + ") begin" << endl;

      out << "\t\t\t\t// Store data computed at the stage" << endl;
        
      for (auto instrG : map_find(state.first, stg.opStates)) {
        Instruction* instr = instrG.instruction;
        auto schedVars = map_find(instr, stg.sched.instrTimes);

        if (ReturnInst::classof(instr) && (state.first == schedVars.back())) {

          out << "\t\t\t\tif (" << verilogForCondition(instrG.cond, state.first, stg, unitAssignment, names) << ") begin" << endl;

          out << "\t\t\t\t\tvalid_reg <= 1;" << endl;
          out << "\t\t\t\tend" << endl;
        }

        if (hasOutput(instr) && (state.first == schedVars.back())) {

          string instrName = map_find(instr, names).name;
          auto unit = map_find(instr, unitAssignment);

          out << "\t\t\t\tif (" << verilogForCondition(instrG.cond, state.first, stg, unitAssignment, names) << ") begin" << endl;

          out << "\t\t\t\t\t" << instrName << " <= " << unit.onlyOutputVar() << ";" << endl;
          out << "\t\t\t\tend" << endl;
          
        }
      }
      
      out << "\t\t\t\t// Next state transition logic" << endl;
      for (auto transitionDest : state.second) {

        if (isPipelineState(transitionDest.dest, pipelines)) {

          auto p = getPipeline(transitionDest.dest, pipelines);

          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          //          out << "\t\t\t\tif (" << p.inPipe.name << " && " << p.valids.at(p.stateIndex(transitionDest.dest)).name << " && (" << verilogForCondition(transitionDest.cond, state.first, stg, unitAssignment, names) << ")) begin" << endl;

          out << "\t\t\t\tif (" << verilogForCondition(transitionDest.cond, state.first, stg, unitAssignment, names) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " << p.stateId << ";" << endl;
          out << "\t\t\t\t\t" << p.valids.at(0).name << " <= 1;" << endl;
          out << "\t\t\t\tend" << endl;
          
        } else {
          out << "\t\t\t\t// Condition = " << transitionDest.cond << endl;
          out << "\t\t\t\tif (" << verilogForCondition(transitionDest.cond, state.first, stg, unitAssignment, names) << ") begin" << endl;
          out << "\t\t\t\t\tglobal_state <= " + to_string(transitionDest.dest) + + ";" << endl;
          out << "\t\t\t\tend" << endl;
        }
      }

      out << "\t\t\tend" << endl;
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
    out << "\t// Start pipeline instruction code" << endl;

    out << "\t// Start pipeline stages" << endl;
    for (auto p : pipelines) {
      for (int i = 0; i < p.valids.size(); i++) {
        Wire valid = p.valids[i];
        StateId state = p.p.getStates().at(i);
        for (auto instrG : map_find(state, stg.opStates)) {
          out << "\talways @(*) begin" << endl;
          out << "\t\tif (" << p.inPipe.name << " && " << valid.name << ") begin" << endl;

          Instruction* instr = instrG.instruction;

          auto schedVars = map_find(instr, stg.sched.instrTimes);
          if (state == schedVars.front()) {

            out << "\t\t\tif (" << verilogForCondition(instrG.cond, state, stg, unitAssignment, names) << ") begin" << endl;

            instructionVerilog(out, instr, unitAssignment, memoryMap, names, basicBlockNos);


            out << "\t\t\tend" << endl;
          }
          
          out << "\t\tend" << endl;
          out << "\tend" << endl;
        }
      }
    }
    out << "\t// End pipeline instruction code" << endl << endl;
  }
  
  // TODO: Experiment with adding defaults to all functional unit inputs
  void emitInstructionCode(std::ostream& out,
                           const STG& stg,
                           map<Instruction*, FunctionalUnit>& unitAssignment,
                           map<string, int>& memoryMap,
                           map<Instruction*, Wire>& names,
                           map<BasicBlock*, int>& basicBlockNos,
                           const std::vector<ElaboratedPipeline>& pipelines) {

    for (auto state : stg.opStates) {

      if (!isPipelineState(state.first, pipelines)) {
        for (auto instrG : state.second) {

          out << "\talways @(*) begin" << endl;
          out << "\t\tif (global_state == " + to_string(state.first) + ") begin" << endl;

          Instruction* instr = instrG.instruction;

          auto schedVars = map_find(instr, stg.sched.instrTimes);
          if (state.first == schedVars.front()) {

            out << "\t\t\tif (" << verilogForCondition(instrG.cond, state.first, stg, unitAssignment, names) << ") begin" << endl;

            instructionVerilog(out, instr, unitAssignment, memoryMap, names, basicBlockNos);


            out << "\t\t\tend" << endl;
          }

          out << "\t\tend" << endl;
          out << "\tend" << endl;      
        
        }
      }

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
      if (!pt.isInput) {
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
    for (auto iUnit : unitAssignment) {
      auto unit = iUnit.second;

      // These are external functional units
      if ((unit.modName == "load") ||
          (unit.modName == "store") ||
          (unit.modName == "ret")) {
        continue;
      }

      vector<string> wireDecls;
      for (auto w : unit.portWires) {
        out << "\treg [31:0] " << w.second << ";" << endl;
        wireDecls.push_back("." + w.first + "(" + w.second + ")");
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
    // TODO: Add real next state computation
    int pipeState = 200000;
    for (auto p : stg.pipelines) {
      string iStr = to_string(i);
      
      ElaboratedPipeline ep(p);
      ep.stateId = pipeState + i;
      ep.inPipe = Wire(1, "in_pipeline_" + iStr);
      
      for (int j = 0; j < p.depth(); j++) {
        string jStr = to_string(j);
        ep.valids.push_back(Wire(true, 1, "pipeline_stage_" + jStr + "_valid"));
      }

      pipelines.push_back(ep);
    }

    return pipelines;
  }

  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<std::string, int>& memoryMap) {

    map<BasicBlock*, int> basicBlockNos = numberBasicBlocks(f);
    map<Instruction*, Wire> names = createInstrNames(stg);
    vector<ElaboratedPipeline> pipelines =
      buildPipelines(f, stg);

    string fn = f->getName();
    vector<Port> allPorts = getPorts(stg);
    vector<string> portStrings;
    for (auto pt : allPorts) {
      portStrings.push_back(pt.toString());
    }

    ofstream out(fn + ".v");
    out << "module " << fn << "(" + commaListString(portStrings) + ");" << endl;

    out << endl;

    emitPorts(out, allPorts);

    map<Instruction*, FunctionalUnit> unitAssignment =
      assignFunctionalUnits(stg);

    emitFunctionalUnits(out, unitAssignment);
    emitRegisterStorage(out, names);
    emitPipelineVariables(out, pipelines);
    emitGlobalStateVariables(out);

    emitPipelineResetBlock(out, pipelines);
    emitPipelineValidChainBlock(out, pipelines);

    out << endl;
    for (auto p : pipelines) {
      out << "\tassign " << p.inPipe.name << " = global_state == " << p.stateId << ";"<< endl;
    }

    out << "\talways @(posedge clk) begin" << endl;

    out << "\t\t$display(\"global_state = %d\", global_state);" << endl;

    // Insert state transition logic
    out << "\t\tif (rst) begin" << endl;
    out << "\t\t\tglobal_state <= 0;" << endl;
    out << "\t\t\tvalid_reg <= 0;" << endl;
    out << "\t\t\tlast_BB_reg <= " << map_find(&(f->getEntryBlock()), basicBlockNos) << ";" << endl;

    out << "\t\tend else begin" << endl;

    out << "\t\t\tlast_BB_reg <= last_BB;" << endl;
      

    emitControlCode(out, stg, unitAssignment, names, pipelines);

    out << "\tend" << endl;
    out << endl << endl;

    emitPipelineInstructionCode(out, pipelines, stg, unitAssignment, memoryMap, names, basicBlockNos);
    emitInstructionCode(out, stg, unitAssignment, memoryMap, names, basicBlockNos, pipelines);

    out << "endmodule" << endl;

    out.close();
  }

}
