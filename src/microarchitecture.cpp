#include "microarchitecture.h"

#include "utils.h"

#include <llvm/IR/CFG.h>

#include <llvm/Analysis/OrderedBasicBlock.h>

#include <fstream>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  Wire nextBBReg(const StateId state, MicroArchitecture& arch);
  
  Wire lastBlockActiveInState(const StateId st,
                              BasicBlock* const bb,
                              MicroArchitecture& arch);
  
  PortController& makeConcat(const int width0,
                             const int width1,
                             MicroArchitecture& arch);
  Wire concatWires(const Wire in0, const Wire in1, MicroArchitecture& arch);
  
  Wire buildAtStateWire(const StateId state, MicroArchitecture& arch) {
    if (arch.isPipelineState(state)) {
      auto p = arch.getPipeline(state);
      Wire active = checkAnd(p.inPipeWire(), p.stateIsActiveWire(state), arch);
      return active;
    } else {
      Wire active = checkEqual(state, arch.cs.getGlobalState(), arch);
      return active;
    }
  }

  Wire atStateWire(const StateId state, MicroArchitecture& arch) {
    cout << "Getting wire for " << state << endl;
    return map_find(state, arch.atStateWires);
  }

  std::ostream& operator<<(std::ostream& out, const RegController& controller) {
    out << tab(1) << "always @(posedge clk) begin" << endl;
    out << tab(2) << "if (rst) begin" << endl;
    out << tab(3) << controller.reg.name << " <= " << controller.resetValue << ";" << endl;
    out << tab(2) << "end else begin" << endl;
    for (auto val : controller.values) {
      out << tab(3) << "if (" << val.first.valueString() << ") begin" << endl;
      out << tab(4) << controller.reg.name << " <= " << val.second.valueString() << ";" << endl;
      out << tab(3) << "end" << endl;      
    }
    out << tab(2) << "end" << endl;
    out << tab(1) << "end" << endl;

    return out;
  }

  int getArgNum(Argument* arg) {
    int index = 0;
    Function* f = arg->getParent();
    for (auto& nextArg : f->args()) {
      if (arg == &nextArg) {
        return index;
      }
      index++;
    }
    assert(false);
  }
  
  std::string valueArgName(Argument* arg) {
    string name = arg->getName();
    if (name == "") {
      int num = getArgNum(arg);
      return "arg_" + to_string(num) + "_out_data";
    } else {
      return name + "_out_data";
    }
  }
  
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

    // Add value parameters to architecture
    for (auto& arg : arch.stg.getFunction()->args()) {
      if (!PointerType::classof(arg.getType())) {
        Type* tp = arg.getType();
        if (!IntegerType::classof(tp)) {
          cout << "Error: non integer type passed by value = " << typeString(tp) << endl;
          assert(IntegerType::classof(tp));
        }
        auto iTp = dyn_cast<IntegerType>(tp);
        string name = valueArgName(&arg);
        cout << "Integer port name = " << name << endl;
        pts.push_back(inputPort(getTypeBitWidth(iTp), name));
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
    } else if (instr->getOpcode() == Instruction::Shl) {
      modName = "shlOp";
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

  FunctionalUnit functionalUnitForSpec(const std::string unitName,
                                       const ModuleSpec& mSpec) {

    //cout << "Creating functional unit for " << mSpec << endl;
    bool isExternal = false;

    map<string, Wire> wiring;
    map<string, Wire> outWires;    
    for (auto pt : mSpec.ports) {
      if (pt.second.input()) {
        wiring.insert({pt.first, {true, pt.second.width, unitName + "_" + pt.second.name}});
      } else {
        outWires.insert({pt.first, {false, pt.second.width, unitName + "_" + pt.second.name}});            
      }
    }

    FunctionalUnit unit = {mSpec, unitName, wiring, outWires, isExternal};

    return unit;
  }
  
  FunctionalUnit structFunctionalUnit(Value* instr,
                                      HardwareConstraints& hcs) {
    string unitName;
    if (instr->getName() != "") {
      unitName = instr->getName();
    } else {
      unitName = sanitizeFormatForVerilogId(valueString(instr));      
    }

    assert(hcs.hasArgumentSpec(instr));

    ModuleSpec mSpec = hcs.getArgumentSpec(instr);
    return functionalUnitForSpec(unitName, mSpec);
  }
  
  FunctionalUnit createMemUnit(std::string unitName,
                               map<Value*, std::string>& memNames,
                               map<Instruction*, Value*>& memSrcs,
                               HardwareConstraints& hcs,
                               int& readNum,
                               int& writeNum,
                               llvm::Instruction* instr) {

    // cout << "Hardware memory storage names in createMemUnit" << endl;
    // for (auto mspec : hcs.memSpecs) {
    //   cout << valueString(mspec.first) << " -> " << mspec.second.modSpec.name << endl;
    // }
    
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
        if (contains_key(memVal, hcs.memSpecs)) {
          modName = map_find(memVal, hcs.memSpecs).modSpec.name;
        } else {
          modName = "register";
        }

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
        if (contains_key(memVal, hcs.modSpecs)) {
          assert(memVal->getName() != "");

          assert(memVal->getName() != "");
          string name = string(memVal->getName());
          FunctionalUnit fu =
            functionalUnitForSpec(name, map_find(memVal, hcs.modSpecs));
          fu.external = true;
          return fu;

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
      }

    } else if (LoadInst::classof(instr)) {

      //cout << "Finding memories for " << valueString(instr) << endl;
      
      Value* memVal = map_find(instr, memSrcs);          
      string memSrc = memName(instr, memSrcs, memNames);

      // If we are loading from an internal RAM, not an argument
      if (!Argument::classof(memVal)) {
        if (contains_key(memVal, hcs.memSpecs)) {
          string name = map_find(memVal, hcs.memSpecs).modSpec.name;
          cout << "Setting " << valueString(memVal) << " to " << name << endl;
          modName = name;
        } else {
          modName = "register";
        }
        
        //modName = "register";

        int dataWidth = getValueBitWidth(instr->getOperand(0));
        modParams = {{"WIDTH", to_string(dataWidth)}};
        
        unitName = memSrc;

        wiring = {{"raddr", {true, 32, "raddr_" + unitName + "_reg"}}, {"wen", {true, 1, "wen_" + unitName + "_reg"}}, {"waddr", {true, 32, "waddr_" + unitName + "_reg"}}, {"wdata", {true, dataWidth, "wdata_" + unitName + "_reg"}}};
        outWires = {{"rdata", {false, dataWidth, "rdata_" + unitName}}};
            
      } else {

        if (contains_key(memVal, hcs.modSpecs)) {
          assert(memVal->getName() != "");
          string name = string(memVal->getName());
          FunctionalUnit fu =
            functionalUnitForSpec(name, map_find(memVal, hcs.modSpecs));
          fu.external = true;
          return fu;
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
    set<string> insensitivePorts;
    map<string, Port> allPorts;
    //cout << "Creating a unit for " << valueString(instr) << endl;

    bool hasRst = false; //modSpec.hasReset();
    bool hasClock = false; //modSpec.isSequential();        
    
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

      ReturnInst* ret = dyn_cast<ReturnInst>(instr);
      if (ret->getReturnValue() != nullptr) {
        auto val = ret->getReturnValue();
        wiring.insert({"return_value", {true, getValueBitWidth(val), "return_value"}});
        defaults.insert({"return_value", 0});
        insensitivePorts.insert("return_value");
      }
      outWires = {};
          
    } else if (TruncInst::classof(instr)) {
      modName = "trunc";

      int inWidth = getValueBitWidth(instr->getOperand(0));
      int outWidth = getValueBitWidth(instr);

      modParams = {{"IN_WIDTH", to_string(inWidth)}, {"OUT_WIDTH", to_string(outWidth)}};
      wiring = {{"in", {true, inWidth, "trunc_in_" + rStr}}};
      outWires = {{"out", {false, outWidth, "trunc_out_" + rStr}}};
      
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

          if (!hcs.hasArgumentSpec(fuPtr)) {
            cout << "Error: No spec... possible choices" << endl;
            for (auto spec : hcs.typeSpecs) {
              cout << tab(1) << spec.first << endl;
            }
            assert(hcs.hasArgumentSpec(fuPtr));
          }
          modSpec = map_find(string(structT->getName()), hcs.typeSpecs)(structT);
        }

        modName = modSpec.name;
        unitName = fuPtr->getName();
        defaults = modSpec.defaultValues;
        insensitivePorts = modSpec.insensitivePorts;
        allPorts = modSpec.ports; 
        hasRst = modSpec.hasReset();
        hasClock = modSpec.isSequential();        

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
    } else if (AllocaInst::classof(instr)) {
      cout << "Alloca instruction = " << valueString(instr) << endl;
      AllocaInst* allocInst = dyn_cast<AllocaInst>(instr);
      Type* allocatedType = allocInst->getType()->getElementType();
      if (StructType::classof(allocatedType)) {
        cout << "Allocating struct of type " << typeString(allocatedType) << endl;
        return structFunctionalUnit(allocInst, hcs);
      }
    } else if (BitCastInst::classof(instr)) {
      // TODO: Add test case that uses casts
      // No action for this instruction type (YET)
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

    ModuleSpec modSpec = {modParams, modName, allPorts, defaults, insensitivePorts};
    modSpec.hasRst = hasRst;
    modSpec.hasClock = hasClock;


    FunctionalUnit unit = {modSpec, unitName, wiring, outWires, isExternal};

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

        Instruction* instr = instrG;

        auto rStr = to_string(resSuffix);
        if (!hcs.isLimitedResource(opType(instr))) {
          rStr = to_string(globalSuffix);
        }

        string unitName = string(instr->getOpcodeName()) + "_" + rStr;
        auto unit =
          createUnit(unitName, memNames, memSrcs, hcs, readNum, writeNum, instr);

        cout << "-- Created unit " << unit.instName << endl;
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

  std::ostream& operator<<(std::ostream& out, ControlFlowPosition& pos) {
    out << "Control Pos " << pos.stateId() << ": ";
    out << (pos.inPipeline() ? "PIPE" : "");
    out << valueString(pos.instr);

    return out;
  }
  
  ControlFlowPosition position(const StateId state, Instruction* const instr) {
    return {state, false, -1, instr};
  }

  ControlFlowPosition pipelinePosition(Instruction* const instr,
                                       const StateId state,
                                       const int stage) {
    return {state, true, stage, instr};
  }

  ControlFlowPosition position(const StateId state,
                               Instruction* const instr,
                               MicroArchitecture& arch) {
    ControlFlowPosition pos = position(state, instr);
    if (isPipelineState(state, arch.pipelines)) {
      auto p = getPipeline(state, arch.pipelines);
      int stage = p.stageForState(state);
      pos = pipelinePosition(instr, state, stage);
    }
    return pos;
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

  Wire sequentialReg(Instruction* result,
                     MicroArchitecture& arch) {
    Wire tmpRes = map_find(result, arch.names);
    return tmpRes;
  }
  
  Wire mostRecentStorageLocation(Instruction* result,
                                 ControlFlowPosition& currentPosition,
                                 MicroArchitecture& arch) {
    

    cout << "Getting most recent location of " << valueString(result) << " for instruction " << valueString(currentPosition.instr) << endl;


    // Thought: The datapath API could be one function which
    // gets the output wire of a piece of storage which stores the
    // last time the producer instruction was triggered along
    // the given control path to the user?
    if (currentPosition.inPipeline()) {
      cout << "We are in a pipeline" << endl;

      int stage = currentPosition.pipelineStage();
      auto p = arch.getPipeline(currentPosition.stateId());

      if (!producedInPipeline(result, p, arch)) {
        return sequentialReg(result, arch);
      }

      StateId argState = map_find(result, arch.stg.sched.instrTimes).back();
      StateId thisState = map_find(currentPosition.instr, arch.stg.sched.instrTimes).front();

      if (argState == thisState) {

        // BasicBlock* argBB = result->getParent();
        // BasicBlock* userBB = currentPosition.instr->getParent();

        // assert(argBB == userBB);

        // OrderedBasicBlock obb(argBB);

        // assert(!(obb.dominates(result, currentPosition.instr)));

        int stagePlusII = stage + p.II();
        if (stagePlusII >= (int) p.pipelineRegisters.size()) {

          return sequentialReg(result, arch);
          
          // assert(contains_key(result, arch.names));
                   
          // Wire tmpRes = map_find(result, arch.names);

          // cout << "Wire name = " << tmpRes.name << endl;
          // return tmpRes;
        } else {
          // Could I just get from the last active value?
          Wire tmpRes = map_find(result, p.pipelineRegisters[stage + p.II()]);
          return tmpRes;
        }

      } else {

        cout << "Value is in pipeline registers for another stage" << endl;
        Wire tmpRes = map_find(result, p.pipelineRegisters[stage]);
        return tmpRes;
      }
    }

    return sequentialReg(result, arch);
    
    // cout << "Getting the value of " << valueString(result) << " from arch.names" << endl;

    // assert(contains_key(result, arch.names));
    
    // Wire tmpRes = map_find(result, arch.names);

    // //cout << "Name is " << tmpRes.name << endl;
    
    // return tmpRes;
  }

  Wire dataOutputWire(llvm::Instruction* instr0, const MicroArchitecture& arch) {
    auto unit0Src =
      map_find(instr0, arch.unitAssignment);

    if (isBuiltinFifoRead(instr0)) {
      return map_find(string("out_data"), unit0Src.outWires);
    } else if (isBuiltinPortRead(instr0)) {
      auto portName = getPortName(instr0);
      //cout << "looking for " << portName << endl;
      if (!contains_key(string(portName), unit0Src.outWires)) {
        cout << "looking for " << portName << " for instruction " << valueString(instr0) << endl;
        assert(false);
      }
      return map_find(string(portName), unit0Src.outWires);
    } else {
      if (!(unit0Src.outWires.size() == 1)) {
        cout << "Error: Cannot find 1 output wire for " << valueString(instr0) << endl;
      }
      assert(unit0Src.outWires.size() == 1);
      return unit0Src.outputWire();
      // string valName = unit0Src.onlyOutputVar();
      // return valName;
    }
  }

  // This is a duplicate?
  string dataOutput(llvm::Instruction* instr0, const MicroArchitecture& arch) {
    return dataOutputWire(instr0, arch).valueString();
  }

  set<BasicBlock*> successorsInState(BasicBlock* const blk,
                                     const StateId state,
                                     MicroArchitecture& arch) {
    //return true;
    set<BasicBlock*> succs;
    for (BasicBlock* const succ : successors(blk)) {

      // Is this too restrictive? To be a successor
      // in this state the block does not need to
      // finish in this state, it just needs to start in
      // this state.
      if (arch.stg.blockStartState(succ) == state) {
        succs.insert(succ);
      }
    }

    return succs;
  }

  // TODO: I still think this code is wrong even though I dont have a test to
  // prove it. I dont see how it can deal with two looped blocks in a state
  // Also: Another problem here is that a block precedes itself in this code,
  // but in reality blocks never preceed themselves in
  bool blockPrecedesInState(BasicBlock* const maybeFirst,
                            BasicBlock* const maybeSecond,
                            const StateId state,
                            MicroArchitecture& arch) {
    //return true;
    
    set<BasicBlock*> successors{maybeFirst};
    bool addedSuccessors = true;
    while (addedSuccessors) {
      addedSuccessors = false;

      int oldSize = successors.size();
      for (auto blk : successors) {

        if (arch.stg.blockEndState(blk) == state) {
          for (auto succ : successorsInState(blk, state, arch)) {
            successors.insert(succ);
          }
        }
      }

      if (oldSize != successors.size()) {
        addedSuccessors = true;
      }
    }

    return elem(maybeSecond, successors);
  }
  
  Wire outputWire(Value* val,
                  ControlFlowPosition& currentPosition,
                  MicroArchitecture& arch) {
    
    cout << "Getting name of " << valueString(val) << endl;
    Instruction* instr = currentPosition.instr;
    cout << "In instruction " << valueString(instr) << endl;
    
    if (Instruction::classof(val)) {

      // Pointers to allocations (RAMs) always have a base
      // address of zero
      if (AllocaInst::classof(val)) {
        //return "0";
        return constWire(32, 0);
      }

      assert(!AllocaInst::classof(val));


      Instruction* instr = currentPosition.instr;
      auto instr0 = dyn_cast<Instruction>(val);

      if (instr0 == instr) {
        return dataOutputWire(instr0, arch);
      }

      StateId argState = map_find(instr0, arch.stg.sched.instrTimes).back();
      StateId thisState = map_find(instr, arch.stg.sched.instrTimes).front();

      if (argState == thisState) {

        BasicBlock* argBB = instr0->getParent();
        BasicBlock* userBB = instr->getParent();

        if (argBB != userBB) {

          int dataWidth = getValueBitWidth(instr0);
          string wireName = arch.uniqueName("tmp_output");
          PortController& controller =
            addPortController(wireName, dataWidth, arch);

          Wire storedWire = mostRecentStorageLocation(instr0, currentPosition, arch);
          Wire liveWire = dataOutputWire(instr0, arch);

          // TODO: Dont re-compute this every time
          auto topoLevels =
            topologicalLevelsForBlocks(thisState, arch.stg);

          for (auto entryToLevels : topoLevels) {
            BasicBlock* entryBlock = entryToLevels.first;

            Wire enteredThisBlk = checkEqual(arch.cs.getBasicBlockNo(entryBlock),
                                             nextBBReg(thisState, arch),
                                             arch);

            // We can skip any entry block that does not contain the user
            // because the user will never be referenced in a trace that
            // starts with this block
            if (contains_key(userBB, entryToLevels.second)) {
              if (!contains_key(argBB, entryToLevels.second)) {
                controller.setCond("in_data", enteredThisBlk, storedWire);
              } else {
                int userLevel = map_find(userBB, entryToLevels.second);
                int definedLevel = map_find(argBB, entryToLevels.second);

                if (userLevel > definedLevel) {
                  controller.setCond("in_data", enteredThisBlk, liveWire);
                } else {
                  controller.setCond("in_data", enteredThisBlk, storedWire); 
                }
              }
            } else {
              // DO nothing
            }
          }

          return controller.functionalUnit().outputWire();

        }

        OrderedBasicBlock obb(argBB);

        if (obb.dominates(instr0, instr)) {
          return dataOutputWire(instr0, arch);
        } else {
          //return sequentialReg(instr0, arch);
          return mostRecentStorageLocation(instr0, currentPosition, arch);
        }
        
      } else {
        //return sequentialReg(instr0, arch);
        return mostRecentStorageLocation(instr0, currentPosition, arch);
      }


    } else if (Argument::classof(val)) {
      if (PointerType::classof(val->getType())) {
        if (contains_key(val, arch.memoryMap)) {

          Type* under = dyn_cast<PointerType>(val->getType())->getElementType();
          return wire(getTypeBitWidth(under),
                      to_string(map_find(val, arch.memoryMap)));
        } else {
          assert(val->getName() != "");

          if (!contains_key(val, arch.hcs.modSpecs)) {
            cout << "Error: No module spec for " << valueString(val) << endl;
            for (auto m : arch.hcs.modSpecs) {
              cout << tab(1) << "Module " << valueString(m.first) << " has spec "
                   << m.second << endl;
            }
          }
          assert(contains_key(val, arch.hcs.modSpecs));
          ModuleSpec mSpec = map_find(val, arch.hcs.modSpecs);
          cout << "Module spec for " << valueString(val) << " is " << mSpec << endl;
          assert(mSpec.name == "register");

          // Pointer arguments that are not included in the memory map
          // are assumed to be registers
          Type* under = dyn_cast<PointerType>(val->getType())->getElementType();
          return wire(getTypeBitWidth(under), string(val->getName()) + "_rdata");
        }
      } else {
        cout << "Value argument of type " << typeString(val->getType()) << endl;
        return wire(getValueBitWidth(val), valueArgName(dyn_cast<Argument>(val)));
      }
    } else if (ConstantInt::classof(val)) {
      
      auto valC = dyn_cast<ConstantInt>(val);
      auto apInt = valC->getValue();

      // Get num bits
      // TODO: Clean up number printouts
      int tpWidth = getValueBitWidth(val);
      string iStr = to_string(dyn_cast<ConstantInt>(val)->getSExtValue());
      // if (iStr[0] == '-') {
      //   return "-" + parens(to_string(tpWidth) + "'d" + iStr.substr(1));
      // }

      //return parens(to_string(tpWidth) + "'d" + iStr);

      return constWire(tpWidth, dyn_cast<ConstantInt>(val)->getSExtValue());
    } else {
      cout << "Getting name of value " << valueString(val) << " of type " << typeString(val->getType()) << endl;
      assert(ConstantFP::classof(val));

      ConstantFP* fpVal = dyn_cast<ConstantFP>(val);

      cout << "Float value = " << valueString(fpVal) << endl;
      string floatBits = fpVal->getValueAPF().bitcastToAPInt().toString(2, false);

      cout << "Bitcast     = " << floatBits << endl;

      //return "32'b" + zeroExtend(floatBits, 32);
      return constWire(32, fpVal->getValueAPF().bitcastToAPInt().getLimitedValue());
    }
  }

  std::string outputName(Value* val,
                         ControlFlowPosition& currentPosition,
                         MicroArchitecture& arch) {
    return outputWire(val, currentPosition, arch).valueString();
  }
  
  Wire predecessor(const StateId state, BasicBlock* const bb, MicroArchitecture& arch) {
    int blkNo = arch.cs.getBasicBlockNo(bb);
    //string activeName = "bb_" + to_string(blkNo) + "_predecessor";
    string activeName = "bb_" + to_string(blkNo) + "_predecessor_in_state_" + to_string(state);

    return arch.portController(activeName).functionalUnit().outputWire();
  }
  
  // I would like for this function to just return instruction port
  // assignments that include the names of ports as keys, rather
  // than the names of specific wires connected to each functional unit
  // port, so that I could save information about whether this assignment
  // was sensitive to changes or not
  //std::map<std::string, std::string>
  //std::map<std::string, Wire>
  std::map<Wire, Wire>
  instructionPortAssignments(ControlFlowPosition pos,
                             MicroArchitecture& arch) {

    //cout << "Generating code for " << valueString(pos.instr) << endl;

    auto instr = pos.instr;
    auto addUnit = map_find(instr, arch.unitAssignment);

    //map<string, string> assignments;
    //map<string, Wire> assignments;
    map<Wire, Wire> assignments;

    if (ReturnInst::classof(instr)) {
      assert(addUnit.isExternal());
      
      //assignments.insert({addUnit.inputWire("valid"), "1"});
      assignments.insert({addUnit.input("valid"), constWire(1, 1)});

      ReturnInst* ret = dyn_cast<ReturnInst>(instr);
      Value* val = ret->getReturnValue();
      if (val != nullptr) {
        auto valName = outputWire(val, pos, arch);
        assignments.insert({addUnit.input("return_value"), valName});
      }
    } else if (StoreInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto wdataName = outputWire(arg0, pos, arch);
      
      Value* location = instr->getOperand(1);
      auto locValue = outputWire(location, pos, arch);

      assignments.insert({addUnit.input("waddr"), locValue});
      assignments.insert({addUnit.input("wdata"), wdataName});
      //assignments.insert({addUnit.inputWire("wen"), "1"});
      assignments.insert({addUnit.input("wen"), constWire(1, 1)});

    } else if (LoadInst::classof(instr)) {

      Value* location = instr->getOperand(0);
      auto locValue = outputWire(location, pos, arch);

      assignments.insert({addUnit.input("raddr"), locValue});

      if (contains_key(string("ren"), addUnit.portWires)) {
        //assignments.insert({addUnit.inputWire("ren"), "1"});
        assignments.insert({addUnit.input("ren"), constWire(1, 1)});
      }

    } else if (TruncInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputWire(arg0, pos, arch);

      assignments.insert({addUnit.portWires["in"], arg0Name});

    } else if (BinaryOperator::classof(instr) ||
               CmpInst::classof(instr)) {

      auto arg0 = instr->getOperand(0);
      auto arg0Name = outputWire(arg0, pos, arch);

      auto arg1 = instr->getOperand(1);
      auto arg1Name = outputWire(arg1, pos, arch);

      if (instr->getOpcode() == Instruction::FAdd) {
        //assignments.insert({addUnit.portWires["en"].name, "1"});
        assignments.insert({addUnit.portWires["en"], constWire(1, 1)});        
      }
      assignments.insert({addUnit.portWires["in0"], arg0Name});
      assignments.insert({addUnit.portWires["in1"], arg1Name});      
            
    } else if(GetElementPtrInst::classof(instr)) {

      auto numOperands = instr->getNumOperands();

      assert((numOperands == 2) || (numOperands == 3));

      auto arg0 = instr->getOperand(0);

      //cout << "arg0 = " << valueString(arg0) << endl;

      auto arg0Name = outputWire(arg0, pos, arch);

      assignments.insert({addUnit.portWires["base_addr"], arg0Name});

      for (int i = 1; i < (int) numOperands; i++) {
        auto arg1 = instr->getOperand(i);
        //cout << "Getting operand " << valueString(arg1) << endl;
        auto arg1Name =
          outputWire(arg1, pos, arch);

        assignments.insert({addUnit.portWires["in" + to_string(i)], arg1Name});
      }

    } else if (PHINode::classof(instr)) {

      PHINode* phi = dyn_cast<PHINode>(instr);      
      assert(phi->getNumIncomingValues() > 0);

      BasicBlock* b0 = phi->getIncomingBlock(0);
      int b0Val = arch.cs.getBasicBlockNo(b0);
      Value* v0 = phi->getIncomingValue(0);
      Wire input = outputWire(v0, pos, arch);
      Wire s = constWire(32, b0Val);

      for (int i = 1; i < (int) phi->getNumIncomingValues(); i++) {
        BasicBlock* b0 = phi->getIncomingBlock(i);
        int b0Val = arch.cs.getBasicBlockNo(b0);
        Value* v0 = phi->getIncomingValue(i);
        auto val0Name = outputWire(v0, pos, arch);

        // input = concatWires(input, val0Name, arch);
        // s = concatWires(s, constWire(32, b0Val), arch);

        input = concatWires(val0Name, input, arch);
        s = concatWires(constWire(32, b0Val), s, arch);
      }

      StateId phiStartState = arch.stg.instructionStartState(phi);
      
      assignments.insert({addUnit.portWires["in"], input});
      assignments.insert({addUnit.portWires["s"], s});
      assignments.insert({addUnit.portWires["last_block"], predecessor(phiStartState, phi->getParent(), arch)});

    } else if (SelectInst::classof(instr)) {
      SelectInst* sel = dyn_cast<SelectInst>(instr);

      Value* cond = sel->getCondition();
      auto condName = outputWire(cond, pos, arch);

      Value* trueVal = sel->getTrueValue();
      auto trueName = outputWire(trueVal, pos, arch);

      Value* falseVal = sel->getFalseValue();
      auto falseName = outputWire(falseVal, pos, arch);

      assignments.insert({addUnit.portWires["in0"], falseName});
      assignments.insert({addUnit.portWires["in1"], trueName});
      assignments.insert({addUnit.portWires["sel"], condName});

    } else if (CallInst::classof(instr)) {

      if (isBuiltinPortWrite(instr)) {

        std::string portName = getPortName(instr);
        cout << "Port name = " << portName << endl;
        auto val = outputWire(instr->getOperand(1), pos, arch);

        assignments.insert({addUnit.input(portName), val});

      } else if (isBuiltinPortRead(instr)) {

      } else {
      }
    } else if (AllocaInst::classof(instr) ||
               BitCastInst::classof(instr) ||
               BranchInst::classof(instr)) {
      // No-ops
    } else if(SExtInst::classof(instr)) {

      Value* trueVal = instr->getOperand(0);
      auto trueName = outputWire(trueVal, pos, arch);

      assignments.insert({addUnit.portWires["in"], trueName});
    } else if (ZExtInst::classof(instr)) {
      Value* inVal = instr->getOperand(0);
      auto inName = outputWire(inVal, pos, arch);
      assignments.insert({addUnit.portWires["in"], inName});
    } else {

      std::string str;
      llvm::raw_string_ostream ss(str);
      ss << *(instr);

      cout << "Error: Emitting code for unknown instruction " << ss.str() << std::endl;
      assert(false);
    }

    return assignments;
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

  // TODO: Update this function. Should use the same logic
  // as the outputName function does to decide on temporary usage
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

  Wire andCond(vector<Wire>& allConds,
               MicroArchitecture& arch) {
    if (allConds.size() == 0) {
      return constWire(1, 1);
    }

    Wire w = allConds[0];
    for (int i = 1; i < (int) allConds.size(); i++) {
      Wire right = allConds[i];
      w = checkAnd(w, right, arch);
    }
    return w;
  }
  
  void emitTempStorage(const StateId state,
                       MicroArchitecture& arch) {


    auto& names = arch.names;
    auto& pipelines = arch.pipelines;
    auto& unitAssignment = arch.unitAssignment;
    
    for (auto instrG : arch.stg.instructionsFinishingAt(state)) {
      Instruction* instr = instrG;

      if (hasOutput(instr)) {

        assert(contains_key(instr, names));

        Wire instrWire = map_find(instr, names);
        string instrName = map_find(instr, names).name;
        
        if (isPipelineState(state, pipelines)) {
          auto p = getPipeline(state, pipelines);
          int stage = p.stageForState(state);
          if (stage < p.numStages() - 1) {
            instrName = map_find(instr, p.pipelineRegisters[stage + 1]).name;
            instrWire = map_find(instr, p.pipelineRegisters[stage + 1]);
          }
        }

        if (needsTempStorage(instr, arch)) {
          auto unit = map_find(instr, unitAssignment);

          Wire cond = blockActiveInState(state, instr->getParent(), arch);
          
          arch.getController(instrWire).values[cond] = dataOutputWire(instr, arch);
        }
          
      }
    }

  }

  bool isTerminalState(const StateId state,
                       const ElaboratedPipeline& p,
                       MicroArchitecture& arch) {
    return p.p.endState() == state;
  }
  
  std::set<StateId> allStates(const ElaboratedPipeline& p) {
    set<StateId> states(begin(p.p.getStates()), end(p.p.getStates()));
    return states;
  }

  Wire
  pipelineClearOnNextCycleCondition(const ElaboratedPipeline& p,
                                    MicroArchitecture& arch) {
    Wire s = constWire(1, 1);
    for (StateId state : allStates(p)) {
      if (!isTerminalState(state, p, arch)) {
        s = checkAnd(s, checkNotWire(p.stateIsActiveWire(state), arch), arch);
      }
    }
    // for (int i = 0; i < (p.numStages() - 1); i++) {
    //   s = checkAnd(s, checkNotWire(p.valids.at(i), arch), arch);
    // }

    return s;
  }

  Instruction*
  lastInstructionForBlockInState(BasicBlock* const blk,
                                 const StateId state,
                                 MicroArchitecture& arch) {
    OrderedBasicBlock obb(blk);
    Instruction* last = nullptr;
    
    for (auto instrG : map_find(state, arch.stg.opStates)) {
      if (instrG->getParent() != blk) {
        continue;
      }

      if ((last == nullptr) || obb.dominates(last, instrG)) {
        last = instrG;
      }
    }

    return last;
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

  void emitTempStorageCode(const StateId state,
                           MicroArchitecture& arch) {

    emitTempStorage(state,
                    arch);
    
  }

  StateId findLastNonBlankState(const StateId state, STG& stg) {
    assert(state > 0);
    StateId lastNonBlank = state - 1;

    do {
      if (!stg.isEmptyState(lastNonBlank)) {
        return lastNonBlank;
      }

      lastNonBlank--;
    } while (lastNonBlank > 0);

    assert(!stg.isEmptyState(lastNonBlank));
    return lastNonBlank;
  }

  StateId entryState(const ElaboratedPipeline& p) {
    return p.p.startState();
  }
  
  Wire entryStateActiveWire(const ElaboratedPipeline& p) {
    return p.stateIsActiveWire(entryState(p));
  }
  
  void addStateTransition(const StateId state,
                          const StateId dest,
                          Wire jumpCond,
                          MicroArchitecture& arch) {

    cout << "Adding transition from " << state << " to " << dest << endl;

    auto& controller = arch.getController(reg(32, "global_state"));
    auto& pipelines = arch.pipelines;

    if (isPipelineState(state, pipelines)) {

      auto p = getPipeline(state, pipelines);

      if (isPipelineState(dest, pipelines)) {

        assert(getPipeline(dest, pipelines).stateId == p.stateId);

      } else {

        // TODO: Generalize name to avoid overlap
        RegController& outOfPipeJumpHappened =
          arch.getController(wire(1, "out_of_pipe_" + to_string(state) + "_" + to_string(dest)));
        outOfPipeJumpHappened.resetValue = "0";
        outOfPipeJumpHappened.values[jumpCond] = constWire(1, 1);

        Wire exitNextCycle =
          checkAnd(p.inPipeWire(), pipelineClearOnNextCycleCondition(p, arch), arch);

        controller.values[checkAnd(exitNextCycle, outOfPipeJumpHappened.reg, arch)] =
          constWire(32, dest);
      }

    } else {
      vector<Wire> conds{}; //atStateCond};
      if (isPipelineState(dest, pipelines)) {

        auto p = getPipeline(dest, pipelines);

        RegController& validController =
          arch.getController(entryStateActiveWire(p)); //p.valids.at(0));
        validController.values[andCond(conds, arch)] = constWire(1, 1);
          
        conds.push_back(jumpCond);
        controller.values[andCond(conds, arch)] = constWire(32, p.stateId);

      } else {
        conds.push_back(jumpCond);

        controller.values[andCond(conds, arch)] = constWire(32, dest);
      }
    }
  }

  bool instructionInProgressAt(llvm::Instruction* instr,
                               const StateId state,
                               STG& stg) {
    return elem(state, map_find(instr, stg.sched.instrTimes));
  }

  // Returns the set of all basic blocks that contain instructions
  // that are in progress in state, but where the terminator of the block
  // does not execute in state
  // I keep trying to express these state transitions in terms of basic
  // blocks, but maybe they need to be expressed in terms of CFG edges.
  // The problem is that blocks that start in one state and stop in another
  // have "edges" in the state transition graph, that do not exist in the
  // CFG because they are not transitions between blocks, they are transitions
  // between groups of instructions in the same block
  std::set<BasicBlock*>
  nonTerminatingBlocks(const StateId state,
                       STG& stg) {
    vector<Instruction*> instrsAtState = map_find(state, stg.opStates);
    set<BasicBlock*> allBlocks;
    for (auto instr : instrsAtState) {
      allBlocks.insert(instr->getParent());
    }
    for (auto blk : stg.sched.blockTimes) {
      for (auto stateNum : blk.second) {
        if (stateNum == state) {
          allBlocks.insert(blk.first);
        }
      }
    }

    cout << "All blocks size = " << allBlocks.size() << endl;
    
    set<BasicBlock*> nonTerminating;
    for (auto blk : allBlocks) {
      bool terminatorFinishesInState = false;
      for (auto& instrPtr : *blk) {
        auto* instr = &instrPtr;
        if (TerminatorInst::classof(instr) &&
            instructionInProgressAt(instr, state, stg) &&
            (stg.instructionEndState(instr) == state)) {
          terminatorFinishesInState = true;
          break;
        }
      }

      if (!terminatorFinishesInState) {
        nonTerminating.insert(blk);
      }
    }

    return nonTerminating;
  }

  std::set<BasicBlock*>
  terminatingBlocks(const StateId state,
                    STG& stg) {
    vector<Instruction*> instrsAtState = map_find(state, stg.opStates);
    set<BasicBlock*> allBlocks;
    for (auto instr : instrsAtState) {
      allBlocks.insert(instr->getParent());
    }

    cout << "All blocks size = " << allBlocks.size() << endl;
    
    set<BasicBlock*> terminating;
    for (auto blk : allBlocks) {
      bool terminatorFinishesInState = false;
      for (auto& instrPtr : *blk) {
        auto* instr = &instrPtr;
        if (TerminatorInst::classof(instr) &&
            instructionInProgressAt(instr, state, stg) &&
            (stg.instructionEndState(instr) == state)) {
          terminatorFinishesInState = true;
          break;
        }
      }

      if (terminatorFinishesInState) {
        terminating.insert(blk);
      }
    }

    return terminating;
  }
  
  // Want to move toward merging basic blocks in to a single state
  // and allowing more code to be executed in a cycle. Need to
  // add the active basic block variable

  StateId dstState(const CFGJump& jmp,
                   STG& stg) {
    return stg.blockStartState(jmp.jmp.second);
  }

  Wire nextBBReg(const StateId state, MicroArchitecture& arch) {
    return wire(32, "global_next_block");
    //return map_find(state, arch.entryBBWires);
  }

  RegController& nextBBController(const StateId state, MicroArchitecture& arch) {
    // Wire bbReg = nextBBReg(state, arch);
    // return arch.getController(bbReg);

    return arch.getController(wire(32, "global_next_block"));
  }
  
  Wire lastBBReg(const StateId state, MicroArchitecture& arch) {
    //return reg(32, "last_BB_reg"); //map_find(state, arch.lastBBWires);
    return map_find(state, arch.lastBBWires);
  }

  // Now: I want the lastBB register, state is active
  // wires, and global_next_block wires to be per-state
  void emitStateCode(const StateId state,
                     MicroArchitecture& arch) {


    //RegController& rc = arch.getController(reg(32, "last_BB_reg"));
    for (auto jmp : possibleLastJumps(state, arch.stg)) {
      StateId dst = dstState(jmp, arch.stg);

      RegController& rc = arch.getController(lastBBReg(dst, arch));
      
      auto bbNo = arch.cs.getBasicBlockNo(jmp.jmp.first);
      if (isPipelineState(state, arch.pipelines)) {
        ElaboratedPipeline p = getPipeline(state, arch.pipelines);
        rc.values[atStateWire(p.stateId, arch)] = constWire(32, bbNo);
      } else {
        Wire condWire = map_find(jmp.jmp, arch.edgeTakenWires);
        rc.values[condWire] = constWire(32, bbNo);
      }
    }

    vector<pair<StateId, StateId> > newTransitions;
    for (auto transition : getOutOfStateTransitions(state, arch.stg)) {
      BasicBlock* srcBlk = transition.first;
      BasicBlock* dest = transition.second;

      BranchInst* br = dyn_cast<BranchInst>(srcBlk->getTerminator());
      
      StateId src = state;
      StateId end = arch.stg.blockStartState(dest);

      ControlFlowPosition pos =
        position(state, br, arch);
      
      Wire condWire;
      if (br->isConditional()) {
        assert(br->getNumSuccessors() == 2);
        assert(br->getSuccessor(0) != br->getSuccessor(1));

        Value* jmpTest = br->getOperand(0);
        Wire jmpTestName = outputWire(jmpTest, pos, arch);
        if (br->getSuccessor(0) == dest) {
          condWire = jmpTestName;
        } else {
          assert(br->getSuccessor(1) == dest);
          
          condWire = checkNotWire(jmpTestName, arch);
        }
      } else {
        condWire = constWire(1, 1);
      }

      condWire = checkAnd(blockActiveInState(state, br->getParent(), arch), condWire, arch);
      addStateTransition(state, end, condWire, arch);
      
      newTransitions.push_back({src, end});
    }

    for (auto instr : arch.stg.instructionsFinishingAt(state)) {
      if (ReturnInst::classof(instr)) {

        StateId dest = state;
        if (arch.stg.sched.hasReturnDefault()) {
          dest = arch.stg.sched.getDefaultReturnState();
        }

        Wire condWire = constWire(1, 1);
        condWire = checkAnd(blockActiveInState(state, instr->getParent(), arch), condWire, arch);
        addStateTransition(state, dest, condWire, arch);
      }
    }

    // Unconditional transition to a different state
    // Actually we ought to do this even if we do find terminators
    // because with multiple basic blocks it is possible to end
    // in a non-terminating block even if other blocks have terminators
    //for (auto blk : nonTerminatingBlocks(state, arch.stg)) {
    for (auto blk : inProgressBlocks(state, arch.stg)) {

      cout << "Found non terminating block in " << state << endl;

      StateId dest = state + 1;
      Wire condWire = constWire(1, 1);
      condWire = checkAnd(blockActiveInState(state, blk, arch), condWire, arch);
      addStateTransition(state, dest, condWire, arch);
    }

  }

  // TODO: Remove resetValues field?
  void emitControlCode(MicroArchitecture& arch) {

    arch.addController("global_state", 32);
    arch.getController("global_state").resetValue =
      map_find(wire(32, "global_state"), arch.resetValues);
    
    for (auto state : arch.stg.opStates) {
      emitStateCode(state.first, arch);
    }

    for (auto state : arch.stg.opStates) {    
      emitTempStorageCode(state.first, arch);
    }

    for (auto p : arch.pipelines) {
      PortController& pc = addPortController(p.inPipe.name, 1, arch);
      pc.setAlways("in_data", checkEqual(p.stateId, arch.cs.getGlobalState(), arch));
    }

  }

  bool usedInExactlyOneState(UnitController& controller) {
    int numUses = 0;
    for (auto st : controller.instructions) {
      numUses += st.second.size();
    }

    return numUses == 1;
  }

  bool stateless(FunctionalUnit& unit) {
    vector<string> statelessUnits{"add", "sub", "shlOp", "mul", "phi", "getelementptr_2", "ne", "eq", "trunc", "sext", "slt", "andOp", "notOp", "sgt", "orOp", "concat"};
    return elem(unit.getModName(), statelessUnits);
  }

  bool isInsensitive(const std::string& port,
                     PortController& portController) {
    return elem(port, portController.functionalUnit().module.insensitivePorts);
  }

  // Wire containerBlockIsActive(Instruction* const instr,
  //                             MicroArchitecture& arch) {
  //   BasicBlock* bb = instr->getParent();
  //   return arch.isActiveBlockVar(bb);
  // }
  
  // Here I am calling atState after the mapping of instructions on to
  // cycles has vanished. By construction the schedule should never
  // put instructions that could execute simultaneously in the same cycle
  // on the same functional unit. So really I ought to be able to
  // 
  void buildPortControllers(MicroArchitecture& arch) {

    vector<UnitController> assignment;
    // Add output check
    for (auto state : arch.stg.opStates) {

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

    map<string, PortController> controllers;
    for (auto controller : assignment) {

      FunctionalUnit unit = controller.unit;
      if (unit.getModName() == "br_dummy") {
        continue;
      }

      PortController portController;
      portController.unitController = controller;
        
      for (auto stInstrG : controller.instructions) {
        StateId state = stInstrG.first;
        auto instrsAtState = stInstrG.second;

        for (auto instrG : instrsAtState) {
          Instruction* instr = instrG;

          Wire condWire = blockActiveInState(state, instr->getParent(), arch);
          
          auto pos = position(state, instr, arch);
          auto assigns = instructionPortAssignments(pos, arch);

          for (auto portAndValue : assigns) {

            Wire portName = portAndValue.first;
            Wire portVal = portAndValue.second;
            if (!contains_key(portName.valueString(), portController.inputControllers)) {
              portController.inputControllers[portName.valueString()] = PortValues();
            }

            PortValues& vals = portController.inputControllers[portName.valueString()];
            vals.portVals.insert({condWire, portVal});
          }

        }

      }

      for (auto wd : unit.module.defaultValues) {
        if (portController.isExternal()) {
          portController.statelessDefaults.insert({unit.portWires[wd.first].name + "_reg", to_string(wd.second)});
        } else {
          portController.statelessDefaults.insert({unit.portWires[wd.first].name, to_string(wd.second)});            
        }
      }

      controllers[portController.functionalUnit().instName] = portController;
    }

    for (auto pc : controllers) {
      assert(!contains_key(pc.first, arch.portControllers));
      arch.portControllers[pc.first] = pc.second;
    }
  }

  Wire lastBlockActiveInState(const StateId st,
                              BasicBlock* const bb,
                              MicroArchitecture& arch) {
    Wire cond = blockActiveInState(st, bb, arch);
    // TODO: Should be same state successors for optimization
    for (BasicBlock* succ : successors(bb)) {
      if (succ != bb) {
        cond = checkAnd(checkNotWire(blockActiveInState(st, succ, arch), arch), cond, arch);
      }
    }

    return cond;
  }

  // void emitLastBBCode(MicroArchitecture& arch) {

  //   RegController& rc = arch.getController(reg(32, "last_BB_reg"));

  //   // Find each branch instruction
  //   // For each branch instruction if the branch goes out to
  //   // a block in another state (or its own block) then set the
  //   // next block variable, otherwise set the current (combinational) block
  //   // variable.
  //   for (auto st : arch.stg.opStates) {
  //     if (st.second.size() > 0) {

  //       for (auto instr : arch.stg.instructionsFinishingAt(st.first)) {
  //         if (TerminatorInst::classof(instr)) {
  //           auto bbNo = arch.cs.getBasicBlockNo(instr->getParent());
  //           if (isPipelineState(st.first, arch.pipelines)) {
  //             ElaboratedPipeline p = getPipeline(st.first, arch.pipelines);
  //             //rc.values[atStateWire(p.stateId, arch)] = to_string(bbNo);
  //             rc.values[atStateWire(p.stateId, arch)] = constWire(32, bbNo);
  //           } else {

  //             // If this block is the last active block in st
  //             // then set last_BB_reg to be it, do not
  //             //rc.values[atState(st.first, arch)] = to_string(bbNo);

              
  //             Wire condWire = lastBlockActiveInState(st.first, instr->getParent(), arch);
  //             //rc.values[condWire.valueString()] = to_string(bbNo);
  //             //rc.values[condWire] = to_string(bbNo);
  //             rc.values[condWire] = constWire(32, bbNo);
  //           }
  //         }

  //       }
  //     }
  //   }

  // }

  FunctionalUnit wireUnit(const std::string& name,
                          const int width) {
    ModuleSpec m = wireSpec(width);
    return functionalUnitForSpec(name, m);
  }

  PortController& addPortController(const std::string& name,
                                    const int width,
                                    MicroArchitecture& arch) {
    auto unit = wireUnit(name, width);
    arch.functionalUnits.push_back(unit);
    PortController c;
    UnitController uc;
    uc.unit = unit;
    c.unitController = uc;
    arch.portControllers[unit.instName] = c;

    return arch.portController(name);
  }
  
  Wire wireValue(const std::string& hName,
                        MicroArchitecture& arch) {
    auto& pController = arch.portController(hName);
    return pController.unitController.unit.outputWire();
  }
  
  ModuleSpec comparatorSpec(const std::string& name, const int width) {
    ModuleSpec unit;
    unit.name = name;
    unit.hasClock = false;
    unit.hasRst = false;
    unit.params = {{"WIDTH", to_string(width)}};
    unit.ports = {{"in0", inputPort(width, "in0")},
                  {"in1", inputPort(width, "in1")},
                  {"out", outputPort(1, "out")}};
    unit.insensitivePorts = {"in0", "in1"};
    return unit;
  }

  ModuleSpec concatSpec(const std::string& name, const int width0, const int width1) {
    ModuleSpec unit;
    unit.name = name;
    unit.hasClock = false;
    unit.hasRst = false;
    unit.params = {{"IN0_WIDTH", to_string(width0)},
                   {"IN1_WIDTH", to_string(width1)}};
    unit.ports = {{"in0", inputPort(width0, "in0")},
                  {"in1", inputPort(width1, "in1")},
                  {"out", outputPort(width0 + width1, "out")}};
    unit.insensitivePorts = {"in0", "in1"};
    return unit;
  }
  
  ModuleSpec binopSpec(const std::string& name, const int width) {
    ModuleSpec unit;
    unit.name = name;
    unit.hasClock = false;
    unit.hasRst = false;
    unit.params = {{"WIDTH", to_string(width)}};
    unit.ports = {{"in0", inputPort(width, "in0")},
                  {"in1", inputPort(width, "in1")},
                  {"out", outputPort(width, "out")}};
    unit.insensitivePorts = {"in0", "in1"};
    return unit;
  }
  
  ModuleSpec unopSpec(const std::string& name, const int width) {
    ModuleSpec unit;
    unit.name = name;
    unit.hasClock = false;
    unit.hasRst = false;
    unit.params = {{"WIDTH", to_string(width)}};
    unit.ports = {{"in", inputPort(width, "in0")},
                  {"out", outputPort(width, "out")}};
    unit.insensitivePorts = {"in"};
    return unit;
  }

  PortController& makeNot(const int width, MicroArchitecture& arch) {
    string eqName = arch.uniqueName("notOp");
    ModuleSpec eqSpec = unopSpec("notOp", width);
    FunctionalUnit& unit = arch.makeUnit(eqName, eqSpec);

    assert(unit.instName == eqName);
    
    arch.addPortController(unit);
    return arch.portController(unit.instName);
    
  }
  
  PortController& makeEquals(const int width, MicroArchitecture& arch) {
    string eqName = arch.uniqueName("eq");
    ModuleSpec eqSpec = comparatorSpec("eq", width);
    FunctionalUnit& unit = arch.makeUnit(eqName, eqSpec);
    assert(unit.instName == eqName);
    //cout << "Adding controller " << unit.instName << endl;
    
    arch.addPortController(unit);
    // cout << "After adding controller" << endl;
    // for (auto& c : arch.portControllers) {
    //   cout << tab(1) << c.second.functionalUnit().instName << endl;
    // }
    return arch.portController(unit.instName);
  }

  PortController& makeConcat(const int width0,
                             const int width1,
                             MicroArchitecture& arch) {
    string eqName = arch.uniqueName("concat");
    ModuleSpec eqSpec = concatSpec("concat", width0, width1);
    FunctionalUnit& unit = arch.makeUnit(eqName, eqSpec);
    assert(unit.instName == eqName);
    
    arch.addPortController(unit);
    return arch.portController(unit.instName);
  }
  
  PortController& makeOr(const int width, MicroArchitecture& arch) {
    string eqName = arch.uniqueName("orOp");
    ModuleSpec eqSpec = binopSpec("orOp", width);
    FunctionalUnit& unit = arch.makeUnit(eqName, eqSpec);

    assert(unit.instName == eqName);
    
    arch.addPortController(unit);
    return arch.portController(unit.instName);
  }
  
  PortController& makeAnd(const int width, MicroArchitecture& arch) {
    string eqName = arch.uniqueName("andOp");
    ModuleSpec eqSpec = binopSpec("andOp", width);
    FunctionalUnit& unit = arch.makeUnit(eqName, eqSpec);

    assert(unit.instName == eqName);
    
    arch.addPortController(unit);
    return arch.portController(unit.instName);
  }
  
  Wire checkEqual(const int value, const Wire w, MicroArchitecture& arch) {
    Wire valWire = constWire(w.width, value);
    PortController& controller = makeEquals(w.width, arch);
    controller.setAlways("in0", valWire);
    controller.setAlways("in1", w);

    //cout << "Creating equals functional unit = " << controller.functionalUnit() << endl;
    return controller.functionalUnit().outputWire();
  }

  Wire checkNotWire(const Wire in, MicroArchitecture& arch) {
    PortController& controller = makeNot(in.width, arch);
    controller.setAlways("in", in);

    return controller.functionalUnit().outputWire();
  }

  Wire concatWires(const Wire in0, const Wire in1, MicroArchitecture& arch) {
    PortController& controller = makeConcat(in0.width, in1.width, arch);
    controller.setAlways("in0", in0);
    controller.setAlways("in1", in1);

    return controller.functionalUnit().outputWire();
  }
  
  Wire checkAnd(const Wire in0, const Wire in1, MicroArchitecture& arch) {

    if (in0.width != in1.width) {
      cout << "Error: in checkAnd, " << in0.valueString() << " has width " << in0.width << ", " << in1.valueString() << " has width " << in1.width << endl;
      assert(in0.width == in1.width);      
    }
    
    PortController& controller = makeAnd(in0.width, arch);
    controller.setAlways("in0", in0);
    controller.setAlways("in1", in1);

    //cout << "Creating equals functional unit = " << controller.functionalUnit() << endl;
    return controller.functionalUnit().outputWire();
  }

  Wire checkOr(const Wire in0, const Wire in1, MicroArchitecture& arch) {
    assert(in0.width == in1.width);
    PortController& controller = makeOr(in0.width, arch);
    controller.setAlways("in0", in0);
    controller.setAlways("in1", in1);

    //cout << "Creating equals functional unit = " << controller.functionalUnit() << endl;
    return controller.functionalUnit().outputWire();
  }
  
  void PortController::setCond(const std::string& port, const Wire& condition, const Wire& value) {
    //cout << "Looking for port " << port << endl;
    string portName = functionalUnit().inputWire(port);

    // cout << "Input controllers for " << functionalUnit() << endl;
    // for (auto& ic : inputControllers) {
    //   cout << tab(1) << ic.first << endl;
    // }
    //assert(contains_key(portName, inputControllers));
    inputControllers[portName].portVals[condition] = value;
  }

  Wire MicroArchitecture::isActiveBlockVar(const StateId state,
                                           llvm::BasicBlock* const bb) {
    if (elem(bb, blocksInState(state, stg))) {
      std::string activeUnit =
        "bb_" + std::to_string(cs.getBasicBlockNo(bb)) + "_active_in_state_" + to_string(state);

      return portController(activeUnit).functionalUnit().outputWire();
    } else {
      return constWire(1, 0);
    }
    
  }

  bool jumpToSameState(BasicBlock* const predecessor,
                       BasicBlock* const successor,
                       MicroArchitecture& arch) {
    if ((predecessor != successor) &&
        (arch.stg.blockStartState(successor) == arch.stg.blockEndState(predecessor))) {

      StateId state = arch.stg.blockStartState(successor);
      // Check if predecessor precedes successor
      if (blockPrecedesInState(predecessor,
                               successor,
                               state,
                               arch)) {
        return true;
      } else {

        
        return false;
      }

    }

    return false;
  }

  Wire blockActiveInState(const StateId state,
                          BasicBlock* const blk,
                          MicroArchitecture& arch) {
    Wire atBlock =
      arch.isActiveBlockVar(state, blk);
    Wire atBranchState =
      atStateWire(state, arch);
    Wire atContainerPos =
      checkAnd(atBlock, atBranchState, arch);

    return atContainerPos;
  }

  void addBlockJump(BasicBlock* src,
                    BasicBlock* destBlock,
                    const Wire jumpHappened,
                    MicroArchitecture& arch) {
    StateId brStart = arch.stg.instructionEndState(src->getTerminator());
    StateId brEnd = arch.stg.blockStartState(destBlock);

    if (!jumpToSameState(src, destBlock, arch)) {
      auto& nextBlockController = nextBBController(brEnd, arch);
    
      if (isPipelineState(brStart, arch.pipelines) &&
          !isPipelineState(brEnd, arch.pipelines)) {
        cout << "Adding block transition for out of pipeline jump from " << brStart << " to " << brEnd << endl;
        auto p = getPipeline(brStart, arch.pipelines);

        // TODO: Uniquify this name
        RegController& outOfPipeJumpHappened =
          arch.getController(wire(1, "out_of_pipe_bb_" + to_string(brStart) + "_" + to_string(brEnd)));
        outOfPipeJumpHappened.resetValue = "0";
        outOfPipeJumpHappened.values[jumpHappened] = constWire(1, 1);

        Wire exitNextCycle =
          checkAnd(p.inPipeWire(), pipelineClearOnNextCycleCondition(p, arch), arch);

        nextBlockController.values[checkAnd(exitNextCycle, outOfPipeJumpHappened.reg, arch)] =
          constWire(32, arch.cs.getBasicBlockNo(destBlock));
      } else {
        cout << "Adding block transition from " << brStart << " to " << brEnd << endl;
        // Jump that is not between pipelines
        nextBlockController.values[jumpHappened] =
          constWire(32, arch.cs.getBasicBlockNo(destBlock));
      }
    }
  }

  // The predecessor wires check the predecessor of a block
  // in the same state?
  void buildPredecessorBlockWires(MicroArchitecture& arch) {

    Function* f = arch.stg.getFunction();

    for (auto st : arch.stg.opStates) {
      StateId state = st.first;

      // Add last basic block wires
      //for (auto& bb : f->getBasicBlockList()) {
      for (auto blk : blocksInState(state, arch.stg)) {
        
        int thisBlkNo = arch.cs.getBasicBlockNo(blk);
        //string w = "bb_" + to_string(thisBlkNo) + "_predecessor";
        string w = "bb_" + to_string(thisBlkNo) + "_predecessor_in_state_" + to_string(state);
        addPortController(w, 32, arch);

        PortController& predController = arch.portController(w);

        Wire nextBlkIsThisBlk =
          // NOTE: Im not clear on whether this is the right structure for a
          // system where each state has its own entryBlock and lastBlock variables
          checkEqual(thisBlkNo, nextBBReg(state, arch), arch);
        //predController.setCond("in_data", nextBlkIsThisBlk, wire(32, "last_BB_reg"));

        // If the current block is the entry block of the current state then the
        // predecessor is the value stored in lastBBReg
        predController.setCond("in_data", nextBlkIsThisBlk, lastBBReg(state, arch));

        for (auto* pred : predecessors(blk)) {
          if (jumpToSameState(pred, blk, arch)) {

            int predNo = arch.cs.getBasicBlockNo(pred);

            Wire edgeTaken = map_find({pred, blk}, arch.edgeTakenWires);
            predController.setCond("in_data", checkAnd(checkNotWire(nextBlkIsThisBlk, arch), edgeTaken, arch), constWire(32, predNo));          
          }
        }
      }
    }
  }

  void buildReturnBlockTransitions(MicroArchitecture& arch) {
    for (auto st : arch.stg.opStates) {
      StateId state = st.first;
      for (auto blk : terminatingBlocks(state, arch.stg)) {
        if (ReturnInst::classof(blk->getTerminator())) {
          Wire thisBlkActive = blockActiveInState(state, blk, arch);
          // If the a return statement executes in a given block
          // then if there is not default behavior set the next block
          // to be the current block.

          if (!arch.stg.sched.hasReturnDefault()) {
            nextBBController(state, arch).values[thisBlkActive] =
              constWire(32, arch.cs.getBasicBlockNo(blk));
          }
        }
      }
    }
  }
  
  // Now: Many errors in valid computation. Not sure why?
  // Hyp: In the return state the next basic block is not getting set
  // to be the current block?
  void buildBasicBlockEnableLogic(MicroArchitecture& arch) {
    Function* f = arch.stg.getFunction();

    //for (auto& bb : f->getBasicBlockList()) {
    for (auto st : arch.stg.opStates) {
      StateId state = st.first;
      string lastName = "state_" + to_string(state) + "_last_BB_reg";
      arch.addController(lastName, 32);
      arch.lastBBWires.insert({state, arch.getController(lastName).reg});

      string entryName = "state_" + to_string(state) + "_entry_BB_reg";
      arch.addController(entryName, 32);
      arch.getController(entryName).resetValue =
        to_string(arch.cs.getBasicBlockNo(&(f->getEntryBlock())));
      arch.entryBBWires.insert({state, arch.getController(entryName).reg});
      
    }

    // // TODO: Change to state by state controllers
    // arch.addController("global_next_block", 32);
    // arch.getController("global_next_block").resetValue =
    //   to_string(arch.cs.getBasicBlockNo(&(f->getEntryBlock())));

    // Maybe the thing to do here is to create branch taken
    // wires in this loop as well. Assign them to the variables
    // I already have, and then wire them up to port controllers
    // in a subsequent loop?
    
    //for (auto& bb : f->getBasicBlockList()) {

    cout << "Adding happened in state logic" << endl;

    for (auto st : arch.stg.opStates) {
      StateId state = st.first;

      cout << "Adding happened for state " << state << endl;
      for (auto blk : blocksInState(state, arch.stg)) {
        //cout << "Adding happened for blk " << valueString(blk) << endl;

        int blkNo = arch.cs.getBasicBlockNo(blk);
        auto blkString = to_string(blkNo);

        string name = "bb_" + blkString + "_active_in_state_" + to_string(state);
        addPortController(name, 1, arch);        

        cout << "Added controller controller for " << name << endl;
        
      }
    }

    for (auto st : arch.stg.opStates) {
      StateId state = st.first;

      cout << "Adding happened for state " << state << endl;
      for (auto blk : blocksInState(state, arch.stg)) {
        cout << "Adding happened for blk " << valueString(blk) << endl;

        int blkNo = arch.cs.getBasicBlockNo(blk);
        auto blkString = to_string(blkNo);

        TerminatorInst* term = blk->getTerminator();

        // string name = "bb_" + blkString + "_active_in_state_" + to_string(state);
        // addPortController(name, 1, arch);        
        // cout << "Added controller controller for " << name << endl;
        
        if (BranchInst::classof(term)) {
          BranchInst* br = dyn_cast<BranchInst>(term);

          StateId branchEndState = arch.stg.instructionEndState(br);


          Wire atContainerPos =
            blockActiveInState(branchEndState, br->getParent(), arch);

          Wire notStalled = constWire(1, 1);
          atContainerPos = checkAnd(atContainerPos, notStalled, arch);

          string hName = "br_" + blkString + "_happened_in_state_" + to_string(state);
          auto& happenedController = addPortController(hName, 1, arch);
          happenedController.setCond("in_data", atContainerPos, constWire(1, 1));
          happenedController.setCond("in_data", checkNotWire(atContainerPos, arch), constWire(1, 0));
          
          if (!(br->isConditional())) {
            BasicBlock* destBlock = br->getSuccessor(0);
            arch.edgeTakenWires.insert({{br->getParent(), destBlock}, atContainerPos});

            addBlockJump(blk, destBlock, wireValue(hName, arch), arch);
          } else {

            Value* condition = br->getOperand(0);

            StateId brEndState = arch.stg.instructionEndState(br);
            ControlFlowPosition pos =
              position(brEndState, br, arch);
          
            Wire condValue = outputWire(condition, pos, arch);

            Wire trueTaken = checkAnd(atContainerPos, condValue, arch);
            Wire falseTaken =
              checkAnd(atContainerPos, checkNotWire(condValue, arch), arch);

            BasicBlock* trueSucc = br->getSuccessor(0);
            arch.edgeTakenWires.insert({{br->getParent(), trueSucc}, trueTaken});

            BasicBlock* falseSucc = br->getSuccessor(1);
            arch.edgeTakenWires.insert({{br->getParent(), falseSucc}, falseTaken});

            addBlockJump(blk, trueSucc, trueTaken, arch);
            addBlockJump(blk, falseSucc, falseTaken, arch);                    
          }
        }
      }
    }

    cout << "Adding active in state logic" << endl;
    // There is an extra issue here: what if
    // the last basic block in the trace that is active
    // in state S is not a block that does not have its terminator
    // in state S?
    //for (auto& bb : f->getBasicBlockList()) {
    for (auto st : arch.stg.opStates) {
      StateId state = st.first;
      for (auto blk : blocksInState(state, arch.stg)) {
        int blkNo = arch.cs.getBasicBlockNo(blk);
        auto blkString = to_string(blkNo);


        Wire nextBBIsThisBlock =
          checkEqual(blkNo, nextBBReg(state, arch), arch);
        for (auto val : arch.edgeTakenWires) {
          BasicBlock* predecessor = val.first.first;
          BasicBlock* successor = val.first.second;
          Wire edgeTaken = val.second;

          if (successor == blk) {
            if (jumpToSameState(predecessor, successor, arch)) {
              nextBBIsThisBlock =
                checkOr(nextBBIsThisBlock, edgeTaken, arch);
            }
          }
        }

        string name = "bb_" + blkString + "_active_in_state_" + to_string(state);

        cout << "Getting controller for " << name << endl;
        
        PortController& activeController = arch.portController(name);

        cout << "Got active controller for " << name << endl;

        
        PortValues& vals =
          activeController.inputControllers[activeController.onlyInput().name];
        vals.portVals[constWire(1, 1)] = nextBBIsThisBlock;
      }
    }

    for (auto st : arch.stg.opStates) {
      StateId state = st.first;
      for (auto blk : nonTerminatingBlocks(state, arch.stg)) {

        if (isPipelineState(state, arch.pipelines) ==
            isPipelineState(state + 1, arch.pipelines)) {

          Wire thisBlkActive = blockActiveInState(state, blk, arch);
          // If a block is active that does not execute its terminator, then
          // the in the next cycle we continue to execute that block
          nextBBController(state, arch).values[thisBlkActive] =
            constWire(32, arch.cs.getBasicBlockNo(blk));
        }
      }
    }

    buildReturnBlockTransitions(arch);
    buildPredecessorBlockWires(arch);
  }

  void buildAtStateWires(MicroArchitecture& arch) {
    for (auto st : arch.stg.opStates) {
      Wire w = buildAtStateWire(st.first, arch);
      arch.atStateWires[st.first] = w;
    }

    for (auto p : arch.pipelines) {
      Wire w = buildAtStateWire(p.stateId, arch);
      arch.atStateWires[p.stateId] = w;
    }
  }
  
  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<llvm::Value*, int>& memMap,
                         HardwareConstraints& hcs) {

    auto f = stg.getFunction();

    // TODO: Remove this duplicated function
    map<BasicBlock*, int> basicBlockNos = stg.basicBlockNos;
    //numberBasicBlocks(f);
    cout << "--- Basic block numbers" << endl;
    for (auto p : basicBlockNos) {
      cout << tab(1) << "Basic block" << endl;
      cout << valueString(p.first) << endl;
      cout << "has number " << p.second << endl;
    }

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
    for (auto& unit : unitAssignment) {
      arch.functionalUnits.push_back(unit.second);
    }

    buildAtStateWires(arch);
    buildBasicBlockEnableLogic(arch);    
    buildPortControllers(arch);
    emitPipelineValidChainBlock(arch);
    emitPipelineRegisterChains(arch);
    emitPipelineInitiationBlock(arch);
    emitControlCode(arch);    

    return arch;
  }  

  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         HardwareConstraints& hcs) {

    map<llvm::Value*, int> memMap;
    auto f = stg.getFunction();
    for (int i = 0; i < (int) f->arg_size(); i++) {
      auto& arg = *(f->arg_begin() + i);
      string name = arg.getName();
      assert(contains_key(name, memoryMap));

      memMap[dyn_cast<Value>(&arg)] = map_find(name, memoryMap);
    }

    return buildMicroArchitecture(stg, memMap, hcs);
  }

  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<std::string, int>& memoryMap) {

    HardwareConstraints hcs;
    return buildMicroArchitecture(stg, memoryMap, hcs);
  }

  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<llvm::Value*, int>& memoryMap) {

    HardwareConstraints hcs;
    return buildMicroArchitecture(stg, memoryMap, hcs);
  }
  
  Wire inAnyPipeline(MicroArchitecture& arch) {
    Wire inAnyPipe = constWire(1, 0);
    for (auto& p : arch.pipelines) {
      inAnyPipe = checkOr(inAnyPipe, p.inPipeWire(), arch);
    }

    return inAnyPipe;
  }

  // void emitPipelineResetBlock(MicroArchitecture& arch) {

  //   for (auto p : arch.pipelines) {

  //     for (auto validVar : p.valids) {
  //       arch.getController(validVar).resetValue = "0";
  //     }
  //   }
  // }

  void
  emitPipelineInitiationBlock(MicroArchitecture& arch) {

    auto& pipelines = arch.pipelines;

    for (auto p : pipelines) {
      int stage = p.II() - 1;
      StateId st = p.stateForStage(stage);

      std::map<llvm::Value*, int> memMap;

      assert(Instruction::classof(p.getExitCondition()));
      ControlFlowPosition pos =
        pipelinePosition(dyn_cast<Instruction>(p.getExitCondition()), p.stateForStage(p.II() - 1), p.II() - 1);

      Wire testCond = outputWire(p.getExitCondition(), pos, arch);
      auto br = p.getExitBranch();

      auto trueBlock = br->getSuccessor(0);
      BasicBlock* pBlock = p.getEntryBlock();

      // Does a true value in the branch conditional imply doing another iteration
      // of the loop
      if (trueBlock == pBlock) {
        testCond = checkNotWire(testCond, arch);
      }

      RegController& cont =
        arch.getController(entryStateActiveWire(p));
      Wire atSt = atStateWire(st, arch);
      

      cont.values[checkAnd(atSt, testCond, arch)] = constWire(1, 0);
      cont.values[checkAnd(atSt, checkNotWire(testCond, arch), arch)] = constWire(1, 1);
      cont.values[checkAnd(checkNotWire(atSt, arch), p.inPipeWire(), arch)] = constWire(1, 0);
    }

  }

  void emitPipelineRegisterChains(MicroArchitecture& arch) {
    for (auto p : arch.pipelines) {
      for (map<Instruction*, Wire>& regMap : p.pipelineRegisters) {
        for (auto iReg : regMap) {
          arch.addController(iReg.second.name, iReg.second.width);
        }
      }
    }

    for (auto p : arch.pipelines) {

      for (int i = 0; i < ((int) p.pipelineRegisters.size()) - 1; i++) {

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
            arch.getController(next).values[constWire(1, 1)] = current;
          }
        }
        
      }

      for (auto instrS : p.pipelineRegisters.back()) {
        Instruction* i = instrS.first;
        if (needsTempStorage(i, arch)) {
          arch.getController(map_find(i, arch.names)).values[constWire(1, 1)] =
            instrS.second;
        }
      }
    }
  }
  
  void emitPipelineValidChainBlock(MicroArchitecture& arch) {
    auto pipelines = arch.pipelines;

    for (auto p : arch.pipelines) {

      for (auto validVar : p.valids) {
        arch.getController(validVar).resetValue = "0";
      }
    }
    
    for (auto p : pipelines) {

      for (int i = 0; i < ((int) p.valids.size()) - 1; i++) {
        arch.getController(p.valids[i + 1]).values[constWire(1, 1)] =
          p.valids[i];
      }
    }
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

      for (auto st : p.getStates()) {
        string jStr = to_string(st);
        
        ep.valids.push_back(Wire(true, 1, "pipeline_stage_" + jStr + "_valid"));

        assert(st >= 0);

        map<Instruction*, Wire> regs;
        for (auto val : pastValues) {
          regs[val] = Wire(true, getValueBitWidth(val), string("pipeline_") + val->getOpcodeName() + "_" + iStr + "_" + jStr + "_" + to_string(regNum));
          regNum++;
        }

        for (auto instrG : stg.instructionsFinishingAt(st)) {
          Instruction* i = instrG;
          if (hasOutput(i)) {          
            regs[i] = Wire(true, getValueBitWidth(i), string("pipeline_") + i->getOpcodeName() + iStr + "_" + jStr + "_" + to_string(regNum));
            pastValues.insert(i);
            regNum++;
          }
        }

        pipelineRegisters.push_back(regs);
      }

      bool foundTerm = false;
      for (auto st : p.getStates()) {
        for (auto instrG : stg.instructionsFinishingAt(st)) {
          if (BranchInst::classof(instrG)) {
            foundTerm = true;
            ep.exitBranch = instrG;
            break;
          }
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

}
