#include "microarchitecture.h"

#include "utils.h"

#include <llvm/IR/Dominators.h>
#include <llvm/IR/CFG.h>
#include <llvm/Analysis/CFG.h>
#include <llvm/Analysis/OrderedBasicBlock.h>

#include <fstream>

using namespace dbhc;
using namespace llvm;
using namespace std;

// Simple system TODO: Add valid time tests in TestBenchSpec

// Yet another issue with default state transitions, this time the problem
// is default transitions from one loop to another inside a successive loop pipeline.
// It seems as though the problem is that the default transitions used to
// guarantee that the pipeline waits on stores are also default transitioning
// in to the state that contains the next loop body in sequential execution.
// Inlining of stores in to a group of instructions with no delineated end
// makes it hard for me to just add the directive that the default transitions
// should stop at the end of the block, because that block does not stop at the end
// of the store?

// It seems as though the default schedule of this pipeline produces
// overlapping state visits, though Im not sure if I see that in the state
// transition code. It is ok for pipelined states to contain multiple branches,
// but if a basic block is pipelined, with its branch possibly going to a subsequent
// block in the pipeline then that subsequent block must be scheduled separately
// since it cannot have multiple blocks active at a time.
// OR: I could allow states to activate from multiple sources as long as
// the basic blocks connecting them could never overlap
// OR: I could set basic blocks in a pipeline to finish before another block
// starts, due to branch movement this wouldnt force sequential execution, but
// would avoid state overlap. The problem is that it would force small blocks
// to be split across states when that really is not needed.
// OR: I could add some real hazard resolution that would distinguish between
// states where operations are actually happening and wait times between operations
// with side effects

// Hazard resolution is now the big problem. It shows up first because
// of the outer loop pipelines need to wait one cycle before reading.
// This may not be the only problem with the outer loop pipeline, but it is
// one problem

// Issues:
//   1. Hazard resolution / empty states
//   2. More versatile datapath (FIFOs as connectors, buffers etc)
//   3. Task parallelism

// Hazards are tricky for a few reasons
//   1. Scheduling code contains many versions of the same function
//   2. Scheduling analyses use an LLVM pass to generate data structures
//   3. ExecutionConstraints and SchedulingProblem are very similar but used
//      in several places
//   4. Even though I have two different constraint data structures I do not
//      have an explicit way to represent different kinds of hazards.
///  5. Inlining breaks up the instructions that create some types of hazards so
//      that they are not as easy to find in the translation

// Q: Could I look through execution constraints after the fact and find
//    constraints that could be violated by pipeline scheduling?
// A: The fact that a branch is pipelined means that the state number gap
//    between read valid and write does not necessarily correspond to a delay
//    in cycles between the two?
//    How can I tell if a state gap between instructions is actually important
//    to the correct execution of a program? Treat state ids as both states and
//    times? For each branch compute the actual execution time of branches and then
//    check whether the trace matches?

// Note: Maybe static hazards can be resolved in constraint solving by pushing
// the branch forward in the schedule (higher II?). Could say that the *time*
// difference between actions in different basic blocks of the same pipeline
// is not the same as the difference in states. It is the min of the difference
// between the branch connecting b0 and b1, and the value of b1

// Assumption in Cong / Zhang:
// Time from blk y: [i0; br x;] to blk x: [i1]; is:
//   time from end(i0) to end(br x) + time from start(blk x) to i1?

// timediff(i0, i1) is starttime(i0) - starttime(i1)
// Start time relative to the start of dominator block of i1?
// Unpipelined: starttime(i0) == stateNumber(i0) - starttime(blky)?
// 

namespace ahaHLS {

  Wire getLastStateReg(const StateId state, MicroArchitecture& arch);
  
  ModuleSpec binopSpec(const std::string& name, const int width);
  
  PortController& makePlus(const int width, MicroArchitecture& arch) {
    string eqName = arch.uniqueName("add");
    ModuleSpec eqSpec = binopSpec("add", width);
    FunctionalUnit& unit = arch.makeUnit(eqName, eqSpec);

    assert(unit.instName == eqName);
    
    arch.addPortController(unit);
    return arch.portController(unit.instName);
  }
  
  Wire plusWire(const Wire in0, const Wire in1, MicroArchitecture& arch);
  Wire plusWire(const Wire in0, const Wire in1, MicroArchitecture& arch) {
    if (in0.width != in1.width) {
      cout << "Error: in plusWire, " << in0.valueString() << " has width " << in0.width << ", " << in1.valueString() << " has width " << in1.width << endl;
      assert(in0.width == in1.width);      
    }
    
    PortController& controller = makePlus(in0.width, arch);
    controller.setAlways("in0", in0);
    controller.setAlways("in1", in1);

    return controller.functionalUnit().outputWire();
  }
  
  void setDefaultValue(RegController& c, const Wire defaultValue, MicroArchitecture& arch);
  
  Wire buildCounter(const Wire resetCond,
                    const int width,
                    MicroArchitecture& arch) {
    // What should the counter be?
    //   1. Register with reset value 0, defaults to itself + 1?

    string name = arch.uniqueName("counter_");
    arch.addController(name, width);
    RegController& rc = arch.getController(name);
    rc.resetValue = "0";
    rc.values[resetCond] = constWire(width, 0);
    
    Wire output = rc.reg;

    setDefaultValue(rc, plusWire(output, constWire(width, 1), arch), arch);

    return output;
  }
  
  Wire checkEqual(const Wire valWire, const Wire w, MicroArchitecture& arch);
  
  Wire checkOr(const Wire in0, const Wire in1, MicroArchitecture& arch);
  
  void addBlockJump(BasicBlock* src,
                    BasicBlock* destBlock,
                    const Wire jumpHappened,
                    MicroArchitecture& arch);
  
  Wire lastBlockActiveInState(const StateId st,
                              BasicBlock* const bb,
                              MicroArchitecture& arch);
  
  PortController& makeConcat(const int width0,
                             const int width1,
                             MicroArchitecture& arch);
  Wire concatWires(const Wire in0, const Wire in1, MicroArchitecture& arch);

  Wire stateActiveReg(const StateId state, MicroArchitecture& arch) {
    return reg(1, "state_" + to_string(state) + "_is_active");
  }

  RegController& stateActiveRegController(const StateId state,
                                          MicroArchitecture& arch) {
    return arch.getController(stateActiveReg(state, arch));
  }

  Wire buildLastStateWire(const StateId state,
                          MicroArchitecture& arch) {
    string name = "state_" + to_string(state) + "_last_state";
    Wire w = reg(32, name);
    arch.addController(name, 32);

    return w;
  }
  
  Wire buildAtStateWire(const StateId state, MicroArchitecture& arch) {
    if (arch.isPipelineState(state)) {
      // auto p = arch.getPipeline(state);
      // Wire active = checkAnd(p.inPipeWire(), p.stateIsActiveWire(state), arch);
      // return active;

      return stateActiveReg(state, arch);
      //return active;
      
    } else {
      // TODO: This will need to become a check on the value of the
      // state is active register
      //Wire active = checkEqual(state, arch.cs.getGlobalState(), arch);
      Wire active = stateActiveReg(state, arch); //checkEqual(state, arch.cs.getGlobalState(), arch);
      return active;
    }
  }

  Wire atStateWire(const StateId state, MicroArchitecture& arch) {
    //cout << "Getting wire for " << state << endl;
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
        //cout << "Integer port name = " << name << endl;
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
      //cout << "No source for " << instructionString(instr) << endl;
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
        //cout << "&&&& Memory unit Using unit " << memSrc << " for " << instructionString(instr) << endl;
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
          //cout << "Setting " << valueString(memVal) << " to " << name << endl;
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

          //cout << "Functional unit type = " << typeString(fuTp) << endl;
          assert(PointerType::classof(fuTp));

          Type* fuDerefTp = dyn_cast<PointerType>(fuTp)->getElementType();

          assert(StructType::classof(fuDerefTp));

          StructType* structT = dyn_cast<StructType>(fuDerefTp);

          //cout << "Struct name = " << string(structT->getName()) << endl;

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

  Wire mostRecentStorageLocation(Instruction* result,
                                 ControlFlowPosition& currentPosition,
                                 MicroArchitecture& arch) {
    

    //cout << "Getting most recent location of " << valueString(result) << " for instruction " << valueString(currentPosition.instr) << endl;

    StateId currentPos = currentPosition.stateId();

    if (contains_key(currentPos, arch.dp.stateDataInputs)) {
      auto& stateInputs = arch.dp.stateDataInputs[currentPos];

      if (contains_key(result, stateInputs.values)) {
        return arch.dp.stateDataInputs[currentPos].values[result];
      } else {
        cout << "Error: Could not find temp storage for " << valueString(result) << " from position " << valueString(currentPosition.instr) << endl << ", state " << currentPos << " has inputs " << endl;
        for (auto in : stateInputs.values) {
          cout << tab(1) << valueString(in.first) << " -> " << in.second.valueString() << endl;
        }
        assert(false);
      }
    } else {
      assert(false);
    }

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
    }
  }

  // This is a duplicate?
  string dataOutput(llvm::Instruction* instr0, const MicroArchitecture& arch) {
    return dataOutputWire(instr0, arch).valueString();
  }

  Wire outputWire(Value* val,
                  ControlFlowPosition& currentPosition,
                  MicroArchitecture& arch) {
    
    //cout << "Getting name of " << valueString(val) << endl;
    Instruction* instr = currentPosition.instr;
    //cout << "In instruction " << valueString(instr) << endl;
    
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
              Wire liveWire = dataOutputWire(instr0, arch);
              
              if (!contains_key(argBB, entryToLevels.second)) {
                Wire storedWire = mostRecentStorageLocation(instr0, currentPosition, arch);
                
                controller.setCond("in_data", enteredThisBlk, storedWire);
              } else {
                int userLevel = map_find(userBB, entryToLevels.second);
                int definedLevel = map_find(argBB, entryToLevels.second);

                if (userLevel > definedLevel) {
                  controller.setCond("in_data", enteredThisBlk, liveWire);
                } else {
                  Wire storedWire = mostRecentStorageLocation(instr0, currentPosition, arch);                  
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
          //cout << "Module spec for " << valueString(val) << " is " << mSpec << endl;
          assert(mSpec.name == "register");

          // Pointer arguments that are not included in the memory map
          // are assumed to be registers
          Type* under = dyn_cast<PointerType>(val->getType())->getElementType();
          return wire(getTypeBitWidth(under), string(val->getName()) + "_rdata");
        }
      } else {
        //cout << "Value argument of type " << typeString(val->getType()) << endl;
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
        s = checkAnd(s, checkNotWire(stateActiveReg(state, arch), arch), arch);
      }
    }

    return s;
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
  
  Wire entryStateActiveWire(const ElaboratedPipeline& p, MicroArchitecture& arch) {
    return stateActiveReg(entryState(p), arch);
  }
  
  void addStateTransition(const StateId state,
                          const StateId dest,
                          Wire jumpCond,
                          MicroArchitecture& arch,
                          const bool isDefault=false) {

    //cout << "Adding transition from " << state << " to " << dest << endl;

    auto& controller = arch.getController(reg(32, "global_state"));
    auto& pipelines = arch.pipelines;

    auto& lastStateController = arch.getController(getLastStateReg(dest, arch));
    lastStateController.values[jumpCond] = constWire(32, state);
    
    if (isPipelineState(state, pipelines)) {

      auto p = getPipeline(state, pipelines);

      if (isPipelineState(dest, pipelines)) {

        if (getPipeline(dest, pipelines).stateId == p.stateId) {

          StateId pipeEntry = entryState(p);
          assert(state >= pipeEntry);
        
          int timeFromPipeEntryToBranch = state - pipeEntry;
          int II = p.II();

          assert(II >= 1);

          int cyclesToWaitForHazards = (II - 1) - timeFromPipeEntryToBranch;

          RegController& exitStateActive =
            stateActiveRegController(dest, arch);
        
          if ((cyclesToWaitForHazards > 0) && !isDefault) {
            cout << "Need to wait " << cyclesToWaitForHazards << " additional cycles for hazards to resolve in transition from " << state << " to " << dest << endl;
            //assert(false);

            // What do we need to do here?
            //   1. Create a counter that resets to 0 at the entry to the current state
            //   2. Create a temporary variable to store the jumpCond wire value
            //   3. Set the final condition wire to be the and of jumpCond and counter?

            // Sanity check, should really adjust counter width
            assert(cyclesToWaitForHazards < (1024));
          
            Wire hazardCounterOutput =
              buildCounter(stateActiveReg(state, arch), 32, arch);
            Wire waitedForHazards = checkEqual(hazardCounterOutput,
                                               constWire(hazardCounterOutput.width,
                                                         cyclesToWaitForHazards),
                                               arch);

            // TODO: Generalize name to avoid overlap
            string storeName =
              arch.uniqueName("in_pipe_" + to_string(state) + "_" + to_string(dest));
            RegController& inPipeJumpHappened =
              arch.getController(wire(1, storeName));
            inPipeJumpHappened.resetValue = "0";
            // TODO: Adjust to check that we are in this state?
            inPipeJumpHappened.values[jumpCond] = constWire(1, 1);
            Wire storedJumpCond = inPipeJumpHappened.reg;
          
            Wire finalCond = checkAnd(storedJumpCond, waitedForHazards, arch);
            exitStateActive.values[finalCond] =
              constWire(1, 1);

            // Reset temp on jump
            inPipeJumpHappened.values[finalCond] = constWire(1, 0);

          } else {

            cout << "Adding immediate pipeline transition from " << state << " to " << dest << endl;
            exitStateActive.values[jumpCond] =
              constWire(1, 1);
          }

        } else {


          auto otherPipe = getPipeline(dest, pipelines);

          RegController& validController =
            arch.getController(entryStateActiveWire(otherPipe, arch));
          validController.values[jumpCond] = constWire(1, 1);
          
          controller.values[jumpCond] = constWire(32, otherPipe.stateId);

          RegController& exitStateActive =
            stateActiveRegController(dest, arch);
          exitStateActive.values[jumpCond] =
            constWire(1, 1);
          
          //assert(false);
        }
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

        RegController& exitStateActive =
          stateActiveRegController(dest, arch);
        exitStateActive.values[checkAnd(exitNextCycle, outOfPipeJumpHappened.reg, arch)] =
          constWire(1, 1);
      }

    } else {

      if (isPipelineState(dest, pipelines)) {

        auto p = getPipeline(dest, pipelines);

        RegController& validController =
          arch.getController(entryStateActiveWire(p, arch));
        validController.values[jumpCond] = constWire(1, 1);
          
        controller.values[jumpCond] = constWire(32, p.stateId);

        RegController& exitStateActive =
          stateActiveRegController(dest, arch);
        exitStateActive.values[jumpCond] =
          constWire(1, 1);

      } else {
        controller.values[jumpCond] = constWire(32, dest);

        RegController& exitStateActive =
          stateActiveRegController(dest, arch);
        exitStateActive.values[jumpCond] =
          constWire(1, 1);
      }
    }
  }

  bool instructionInProgressAt(llvm::Instruction* instr,
                               const StateId state,
                               STG& stg) {
    return elem(state, map_find(instr, stg.sched.instrTimes));
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
    //return wire(32, "global_next_block");
    return map_find(state, arch.entryBBWires);
  }

  RegController& nextBBController(const StateId state, MicroArchitecture& arch) {
    Wire bbReg = nextBBReg(state, arch);
    return arch.getController(bbReg);

    //return arch.getController(wire(32, "global_next_block"));
  }
  
  Wire lastBBReg(const StateId state, MicroArchitecture& arch) {
    //return reg(32, "last_BB_reg"); //map_find(state, arch.lastBBWires);
    return map_find(state, arch.lastBBWires);
  }

  StateId entryState(STG& stg) {
    return stg.blockStartState(&(stg.getFunction()->getEntryBlock()));
  }
  
  void emitStateCode(const StateId state,
                     MicroArchitecture& arch) {

    // Maybe I need to adjuste each jump to ensure that the correct
    // lastBB value is being used?

    // Note: Maybe need to check that the possible last jump was taken
    // and that no subsequent jumps were taken?

    for (auto transition : getOutOfStateTransitions(state, arch.stg)) {
      BasicBlock* srcBlk = transition.first;
      BasicBlock* dest = transition.second;

      Wire edgeTakenWire = map_find({srcBlk, dest}, arch.edgeTakenWires);

      CFGJump jmp{transition};
      auto outJumps = getTask(srcBlk, arch.stg);
      if (elem(jmp, getOutOfTaskJumps(outJumps, arch.stg))) {
        cout << "Adding out of task transitions" << endl;
        // Q: Will this pass with control sanity checks disabled?
        //edgeTakenWire = constWire(1, 1);
        edgeTakenWire =
          blockActiveInState(entryState(arch.stg),
                             &(arch.stg.getFunction()->getEntryBlock()),
                             arch);
      }
      
      StateId end = arch.stg.blockStartState(dest);
      addStateTransition(state, end, edgeTakenWire, arch);

      addBlockJump(transition.first, transition.second, edgeTakenWire, arch);

      RegController& lastBBController =
        arch.getController(lastBBReg(end, arch));
      lastBBController.values[edgeTakenWire] = constWire(32, arch.cs.getBasicBlockNo(srcBlk));
    }

    for (auto instr : arch.stg.instructionsFinishingAt(state)) {
      if (ReturnInst::classof(instr)) {

        StateId dest = state;
        if (arch.stg.sched.hasReturnDefault()) {
          dest = arch.stg.sched.getDefaultReturnState();
        }

        Wire condWire = blockActiveInState(state, instr->getParent(), arch);
        addStateTransition(state, dest, condWire, arch);

        RegController& lastBBController =
          arch.getController(lastBBReg(dest, arch));
        lastBBController.values[condWire] = predecessor(state, instr->getParent(), arch);
        
        // If the a return statement executes in a given block
        // then if there is not default behavior set the next block
        // to be the current block.
        if (!arch.stg.sched.hasReturnDefault()) {
          nextBBController(state, arch).values[condWire] =
            constWire(32, arch.cs.getBasicBlockNo(instr->getParent()));
        }
        
      }
    }

    // Note: If we are in a pipelined state we might have a block whose
    // terminating branch executes in this state, but which also
    // has additional unfinished data processing instructions

    for (auto blk : inProgressBlocks(state, arch.stg)) {

      //cout << "Found non terminating block in " << state << endl;

      StateId dest = state + 1;

      if (elem(blk, blocksInState(dest, arch.stg))) {
      //if (false) {
        Wire condWire = blockActiveInState(state, blk, arch);
        addStateTransition(state, dest, condWire, arch, true);

        auto& cntr = nextBBController(dest, arch);
        cntr.values[condWire] = constWire(32, arch.cs.getBasicBlockNo(blk));

        RegController& lastBBController =
          arch.getController(lastBBReg(dest, arch));
        lastBBController.values[condWire] = predecessor(state, blk, arch);
      }
    }

  }

  void setDefaultValue(RegController& c, const Wire defaultValue, MicroArchitecture& arch) {
    Wire noOtherCondTrue = constWire(1, 1);

    for (auto v : c.values) {
      noOtherCondTrue = checkAnd(checkNotWire(v.first, arch), noOtherCondTrue, arch);
    }

    c.values[noOtherCondTrue] = defaultValue;
  }
  
  // TODO: Remove resetValues field?
  void emitControlCode(MicroArchitecture& arch) {

    arch.addController("global_state", 32);
    arch.getController("global_state").resetValue =
      map_find(wire(32, "global_state"), arch.resetValues);

    for (auto state : arch.stg.opStates) {
      Wire active = stateActiveReg(state.first, arch);
      arch.addController(active.name, active.width);
    }

    RegController& startController =
      stateActiveRegController(arch.stg.blockStartState(&(arch.stg.getFunction()->getEntryBlock())), arch);
    startController.resetValue = "1";
    
    for (auto state : arch.stg.opStates) {
      emitStateCode(state.first, arch);
    }

    // Now that all state transitions have been added to the control path
    // set defaults to ensure that states that are not transitioned to in any
    // cycle will be set to 0
    for (auto state : arch.stg.opStates) {
      auto& activeController =
        stateActiveRegController(state.first, arch);
      setDefaultValue(activeController, constWire(1, 0), arch);
    }

    for (auto p : arch.pipelines) {
      PortController& pc = addPortController(p.inPipe.name, 1, arch);
      // TODO: This will need to be an "or" over the active flags for all states
      // in the pipeline

      Wire anyPipeStateActive = constWire(1, 0);
      for (auto st : p.p.getStates()) {
        anyPipeStateActive =
          checkOr(stateActiveReg(st, arch), anyPipeStateActive, arch);
      }

      pc.setAlways("in_data", anyPipeStateActive);
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

  Wire checkEqual(const Wire valWire, const Wire w, MicroArchitecture& arch) {
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

  Wire blockActiveInState(const StateId state,
                          BasicBlock* const blk,
                          MicroArchitecture& arch) {
    if (!elem(blk, blocksInState(state, arch.stg))) {
      return constWire(1, 0);
    }
    
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

    //cout << "Jump between " << brStart << " and " << brEnd << " is a jump to the same state?" << endl;    
    // if (!jumpToSameState(src, destBlock, arch)) {
    //   cout << "Jump between " << brStart << " and " << brEnd << " is not a jump to the same state?" << endl;
      auto& nextBlockController = nextBBController(brEnd, arch);
    
      if (isPipelineState(brStart, arch.pipelines) &&
          !isPipelineState(brEnd, arch.pipelines)) {
        //cout << "Adding block transition for out of pipeline jump from " << brStart << " to " << brEnd << endl;
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
        //cout << "Adding block transition for state transition " << brStart << " to " << brEnd << endl;
        // Jump that is not between pipelines
        nextBlockController.values[jumpHappened] =
          constWire(32, arch.cs.getBasicBlockNo(destBlock));
      }
    // } else {
    // }
  }

  // The predecessor wires check the predecessor of a block
  // in the same state?
  void buildPredecessorBlockWires(MicroArchitecture& arch) {

    //Function* f = arch.stg.getFunction();

    for (auto st : arch.stg.opStates) {
      StateId state = st.first;

      // Add last basic block wires
      for (auto blk : blocksInState(state, arch.stg)) {
        
        int thisBlkNo = arch.cs.getBasicBlockNo(blk);
        string w = "bb_" + to_string(thisBlkNo) + "_predecessor_in_state_" + to_string(state);
        //addPortController(w, 32, arch);

        PortController& predController = arch.portController(w);

        Wire nextBlkIsThisBlk =
          // NOTE: Im not clear on whether this is the right structure for a
          // system where each state has its own entryBlock and lastBlock variables
          checkEqual(thisBlkNo, nextBBReg(state, arch), arch);

        // If the current block is the entry block of the current state then the
        // predecessor is the value stored in lastBBReg
        predController.setCond("in_data", nextBlkIsThisBlk, lastBBReg(state, arch));

        for (auto* pred : predecessors(blk)) {
          //if (jumpToSameState(pred, blk, arch)) {
          if (elem({pred, blk}, getInStateTransitions(state, arch.stg))) {

            int predNo = arch.cs.getBasicBlockNo(pred);

            Wire edgeTaken = map_find({pred, blk}, arch.edgeTakenWires);
            predController.setCond("in_data", checkAnd(checkNotWire(nextBlkIsThisBlk, arch), edgeTaken, arch), constWire(32, predNo));          
          }
        }
      }
    }
  }

  void addBasicBlockControllers(MicroArchitecture& arch) {
    Function* f = arch.stg.getFunction();
    
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

      for (auto blk : blocksInState(state, arch.stg)) {

        int blkNo = arch.cs.getBasicBlockNo(blk);
        auto blkString = to_string(blkNo);

        string name = "bb_" + blkString + "_active_in_state_" + to_string(state);
        addPortController(name, 1, arch);        
        string w = "bb_" + to_string(blkNo) + "_predecessor_in_state_" + to_string(state);
        addPortController(w, 32, arch);
      }
      
    }

  }
  
  // TODO: Pull apart control variable declaration and the wiring
  // up of control variables
  void buildBasicBlockEnableLogic(MicroArchitecture& arch) {
    addBasicBlockControllers(arch);
    
    for (auto st : arch.stg.opStates) {
      StateId state = st.first;

      //cout << "Adding happened for state " << state << endl;
      for (auto blk : blocksInState(state, arch.stg)) {
        //cout << "Adding happened for blk " << valueString(blk) << endl;

        int blkNo = arch.cs.getBasicBlockNo(blk);
        auto blkString = to_string(blkNo);

        TerminatorInst* term = blk->getTerminator();

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
          }
        }

      }
    }

    cout << "Adding active in state logic" << endl;

    // TODO: Add defaults to basic block controllers?
    // Check that on state entry the next block is one of the contained
    // blocks in the state?
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
            //if (jumpToSameState(predecessor, successor, arch)) {
            if (elem({predecessor, successor}, getInStateTransitions(state, arch.stg))) {
              nextBBIsThisBlock =
                checkOr(nextBBIsThisBlock, edgeTaken, arch);
            }
          }
        }

        string name = "bb_" + blkString + "_active_in_state_" + to_string(state);
        PortController& activeController = arch.portController(name);
        PortValues& vals =
          activeController.inputControllers[activeController.onlyInput().name];
        vals.portVals[constWire(1, 1)] = nextBBIsThisBlock;
      }
    }

    buildPredecessorBlockWires(arch);
  }

  void buildAtStateWires(MicroArchitecture& arch) {
    for (auto st : arch.stg.opStates) {
      Wire w = buildAtStateWire(st.first, arch);
      arch.atStateWires[st.first] = w;

      Wire lastState = buildLastStateWire(st.first, arch);
      arch.lastStateWires[st.first] = lastState;
    }

    for (auto p : arch.pipelines) {
      Wire w = buildAtStateWire(p.stateId, arch);
      arch.atStateWires[p.stateId] = w;
    }
  }

  std::set<Instruction*>
  allValuesThatMayNeedStorage(Function* const f,
                              STG& stg) {
    set<Instruction*> vals;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        if (hasOutput(&instrR)) {

          Instruction* instr = &instrR;

          // If all users are in the produce state, and
          // none are PHI nodes, then we do not need this
          bool noPhiUsers = true;
          bool allInProduceState = true;

          for (auto& user : instr->uses()) {
            assert(Instruction::classof(user));
            auto userInstr = dyn_cast<Instruction>(user.getUser());

            if (PHINode::classof(userInstr)) {
              noPhiUsers = false;
              break;
            }

            if (userInstr->getParent() !=
                instr->getParent()) {
              allInProduceState = false;
              break;
            }
            
            if (stg.instructionStartState(userInstr) !=
                stg.instructionEndState(instr)) {
              allInProduceState = false;
              break;
            }
            
          }

          if (!noPhiUsers || !allInProduceState) {
            vals.insert(&instrR);
          }
        }
      }
    }
    return vals;
  }

  set<Instruction*> allDataInFunction(Function* const f) {
    set<Instruction*> vals;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        if (hasOutput(&instrR)) {
          vals.insert(&instrR);
        }
      }
    }

    return vals;
  }

  PortController& findWireController(const std::string& name,
                                     MicroArchitecture& arch) {
    for (auto& pc : arch.portControllers) {
      if (pc.second.functionalUnit().outputWire().name == name) {
        return pc.second;
      }
    }
    cout << "Error: Could not find any controller with output " << name << endl;
    assert(false);
  }

  std::set<StateId> possiblePriorStates(const StateId state, STG& stg) {
    set<StateId> states;
    states.insert(state);
    if (state > 0) {
      states.insert(state - 1);
    }

    for (auto st : stg.opStates) {
      for (auto transition : getOutOfStateTransitions(st.first, stg)) {
        StateId dest = stg.blockStartState(transition.second);
        if (dest == state) {
          states.insert(stg.instructionStartState(transition.first->getTerminator()));
        }
      }
      
      //states.insert(st.first);
    }
    return states;
  }

  Wire getLastStateReg(const StateId state, MicroArchitecture& arch) {
    return map_find(state, arch.lastStateWires);
  }

  Wire datapathValueAt(const StateId possibleLast,
                       Instruction* instr,
                       MicroArchitecture& arch) {
    auto& stateInfo = arch.dp.stateData[possibleLast];
    if (contains_key(instr, stateInfo.values)) {
      return stateInfo.values[instr];
    }

    return constWire(getValueBitWidth(instr), 0);
    
  }
  
  void buildDataPathSetLogic(MicroArchitecture& arch) {
    // What do I need to do here?
    // For each state:
    //   If the state is active: Set each worldState variable based on prior state

    Function* f = arch.stg.getFunction();
    
    for (auto st : arch.stg.opStates) {
      StateId state = st.first;

      WorldState& dataRegisters = arch.dp.stateData[state];
      WorldState& dataInputs = arch.dp.stateDataInputs[state];

      Wire lastStateWire = getLastStateReg(state, arch);

      // Build prior state wires
      map<StateId, Wire> isLastStateFlags;
      for (StateId possibleLast : possiblePriorStates(state, arch.stg)) {

        Wire atLast = checkEqual(possibleLast, lastStateWire, arch);
        isLastStateFlags[possibleLast] = atLast;
      }

      for (pair<Instruction*, Wire> valStorage : dataInputs.values) {
        Instruction* instr = valStorage.first;
        
        // TODO: Remove this name lookup hack
        string wName = dataInputs.values[instr].name;
        string ctName = wName.substr(0, wName.size() - 9);

        PortController& priorValueController =
          arch.portController(ctName);
        Wire priorValue = priorValueController.functionalUnit().outputWire();

        for (auto stP : isLastStateFlags) {
          StateId possibleLast = stP.first;
          Wire lastTriggered = stP.second;

          Wire priorData = datapathValueAt(possibleLast, instr, arch);
          priorValueController.setCond("in_data", lastTriggered, priorData);
        }
      }
      
      for (pair<Instruction*, Wire> valStorage : dataRegisters.values) {

        Instruction* instr = valStorage.first;
        
        RegController& rc = arch.getController(valStorage.second);

        Wire stateActive = atStateWire(state, arch);
        bool producedInStateVar =
          arch.stg.instructionEndState(instr) == state;

        ControlFlowPosition pos = position(state, instr, arch);

        if (producedInStateVar) {

          Wire blkActiveInState = blockActiveInState(state, instr->getParent(), arch);
          rc.values[blkActiveInState] = outputWire(instr, pos, arch);

          // Note: I think this should include a not produced in state forwarding
          // decision?
        } else {

          if (contains_key(instr, dataInputs.values)) {
            // TODO: Remove this name lookup hack
            string wName = dataInputs.values[instr].name;
            string ctName = wName.substr(0, wName.size() - 9);
            PortController& priorValueController =
              arch.portController(ctName);
            Wire priorValue = priorValueController.functionalUnit().outputWire();
          
            rc.values[stateActive] = priorValue;
          }
        }
      }
    }
  }

  bool userReachableFromState(Instruction* val,
                              const StateId state,
                              MicroArchitecture& arch) {
    bool userReachable = false;
    for (auto blk : blocksInState(state, arch.stg)) {

      // If any user of val is reachable from any block
      // in this state it must be saved
      for (auto& user : val->uses()) {
        assert(Instruction::classof(user));
        Instruction* userInstr = dyn_cast<Instruction>(user.getUser());
        BasicBlock* userBB = userInstr->getParent();

        if (isPotentiallyReachable(blk, userBB)) {
          userReachable = true;
          break;
        }
      }
      
    }

    return userReachable;
  }
  
  bool defCouldReachThisState(Instruction* val,
                              const StateId state,
                              MicroArchitecture& arch) {
    BasicBlock* defBlk = val->getParent();

    bool unreachable = true;
    for (auto blk : blocksInState(state, arch.stg)) {
      if (isPotentiallyReachable(defBlk, blk)) {
        unreachable = false;
        break;
      }
    }
    return !unreachable;
  }

  template<typename T>
  set<T> setUnion(set<T>& a, set<T>& b) {
    set<T> res;
    for (auto elem : a) {
      res.insert(elem);
    }
    for (auto elem : b) {
      res.insert(elem);
    }

    //set_union(begin(a), end(a), begin(b), end(b), begin(res));
    return res;
  }

  set<Instruction*> definedInstrs(const StateId state,
                                  MicroArchitecture& arch) {
    set<Instruction*> defined;
    for (auto instr : arch.stg.instructionsFinishingAt(state)) {
      defined.insert(instr);
    }

    return defined;
    
  }
  
  set<Instruction*> usedInstrs(const StateId state,
                               STG& stg) {
    //MicroArchitecture& arch) {
    set<Instruction*> used;
    for (auto instr : stg.instructionsStartingAt(state)) {
      for (int i = 0; i < (int) instr->getNumOperands(); i++) {
        Value* op = instr->getOperand(i);
        if (Instruction::classof(op)) {
          used.insert(dyn_cast<Instruction>(op));
        }
      }
    }

    return used;
  }

  bool precedesInOrder(BasicBlock* used,
                       BasicBlock* blk,
                       map<BasicBlock*, int> levels) {
    if (used == blk) {
      return true;
    }
    
    if (!contains_key(blk, levels)) {
      return true;
    }

    if (!contains_key(used, levels)) {
      return false;
    }

    return map_find(used, levels) < map_find(blk, levels);
  }
  
  // May be used but may not be defined in same state activation
  set<Instruction*> valuesThatMayBeUsedInState(const StateId state,
                                               STG& stg) {
    Function* f = stg.getFunction();
    DominatorTree dt(*f);

    set<Instruction*> maybeUsed;
    for (auto instr : stg.instructionsStartingAt(state)) {

      // TODO: Should check that def always precedes isntr in state topo levels
      // *and* that the definition dominates the instruction
      for (int i = 0; i < (int) instr->getNumOperands(); i++) {
        Value* op = instr->getOperand(i);
        if (Instruction::classof(op)) {
          Instruction* used = dyn_cast<Instruction>(op);
          bool alwaysDefinedBefore =
            stg.instructionEndState(used) == stg.instructionStartState(instr) &&
            dt.dominates(used, instr);

          bool appearsInAllOrders = true;
          for (auto blkAndLevels : topologicalLevelsForBlocks(state, stg)) {
            map<BasicBlock*, int>& levels = blkAndLevels.second;
            if (!precedesInOrder(used->getParent(), instr->getParent(), levels)) {
              appearsInAllOrders = false;
              break;
              
            }
            // if (!contains_key(used->getParent(), levels)) {
            //   appearsInAllOrders = false;
            //   break;
            // }
          }
          
          if (!alwaysDefinedBefore || !appearsInAllOrders) {
            maybeUsed.insert(used);
          }
        }
      }
    }

    return maybeUsed;
  }

  set<Instruction*> valuesThatAreAlwaysDefinedInState(const StateId state,
                                                      STG& stg) {
    Function* f = stg.getFunction();
    DominatorTree dt(*f);

    set<Instruction*> alwaysDefined;
    set<BasicBlock*> activeOnExit =
      activeOnExitBlocks(state, stg);

    for (auto instr : stg.instructionsFinishingAt(state)) {
      bool dominatesAllExits = true;
      for (auto possibleExit : activeOnExit) {
        auto exitTerm = possibleExit->getTerminator();
        if (!dt.dominates(instr, exitTerm)) {
          dominatesAllExits = false;
          break;
        }
      }

      bool appearsInAllOrders = true;
      for (auto blkAndLevels : topologicalLevelsForBlocks(state, stg)) {
        map<BasicBlock*, int>& levels = blkAndLevels.second;
        if (!contains_key(instr->getParent(), levels)) {
          appearsInAllOrders = false;
          break;
        }
      }

      if (dominatesAllExits && appearsInAllOrders) {
        cout << valueString(instr) << " occurs in every activation of state " << state << endl;
        alwaysDefined.insert(instr);
      }
    }

    return alwaysDefined;
  }

  class LiveVals {
  public:
    std::map<StateId, std::set<Instruction*> > in;
    std::map<StateId, std::set<Instruction*> > out;
  };
  
  //std::map<StateId, std::set<Instruction*> >
  LiveVals
  findLiveValues(MicroArchitecture& arch) {

    std::map<StateId, std::set<Instruction*> > in;
    std::map<StateId, std::set<Instruction*> > out;

    std::map<StateId, set<Instruction*> > maybeUsed;
    std::map<StateId, set<Instruction*> > alwaysDefined;


    for (auto st : arch.stg.opStates) {
      in[st.first] = {};
      out[st.first] = {};

      maybeUsed[st.first] =
        valuesThatMayBeUsedInState(st.first, arch.stg);
      alwaysDefined[st.first] =
        valuesThatAreAlwaysDefinedInState(st.first, arch.stg);
    }

    bool stable = false;
    while (!stable) {

      std::map<StateId, std::set<Instruction*> > inP = in;
      std::map<StateId, std::set<Instruction*> > outP = out;

      for (auto st : arch.stg.opStates) {
        StateId state = st.first;
        set<Instruction*> used = map_find(state, maybeUsed);
        //usedInstrs(state, arch);
        set<Instruction*> defd = map_find(state, alwaysDefined);
          //definedInstrs(state, arch);
        auto diff = difference(out[state], defd);
        set<Instruction*> uSet =
          setUnion(used, diff);
                              
        in[state] = uSet;

        set<Instruction*> newOut;

        // Needs to include predecessor states?
        for (auto jmp : getOutOfStateTransitions(state, arch.stg)) {
          StateId destState = arch.stg.blockStartState(jmp.second);
          auto succIns = in[destState];
          newOut = setUnion(newOut, succIns);
        }

        if (inProgressBlocks(state, arch.stg).size() > 0) {
          StateId destState = state + 1;
          auto succIns = in[destState];
          newOut = setUnion(newOut, succIns);
        }
        
        out[state] = newOut;
      }

      stable = true;
      for (auto st : arch.stg.opStates) {
        StateId state = st.first;
        if (inP[state].size() != in[state].size()) {
          cout << "inP size = " << inP[state].size() << endl;
          cout << "in  size = " << in[state].size() << endl;          
          stable = false;
          break;
        }

        if (outP[state].size() != out[state].size()) {
          cout << "state    = " << state << endl;
          cout << "inP size = " << inP[state].size() << endl;
          cout << "in  size = " << in[state].size() << endl;          
          
          stable = false;
          break;
        }

      }
      
    }

    cout << "Final live values" << endl;
    for (auto st : arch.stg.opStates) {
      cout << tab(1) << "-------" << endl;
      cout << tab(1) << st.first << " live in  = " << in[st.first].size() << endl;
      for (auto v : in[st.first]) {
        cout << tab(2) << valueString(v) << endl;
      }
      cout << tab(1) << st.first << " live out = " << out[st.first].size() << endl;
      for (auto v : out[st.first]) {
        cout << tab(2) << valueString(v) << endl;
      }
      
    }
    
    return {in, out};
  }
  
  void buildDataPathWires(MicroArchitecture& arch) {
    set<Instruction*> allValues = allDataInFunction(arch.stg.getFunction());

    cout << "# of values in function = " << allValues.size() << endl;
    for (auto v : allValues) {
      cout << tab(1) << valueString(v) << endl;
    }

    set<Instruction*> allValuesMayNeedStorage =
      allValuesThatMayNeedStorage(arch.stg.getFunction(), arch.stg);

    cout << "# of values in function that may need storage = " << allValuesMayNeedStorage.size() << endl;
    for (auto v : allValuesMayNeedStorage) {
      cout << tab(1) << valueString(v) << endl;
    }

    allValues = allValuesMayNeedStorage;

    LiveVals liveVals = findLiveValues(arch);
    auto liveOut = liveVals.out;
    auto liveIn = liveVals.in;   

    for (auto st : arch.stg.opStates) {
      StateId state = st.first;
      arch.dp.stateData[state] = {};
      
      for (Instruction* val : allValues) {
        //cout << "Possibly adding " << valueString(val) << endl;

        // if (defCouldReachThisState(val, state, arch) &&
        //     userReachableFromState(val, state, arch)) {

        //if (elem(val, liveVals[state])) {
        //if (userReachableFromState(val, state, arch)) {

          //if (elem(val, liveOut[state]) || elem(val, liveIn[state])) {
          if (elem(val, liveOut[state])) {
            //if (true) {
            string tmpName =
              arch.uniqueName("data_store_" + to_string(state));

            Wire tmpReg = reg(getValueBitWidth(val), tmpName);
            arch.addController(tmpReg.valueString(), tmpReg.width);
            auto& rc = arch.getController(tmpReg);
            arch.dp.stateData[state].values[val] = rc.reg;
            //}
          }
          if (elem(val, liveIn[state])) {
            // Should be all values live on input?
            string inName =
              arch.uniqueName("data_in_" + to_string(state));
            auto& pc = addPortController(inName, getValueBitWidth(val), arch);
            arch.dp.stateDataInputs[state].values[val] =
              pc.functionalUnit().outputWire();
          }
      }
      //}
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
    // cout << "--- Basic block numbers" << endl;
    // for (auto p : basicBlockNos) {
    //   cout << tab(1) << "Basic block" << endl;
    //   cout << valueString(p.first) << endl;
    //   cout << "has number " << p.second << endl;
    // }

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

    buildDataPathWires(arch);
    buildAtStateWires(arch);
    buildBasicBlockEnableLogic(arch);
    buildPortControllers(arch);
    //emitPipelineRegisterChains(arch);
    emitControlCode(arch);
    buildDataPathSetLogic(arch);

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

      pipelines.push_back(ep);

      pipeState++;
    }

    return pipelines;
  }

}
