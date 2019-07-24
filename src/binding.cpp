#include "binding.h"

#include <llvm/IR/InstIterator.h>

using namespace dbhc;
using namespace llvm;

namespace ahaHLS {

  bool HardwareConstraints::builtModSpec(llvm::Value* const val) {
    return contains_key(val, modSpecs);
  }

  void
  HardwareConstraints::bindValue(llvm::Value* const val,
                                 const ModuleSpec& spec) {
    modSpecs[val] = spec;
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
    } else if (instr->getOpcode() == Instruction::SRem) {
      modName = "sremOp";
    } else if (instr->getOpcode() == Instruction::AShr) {
      modName = "ashrOp";
    } else if (instr->getOpcode() == Instruction::LShr) {
      modName = "lshrOp";
    } else {
      assert(false);
    }
    return modName;
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

  ModuleSpec structModuleSpec(Value* instr,
                              HardwareConstraints& hcs) {
    string unitName;
    if (instr->getName() != "") {
      unitName = instr->getName();
    } else {
      unitName = sanitizeFormatForVerilogId(valueString(instr));
    }

    return hcs.getModSpec(instr);
  }

  // I want to eliminate memVal and memSrc, or at least I want
  // to make sure they are not duplicated in binding and microarchitecture
  // generation. What are they actually used for?
  //  1. 
  ModuleSpec createMemSpec(map<Value*, std::string>& memNames,
                           map<Instruction*, Value*>& memSrcs,
                           HardwareConstraints& hcs,
                           llvm::Instruction* instr) {
    assert(LoadInst::classof(instr) || StoreInst::classof(instr));
    string modName = "add";

    map<string, string> modParams;
    map<string, int> defaults;

    if (StoreInst::classof(instr)) {

      Value* memVal = map_find(instr, memSrcs);
      string memSrc = memName(instr, memSrcs, memNames);

      // If the store is a store to part of a register
      // then we need to detect that and write a masked store?
      
      if (!Argument::classof(memVal)) {
        //cout << "&&&& Memory unit Using unit " << memSrc << " for " << instructionString(instr) << endl;
        if (contains_key(memVal, hcs.memSpecs)) {
          modName = map_find(memVal, hcs.memSpecs).modSpec.name;
        } else {
          modName = "register";
        }

        int dataWidth = getValueBitWidth(instr->getOperand(0));
        modParams = {{"WIDTH", to_string(dataWidth)}};

        ModuleSpec mSpec = {modParams, modName, {}, defaults};
        mSpec.ports.insert({"raddr", inputPort(32, "raddr")});
        mSpec.ports.insert({"rdata", outputPort(dataWidth, "rdata")});
        mSpec.ports.insert({"wen", inputPort(1, "wen")});
        mSpec.ports.insert({"wdata", inputPort(dataWidth, "wdata")});
        mSpec.ports.insert({"waddr", inputPort(32, "waddr")});
        
        mSpec.defaultValues.insert({"wen", 0});
        return mSpec;
        
      } else {
        assert(hcs.builtModSpec(memVal));
        assert(memVal->getName() != "");

        return hcs.getModSpec(memVal);
      }

    } else if (LoadInst::classof(instr)) {

      //cout << "Finding memories for " << valueString(instr) << endl;
      
      Value* memVal = map_find(instr, memSrcs);          
      string memSrc = memName(instr, memSrcs, memNames);

      // If we are loading from an internal RAM, not an argument

      Value* loadArg = instr->getOperand(0);
      if (GetElementPtrInst::classof(loadArg)) {
        //assert(false);
        
        GetElementPtrInst* gep = dyn_cast<GetElementPtrInst>(loadArg);
        if (!isRAMAddressCompGEP(gep, memSrcs)) {
          int inWidth = getValueBitWidth(gep);
          modParams = {{"WIDTH", to_string(inWidth)}};
          modName = "hls_wire";

          ModuleSpec mSpec{modParams, modName, {}, defaults};
          return mSpec;
        }
      }
      
      if (!Argument::classof(memVal)) {
        if (contains_key(memVal, hcs.memSpecs)) {
          string name = map_find(memVal, hcs.memSpecs).modSpec.name;
          modName = name;
        } else {
          modName = "register";
        }
        
        int dataWidth = getValueBitWidth(instr->getOperand(0));
        modParams = {{"WIDTH", to_string(dataWidth)}};

        ModuleSpec mSpec = {modParams, modName, {}, defaults};
        mSpec.ports.insert({"raddr", inputPort(32, "raddr")});
        mSpec.ports.insert({"rdata", outputPort(dataWidth, "rdata")});
        mSpec.ports.insert({"wen", inputPort(1, "wen")});
        mSpec.ports.insert({"wdata", inputPort(dataWidth, "wdata")});
        mSpec.ports.insert({"waddr", inputPort(32, "waddr")});
        
        mSpec.defaultValues.insert({"wen", 0});
        return mSpec;
        
        
      } else {
        assert(hcs.builtModSpec(memVal));
        assert(memVal->getName() != "");
        return hcs.getModSpec(memVal);
      }

    }

    ModuleSpec mSpec = {modParams, modName, {}, defaults};
    return mSpec;
  }

  ModuleSpec buildModSpec(map<Value*, std::string>& memNames,
                          map<Instruction*, Value*>& memSrcs,
                          HardwareConstraints& hcs,
                          //ResourceUsage& usage,
                          llvm::Instruction* instr) {
    //string unitName = instr->getOpcodeName() + to_string(usage.resSuffix);
    string modName = "add";

    //auto rStr = unitName;
    map<string, string> modParams;
    bool isExternal = false;

    map<string, Wire> wiring;
    map<string, Wire> outWires;
    map<string, int> defaults;
    set<string> insensitivePorts;
    map<string, Port> allPorts;
    //cout << "Creating a unit for " << valueString(instr) << endl;

    bool hasRst = false;
    bool hasClock = false;
    
    if (LoadInst::classof(instr) || StoreInst::classof(instr)) {
      //return createMemSpec(memNames, memSrcs, hcs, usage, instr);
      return createMemSpec(memNames, memSrcs, hcs, instr);
    } else if (BinaryOperator::classof(instr)) {
      modName = binopName(instr);
      int w0 = getValueBitWidth(instr->getOperand(0));
      int w1 = getValueBitWidth(instr->getOperand(1));

      if (w0 != w1) {
        //cout << "Binops do not match widths " << valueString(instr) << endl;
      }
      assert(w0 == w1);

      //unitName = string(instr->getOpcodeName()) + "_" + rStr;

      string opCodeName = instr->getOpcodeName();
      int width = getValueBitWidth(instr);
      if (modName != "fadd") {
        modParams = {{"WIDTH", to_string(width)}};
      }

      allPorts = {{"in0", inputPort(width, "in0")},
                  {"in1", inputPort(width, "in1")},
                  {"out", outputPort(width, "out")}};
      
      // wiring = {{"in0", {true, width, opCodeName + "_in0_" + rStr}},
      //           {"in1", {true, width, opCodeName + "_in1_" + rStr}}};

      if (modName == "fadd") {
        //wiring.insert({"en", {true, 1, opCodeName + "_en_" + rStr}});
        allPorts.insert({"en", inputPort(1, "en")});
        defaults.insert({"en", 0});
      }
      //outWires = {{"out", {false, width, opCodeName + "_out_" + rStr}}};
    } else if (ReturnInst::classof(instr)) {
      isExternal = true;
      modName = "ret";

      defaults.insert({"valid", 0});
      //wiring = {{"valid", {true, 1, "valid"}}};
      allPorts.insert({"valid", inputPort(1, "valid")});

      ReturnInst* ret = dyn_cast<ReturnInst>(instr);
      if (ret->getReturnValue() != nullptr) {
        auto val = ret->getReturnValue();
        //wiring.insert({"return_value", {true, getValueBitWidth(val), "return_value"}});
        allPorts.insert({"return_valud", inputPort(getValueBitWidth(val), "return_value")});
        defaults.insert({"return_value", 0});
        insensitivePorts.insert("return_value");
      }
      //outWires = {};
          
    } else if (isBuiltinSlice(instr)) {
      modName = "sliceOp";
      int inWidth = getSliceInWidth(instr);
      int offset = getSliceOffset(instr);
      int outWidth = getSliceOutWidth(instr);

      modParams = {{"IN_WIDTH", to_string(inWidth)}, {"OUT_WIDTH", to_string(outWidth)}, {"OFFSET", to_string(offset)}};
      //wiring = {{"in", {true, inWidth, "slice_in_" + rStr}}};
      //outWires = {{"out", {false, outWidth, "slice_out_" + rStr}}};
      allPorts = {{"in", inputPort(inWidth, "in")}, {"out", outputPort(outWidth, "out")}};
      
      //cout << "Creating slice op" << endl;
      
    } else if (matchesCall("hls.min.", instr)) {
      modName = "minOp";

      int inWidth = getMinWidth(instr);

      modParams = {{"WIDTH", to_string(inWidth)}};
      //wiring = {{"in0", {true, inWidth, "min_in_" + rStr}}, {"in1", {true, inWidth, "min_in_" + rStr}}};
      //outWires = {{"out", {false, inWidth, "min_out_" + rStr}}};
      allPorts = {{"in0", inputPort(inWidth, "in0")}, {"in1", inputPort(inWidth, "in1")}, {"out", outputPort(inWidth, "out")}};
      
    } else if (matchesCall("hls.max.", instr)) {

      modName = "maxOp";
      
      int inWidth = getMaxWidth(instr);

      modParams = {{"WIDTH", to_string(inWidth)}};
      //wiring = {{"in0", {true, inWidth, "max_in_" + rStr}}, {"in1", {true, inWidth, "max_in_" + rStr}}};
      //outWires = {{"out", {false, inWidth, "max_out_" + rStr}}};
      allPorts = {{"in0", inputPort(inWidth, "in0")}, {"in1", inputPort(inWidth, "in1")}, {"out", outputPort(inWidth, "out")}};
      
    } else if (TruncInst::classof(instr)) {
      modName = "trunc";

      int inWidth = getValueBitWidth(instr->getOperand(0));
      int outWidth = getValueBitWidth(instr);

      modParams = {{"IN_WIDTH", to_string(inWidth)}, {"OUT_WIDTH", to_string(outWidth)}};
      //wiring = {{"in", {true, inWidth, "trunc_in_" + rStr}}};
      //outWires = {{"out", {false, outWidth, "trunc_out_" + rStr}}};

      allPorts = {{"in", inputPort(inWidth, "in")}, {"out", outputPort(outWidth, "out")}};      
      
    } else if (CmpInst::classof(instr)) {
      CmpInst::Predicate pred = dyn_cast<CmpInst>(instr)->getPredicate();
      modName = cmpName(pred);

      int w0 = getValueBitWidth(instr->getOperand(0));
      int w1 = getValueBitWidth(instr->getOperand(1));

      assert(w0 == w1);

      modParams = {{"WIDTH", to_string(w0)}};
      //wiring = {{"in0", {true, w0, "cmp_in0_" + rStr}}, {"in1", {true, w0, "cmp_in1_" + rStr}}};
      //outWires = {{"out", {false, 1, "cmp_out_" + rStr}}};

      allPorts = {{"in0", inputPort(w0, "in0")}, {"in1", inputPort(w0, "in1")}, {"out", outputPort(1, "out")}};            
    } else if (BranchInst::classof(instr)) {
      modName = "br_dummy";
      //unitName = "br_unit";
    } else if (GetElementPtrInst::classof(instr)) {
      if (isRAMAddressCompGEP(dyn_cast<GetElementPtrInst>(instr), memSrcs)) {
        
        modName = "getelementptr_" + to_string(instr->getNumOperands() - 1);
        //wiring = {{"base_addr", {true, 32, "base_addr_" + rStr}}};
        allPorts.insert({"base_addr", inputPort(32, "base_addr")});
        
        for (int i = 1; i < (int) instr->getNumOperands(); i++) {
          allPorts.insert({"in" + to_string(i),
                inputPort(32, "in" + to_string(i))});
          //wiring.insert({"in" + to_string(i),
          //                {true, 32, "gep_add_in" + to_string(i) + "_" + rStr}});
        }
        //outWires = {{"out", {false, 32, "getelementptr_out_" + rStr}}};
        allPorts.insert({"out", outputPort(32, "out")});

      } else {
        modName = "sliceOp";
        Type* stp = getTypePointedTo(instr->getOperand(0)->getType());
        int inWidth = getTypeBitWidth(stp);
        Type* outSt = getTypePointedTo(instr->getType());
        int outWidth = getTypeBitWidth(outSt);

        GetElementPtrInst* gep = dyn_cast<GetElementPtrInst>(instr);
        assert(gep->hasAllConstantIndices());
        assert(gep->getNumIndices() == 2);
        int offset = gepOffset(dyn_cast<GetElementPtrInst>(instr));
        assert(offset == 0);
        Value* secondOffset = gep->getOperand(2);
        assert(ConstantInt::classof(secondOffset));
        ConstantInt* offC = dyn_cast<ConstantInt>(secondOffset);
        int cOffset = offC->getValue().getLimitedValue();
        int bitOffset = 0;
        StructType* underlyingStruct = extract<StructType>(stp);
        for (int i = 0; i < cOffset; i++) {
          bitOffset += getTypeBitWidth(underlyingStruct->elements()[i]);
        }
        
        //wiring = {{"in", {true, inWidth, "slice_in_" + rStr}}};
        modParams = {{"IN_WIDTH", to_string(inWidth)}, {"OFFSET", to_string(bitOffset)}, {"OUT_WIDTH", to_string(outWidth)}};
        
        //outWires = {{"out", {false, outWidth, "getelementptr_out_" + rStr}}};

        allPorts.insert({"in", inputPort(inWidth, "in")});
        allPorts.insert({"out", outputPort(outWidth, "out")});        
      }
    } else if (PHINode::classof(instr)) {
      PHINode* phi = dyn_cast<PHINode>(instr);

      modName = "phi";

      allPorts.insert({"last_block", inputPort(32, "last_block")});
      //wiring = {{"last_block", {true, 32, "phi_last_block_" + rStr}}};

      int w0 = getValueBitWidth(phi);
      int nb = (int) phi->getNumIncomingValues();
      modParams = {{"WIDTH", to_string(w0)}, {"NB_PAIR", to_string(nb)}};

      allPorts.insert({"s", inputPort(32*nb, "s")});
      allPorts.insert({"in", inputPort(w0*nb, "in")});

      //wiring.insert({"s", {true, 32*nb, string("phi_s") + "_" + rStr}});
      //wiring.insert({"in", {true, w0*nb, string("phi_in_") + rStr}});
      
      //outWires = {{"out", {false, 32, "phi_out_" + rStr}}};

      allPorts.insert({"out", outputPort(32, "out")});

    } else if (SelectInst::classof(instr)) {
      modName = "select";
      int w0 = getValueBitWidth(instr->getOperand(1));
      int w1 = getValueBitWidth(instr->getOperand(2));

      assert(w0 == w1);

      modParams = {{"WIDTH", to_string(w0)}};
      //wiring = {{"in0", {true, w0, "sel_in0_" + rStr}},
                // {"in1", {true, w0, "sel_in1_" + rStr}},
                // {"sel", {true, 1, "sel_sel_" + rStr}}};
      //outWires = {{"out", {false, w0, "sel_out_" + rStr}}};

      allPorts.insert({"in0", inputPort(w0, "in0")});
      allPorts.insert({"in1", inputPort(w0, "in1")});
      allPorts.insert({"sel", inputPort(1, "in1")});
      allPorts.insert({"out", outputPort(10, "out")});                        

    } else if (CallInst::classof(instr)) {

      if (isBuiltinPortCall(instr)) {
        // No action

        auto fuPtr = instr->getOperand(0);

        if (Argument::classof(fuPtr)) {
          isExternal = true;
        }

        ModuleSpec modSpec;
        //if (contains_key(fuPtr, hcs.modSpecs)) {
        if (hcs.builtModSpec((fuPtr))) {
          //modSpec = map_find(fuPtr, hcs.modSpecs);
          modSpec = hcs.getModSpec(fuPtr);
        } else {
          Type* fuTp = fuPtr->getType();

          //cout << "Functional unit type = " << typeString(fuTp) << endl;
          assert(PointerType::classof(fuTp));

          Type* fuDerefTp = dyn_cast<PointerType>(fuTp)->getElementType();

          assert(StructType::classof(fuDerefTp));

          StructType* structT = dyn_cast<StructType>(fuDerefTp);

          //cout << "Struct name = " << string(structT->getName()) << endl;

          if (!hcs.hasArgumentSpec(fuPtr)) {
            cout << "Error: No spec... for " << valueString(fuPtr) << ", possible choices" << endl;
            for (auto spec : hcs.typeSpecs) {
              cout << tab(1) << spec.first << endl;
            }
            assert(hcs.hasArgumentSpec(fuPtr));
          }
          modSpec = map_find(string(structT->getName()), hcs.typeSpecs)(structT);
        }

        modName = modSpec.name;
        string unitName = fuPtr->getName();
        defaults = modSpec.defaultValues;
        insensitivePorts = modSpec.insensitivePorts;
        allPorts = modSpec.ports; 
        hasRst = modSpec.hasReset();
        hasClock = modSpec.isSequential();
        modParams = modSpec.params;

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
            //wiring.insert({pt.first, {true, pt.second.width, unitName + "_" + pt.second.name}});

            allPorts.insert({pt.first, inputPort(pt.second.width, pt.second.name)});
          } else {
            //outWires.insert({pt.first, {false, pt.second.width, unitName + "_" + pt.second.name}});

            allPorts.insert({pt.first, outputPort(pt.second.width, pt.second.name)});
          }
        }

      } else {

        // No action
      }
    } else if (AllocaInst::classof(instr)) {
      //cout << "Alloca instruction = " << valueString(instr) << endl;
      AllocaInst* allocInst = dyn_cast<AllocaInst>(instr);
      Type* allocatedType = allocInst->getType()->getElementType();
      if (StructType::classof(allocatedType)) {
        //cout << "Allocating struct of type " << typeString(allocatedType) << endl;
        //return structFunctionalUnit(allocInst, hcs);
        return structModuleSpec(allocInst, hcs);
      }
    } else if (BitCastInst::classof(instr)) {
      // TODO: Add test case that uses casts
      // No action for this instruction type (YET)
    } else if (SExtInst::classof(instr)) {
      modName = "sext";
      //wiring = {{"in", {true, 32, "sgt_in0_" + rStr}}};
      //outWires = {{"out", {false, 64, "sgt_out_" + rStr}}};

      allPorts.insert({"in", inputPort(32, "in")});
      allPorts.insert({"out", outputPort(64, "out")});
      
    } else if (ZExtInst::classof(instr)) {
      modName = "zext";
      int outWidth = getValueBitWidth(instr);
      int inWidth = getValueBitWidth(instr->getOperand(0));
      
      ////wiring = {{"in", {true, inWidth, "zext_in_" + rStr}}};
      //outWires = {{"out", {false, 64, "zext_out_" + rStr}}};
      modParams = {{"IN_WIDTH", to_string(inWidth)}, {"OUT_WIDTH", to_string(outWidth)}};

      allPorts.insert({"in", inputPort(inWidth, "in")});
      allPorts.insert({"out", outputPort(outWidth, "out")});
    } else {
      cout << "Unsupported instruction = " << instructionString(instr) << endl;
      assert(false);
    }

    ModuleSpec modSpec = {modParams, modName, allPorts, defaults, insensitivePorts};
    modSpec.hasRst = hasRst;
    modSpec.hasClock = hasClock;

    return modSpec;
  }

  //void bindUnits(const STG& stg, HardwareConstraints& hcs) {
  void bindUnits(llvm::Function* f, HardwareConstraints& hcs) {

    //auto f = stg.getFunction();
    auto memSrcs = memoryOpLocations(f);
      //memoryOpLocations(stg.getFunction());

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

    // for (auto state : stg.opStates) {
    //   for (auto instrG : stg.instructionsStartingAt(state.first)) {
    //     Instruction* instr = instrG;
    for (Instruction& instrG : instructions(f)) {
      auto instr = &instrG;
      auto unit =
        buildModSpec(memNames, memSrcs, hcs, instr);
      //hcs.modSpecs[instr] = unit;
      hcs.bindValue(instr, unit);
      //      }
    }

  }
  
}
