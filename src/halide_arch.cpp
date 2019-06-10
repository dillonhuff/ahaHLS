#include "halide_arch.h"

#include <llvm/IR/LegacyPassManager.h>
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/Mem2Reg.h"

#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Analysis/LoopAccessAnalysis.h>
#include <llvm/Analysis/ScalarEvolution.h>

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Transforms/Scalar/SimplifyCFG.h"
#include "llvm/Transforms/Scalar/DCE.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Scalar/ADCE.h"
#include "llvm/Transforms/Scalar/LoopSimplifyCFG.h"
#include "llvm/Transforms/Utils/PromoteMemToReg.h"
#include "llvm/IR/Dominators.h"
#include <llvm/Analysis/CFG.h>

#include "llvm_codegen.h"
#include "test_utils.h"

#include "parser.h"

using namespace dbhc;
using namespace llvm;

namespace ahaHLS {

  ModuleSpec pushFifoSpec(int width, int depth) {
    map<string, Port> fifoPorts = {
      {"in_data", inputPort(width, "in_data")},
      {"write_valid", inputPort(1, "write_valid")},

      {"out_data", outputPort(width, "out_data")},
      {"read_valid", outputPort(1, "read_valid")},
    };

    map<string, int> defaults;
    defaults.insert({"write_valid", 0});    

    set<string> insensitivePorts{"in_data"};
    ModuleSpec modSpec = {{{"WIDTH", to_string(width)}}, "push_fifo", fifoPorts, defaults, insensitivePorts};
    modSpec.hasClock = true;
    modSpec.hasRst = true;
    return modSpec;
  }
  
  int64_t getInt(Value* val) {
    assert(ConstantInt::classof(val));
    int64_t ival = dyn_cast<ConstantInt>(val)->getSExtValue();
    return ival;
  }

  bool isBuiltinPushLBType(Type* allocTp) {
    if (StructType::classof(allocTp)) {
      return hasPrefix(dyn_cast<StructType>(allocTp)->getName(), "hls.lb.");
    }
    return false;
  }

  int lbInWidth(LBSpec& spec) {
    return spec.in.typeWidth*spec.in.nRows*spec.in.nCols;    
  }

  int lbOutWidth(LBSpec& spec) {
    return spec.out.typeWidth*spec.out.nRows*spec.out.nCols;
  }
  
  // TODO: Need to add image width
  ModuleSpec pushLBModSpec(LBSpec& spec) { //int inWidth, int outWidth) {

    int inWidth = lbInWidth(spec);
    int outWidth = lbOutWidth(spec);

    int outRows = spec.out.nRows;
    int outCols = spec.out.nCols;
    
    map<string, Port> fifoPorts = {
      {"wdata", inputPort(inWidth, "wdata")},
      {"wen", inputPort(1, "wen")},

      {"rdata", outputPort(outWidth, "rdata")},
      {"valid", outputPort(1, "valid")}
    };

    map<string, int> defaults;
    defaults.insert({"wen", 0});

    set<string> insensitivePorts{"in_data"};
    ModuleSpec modSpec = {{{"IN_WIDTH", to_string(inWidth)},
                           {"OUT_WIDTH", to_string(outWidth)},
                           {"OUT_ROWS", to_string(outRows)},
                           {"OUT_COLS", to_string(outCols)}}, "push_linebuf", fifoPorts, defaults, insensitivePorts};
    modSpec.hasClock = true;
    modSpec.hasRst = true;
    return modSpec;
  }

  HalideStencilTp stencilSpec(const std::string& stencilName) {
    int typeWidth = stencilTypeWidth(stencilName);
    int nRows = stencilNumRows(stencilName);
    int nCols = stencilNumCols(stencilName);
    return {typeWidth, nRows, nCols};
  }

  LBSpec lbSpecFromHLS(Type* allocTp) {
    string tpName = extract<StructType>(allocTp)->getName();
    string fields = drop("hls.lb.", tpName);
    vector<string> fieldVals =
      splitRep(".", fields);

    assert(fieldVals.size() > 2);
    cout << "Field size = " << fieldVals.size() << endl;

    int inWidth = stoi(fieldVals[0]);
    int inRows = stoi(fieldVals[3]);
    int inCols = stoi(fieldVals[3]);

    int outWidth = stoi(fieldVals[1]);
    int outRows = stoi(fieldVals[5]);
    int outCols = stoi(fieldVals[6]);

    int imgRows = stoi(fieldVals[7]);
    int imgCols = stoi(fieldVals[8]);    

    HalideStencilTp in{inWidth / (inRows * inCols), inRows, inCols};
    HalideStencilTp out{outWidth / (outRows * outCols), outRows, outCols};

    return LBSpec{in, out};
  }
  
  LBSpec lbSpec(const std::string& lbName) {
    assert(hasPrefix(lbName, "class.linebuffer_"));
    string restOfName = drop("class.linebuffer_", lbName);
    auto inAndOutBnds = splitOn("_to_", lbName);
    auto outAndBnds = splitOn("_bnds_", inAndOutBnds.second);
    auto inSpec = stencilSpec(drop("hls_stream_", inAndOutBnds.first));
    auto outSpec = stencilSpec(drop("hls_stream", outAndBnds.first));

    cout << "lb bounds string = " << outAndBnds.second << endl;
    auto imageBounds = splitOn("_", outAndBnds.second);
    int rows = stoi(imageBounds.first);
    int cols = stoi(imageBounds.second);    

    return LBSpec{inSpec, outSpec, {rows, cols}};
  }

  LBSpec lbSpec(Type* const lbName) {
    return lbSpec(extract<StructType>(lbName)->getName());
  }

  int lbInWidth(Type* lbTp) {
    auto lbTpName = extract<StructType>(lbTp)->getName();
    return stoi(takeUntil(".", drop("hls.lb.", lbTpName)));
  }

  int lbOutWidth(Type* lbTp) {
    auto lbTpName = extract<StructType>(lbTp)->getName();
    return stoi(takeUntil(".", drop(".", drop("hls.lb.", lbTpName))));
    
    //return 32;
  }

  Type* halideType(Type* tp) {
    if (PointerType::classof(tp)) {
      Type* underlying = dyn_cast<PointerType>(tp)->getElementType();
      return halideType(underlying)->getPointerTo();
    } else if (StructType::classof(tp)) {
      StructType* stp = dyn_cast<StructType>(tp);
      string name = stp->getName();
      if (hasPrefix(name, "class.AxiPackedStencil_")) {
        int typeWidth = stencilTypeWidth(name);
        int nRows = stencilNumRows(name);
        int nCols = stencilNumCols(name);
        return intType(typeWidth*nRows*nCols);
      } else if (hasPrefix(name, "class.hls_stream")) {
        string stencilName = streamStencilName(name);        
        int typeWidth = stencilTypeWidth(stencilName);
        int nRows = stencilNumRows(stencilName);
        int nCols = stencilNumCols(stencilName);
        return fifoType(typeWidth*nRows*nCols);
      } else if (hasPrefix(name, "class.linebuffer")) {
        // TODO: Actually compute these
        //HalideStencilTp stencilIn{16, 1, 1};
        //HalideStencilTp stencilOut{16, 1, 2};

        LBSpec spec = lbSpec(tp);
        //return lbType(16, 16*2);
        return lbType(spec);
      } else {
        return tp;
      }
    } else {
      return tp;
    }
  }

  bool isConstructor(const std::string& classPrefix, Function* func) {
    string name = func->getName();
    if (canDemangle(name)) {
      name = demangle(name);
      if (hasPrefix(name, classPrefix)) {
        string mName = drop("::", name);
        string rName = takeUntil("(", mName);
        return hasPrefix(rName, classPrefix);
      }
    }

    return false;
  }

  Value* findSource(Value* val, map<Value*, Value*>& rewrites) {
    for (auto& ent : rewrites) {
      if (ent.second == val) {
        return ent.first;
      }
    }
    cout << "Error: No source entry for " << valueString(val) << endl;
    assert(false);
  }
  
  Value* findRewrite(Value* val, map<Value*, Value*>& rewrites) {
    if (ConstantInt::classof(val)) {
      return mkInt(getInt(val), getValueBitWidth(val)); //val;
    }

    if (!contains_key(val, rewrites)) {
      cout << "Error: No rewrite for " << valueString(val) << endl;
    }
    
    assert(contains_key(val, rewrites));
    return map_find(val, rewrites);
  }

  int streamWidth(const std::string& name) {
    cout << "Stram name = " << name << endl;
    string stencilName = streamStencilName(name);
    int typeWidth = stencilTypeWidth(stencilName);
    int nRows = stencilNumRows(stencilName);
    int nCols = stencilNumCols(stencilName);

    return typeWidth*nRows*nCols;
  }

  int streamWidth(Type* strm) {
    StructType* tp = extract<StructType>(getPointedToType(strm));
    string name = tp->getName();
    return streamWidth(name);
  }
  
  int streamWidth(Value* strm) {
    Type* tp = strm->getType();
    return streamWidth(tp);
  }

  llvm::Function* sliceFunc(const int inWidth, const int bitOffset, const int outWidth) {
    vector<Type*> ins{intType(inWidth)};
    auto f = mkFunc(ins, intType(outWidth), "hls.slice." + to_string(inWidth) + "." + to_string(bitOffset) + "." + to_string(outWidth));
    return f;
  }
  
  llvm::Function* fifoReadRefFunction(const int width) {
    vector<Type*> ins{intType(width)->getPointerTo(),
        fifoType(width)->getPointerTo()};
    auto f = mkFunc(ins, voidType(), "fifo_read_ref." + to_string(width));
    f->addParamAttr(0, llvm::Attribute::ByVal);        
    return f;
  }

  llvm::Function* lbHasValidFunction(Value* replacementLB) {
    vector<Type*> ins{replacementLB->getType()};
    int width = 0;
    auto f = mkFunc(ins, intType(1), "lb_has_valid." + to_string(width));
    return f;
  }
  
  llvm::Function* fifoWriteRefFunction(const int width) {
    vector<Type*> ins{fifoType(width)->getPointerTo(),
        intType(width)->getPointerTo()};
    auto f = mkFunc(ins, voidType(), "fifo_write_ref." + to_string(width));
    f->addParamAttr(1, llvm::Attribute::ByVal);
    return f;
  }

  // W?
  Function* lbWriteFunction(Value* replacementLB) {
    // TODO: compute this width    
    int inWidth = 16;
    vector<Type*> ins{replacementLB->getType(), intType(inWidth)->getPointerTo()};
    auto f = mkFunc(ins, voidType(), "lb_push." + to_string(inWidth));
    f->addParamAttr(1, llvm::Attribute::ByVal);        
    return f;
  }

  Function* lbReadFunction(Value* replacementLB) {
    // TODO: compute this width
    int outWidth = 32;
    vector<Type*> ins{intType(outWidth)->getPointerTo(), replacementLB->getType()};
    auto f = mkFunc(ins, voidType(), "lb_pop." + to_string(outWidth));
    f->addParamAttr(0, llvm::Attribute::ByVal);    
    return f;
  }

  Function* hlsMaxFunction(Value* in0) {
    Type* argTp = in0->getType();
    assert(IntegerType::classof(argTp));
    int tpWidth = getTypeBitWidth(argTp);
    vector<Type*> ins{argTp, argTp};
    return mkFunc(ins, argTp, "hls.max." + to_string(tpWidth));
  }

  Function* hlsMinFunction(Value* in0) {
    Type* argTp = in0->getType();
    assert(IntegerType::classof(argTp));
    int tpWidth = getTypeBitWidth(argTp);
    vector<Type*> ins{argTp, argTp};
    return mkFunc(ins, argTp, "hls.min." + to_string(tpWidth));
  }
  
  void rewriteInstr(Function* f,
                    Function* orig,
                    map<BasicBlock*, BasicBlock*>& bbRewrites,
                    map<Value*, Value*>& rewrites,
                    Instruction* toRewrite) {
    BasicBlock* repBB = map_find(toRewrite->getParent(), bbRewrites);

    assert(repBB->getParent() == f);
    
    IRBuilder<> b(repBB);
    if (AllocaInst::classof(toRewrite)) {
      AllocaInst* alloc = dyn_cast<AllocaInst>(toRewrite);
      Type* allocTp = halideType(alloc->getType()->getElementType());
      auto* rw = b.CreateAlloca(allocTp);
      rewrites[toRewrite] = rw;
    } else if (CallInst::classof(toRewrite)) {
      CallInst* callToRW = dyn_cast<CallInst>(toRewrite);
      Function* func = callToRW->getCalledFunction();

      if (isMethod("AxiPackedStencil_", "get", func)) {
        // datawidth, datawidth*nCols, asdf

        Type* stp = toRewrite->getOperand(0)->getType();
        string stencilName =
          extract<StructType>(getPointedToType(stp))->getName();
        auto st = stencilSpec(stencilName);
        int dataWidth = st.typeWidth;
        int nCols = st.nCols;

        vector<int64_t> strides{dataWidth*nCols, dataWidth, 0, 0, 0, 0};
        int bitOffset = 0;
        int stride = strides[0];
        cout << "axi_get ";
        for (int i = 1; i < (int) func->arg_size(); i++) {
          cout << valueString(toRewrite->getOperand(i)) << ", ";
        }
        cout << endl << endl;
        
        cout << "-- Starting stride comp for " << valueString(toRewrite) << endl;
        for (int i = 1; i < (int) func->arg_size(); i++) {
          Value* index = toRewrite->getOperand(i);
          cout << "Index = " << valueString(index) << endl;
          int64_t indI = getInt(index);
          cout << "indI = " << indI << ", stride = " << stride << endl;
          bitOffset += indI*stride;
          stride = strides[i];
        }

        cout << "Get bit offset in stencil reg = " << bitOffset << endl;

        auto fullLoad =
          b.CreateLoad(findRewrite(toRewrite->getOperand(0), rewrites));

        int typeWidth = getValueBitWidth(toRewrite);
        if (bitOffset > 0) {
          // Create hls.slice?
          auto hlsSlice = sliceFunc(getValueBitWidth(fullLoad), bitOffset, typeWidth);
          auto sliceCall = b.CreateCall(hlsSlice, {fullLoad});
          rewrites[toRewrite] = sliceCall;
          
          // cout << "Bit offset = " << bitOffset << " not zero" << endl;
          // auto shifted = b.CreateLShr(fullLoad, mkInt(bitOffset, getValueBitWidth(fullLoad)));
          // cout << "shift = " << valueString(shifted) << endl;

          // rewrites[toRewrite] = b.CreateTrunc(shifted, intType(typeWidth));
          
        } else {
          rewrites[toRewrite] = b.CreateTrunc(fullLoad, intType(getValueBitWidth(toRewrite)));
        }
      } else if (isMethod("AxiPackedStencil_", "set", func)) {
        // TODO: Add indexing
        rewrites[toRewrite] =
          b.CreateStore(findRewrite(toRewrite->getOperand(1), rewrites),
                        findRewrite(toRewrite->getOperand(0), rewrites));
        
      } else if (isConstructor("hls_stream", func)) {
        // Do nothing, the constructor is a no-op
      } else if (isMethod("hls_stream", "read", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        auto replaceF = fifoReadRefFunction(streamWidth(toRewrite->getOperand(1)));
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
      } else if (isMethod("hls_stream", "write", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        auto replaceF = fifoWriteRefFunction(streamWidth(toRewrite->getOperand(0)));
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
      } else if (isConstructor("AxiPackedStencil_", func)) {
        cout << "Replacing stencil constructor " << valueString(toRewrite) << endl;
        
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        if (argReplacements.size() == 1) {
          // Do nothing
          return;
        }
        
        assert(argReplacements.size() == 2);

        auto source = b.CreateLoad(argReplacements[1]);
        rewrites[toRewrite] =
          b.CreateStore(source, argReplacements[0]);
      } else if (isMethod("AxiPackedStencil_", "copy", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() == 2);

        auto source = b.CreateLoad(argReplacements[1]);
        rewrites[toRewrite] =
          b.CreateStore(source, argReplacements[0]);
      } else if (isMethod("AxiPackedStencil_", "set_last", func)) {
        // Do nothing
      } else if (isMethod("ram_", "ram_write", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        // TODO: Replace with builtin ram read function
        int w =
          ramDataWidth(typeString(getPointedToType(getArg(func, 0)->getType())));
        // asdf
        int d =
          ramDepth(typeString(getPointedToType(getArg(func, 0)->getType())));
        auto replacement = ramStoreFunction(w, d);
        rewrites[toRewrite] =
          b.CreateCall(replacement, argReplacements);
      } else if (isMethod("ram_", "ram_read", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        // TODO: Replace with builtin ram read function
        int w =
          ramDataWidth(typeString(getPointedToType(getArg(func, 0)->getType())));
        // asdf
        int d =
          ramDepth(typeString(getPointedToType(getArg(func, 0)->getType())));
        auto replacement = ramLoadFunction(w, d);
        rewrites[toRewrite] =
          b.CreateCall(replacement, argReplacements);
      } else if (isMethod("linebuffer_", "lb_write", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        auto replaceF = lbWriteFunction(argReplacements[0]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
        
      } else if (isMethod("linebuffer_", "lb_read", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        // TODO: Replace with real lb stats
        auto replaceF = lbReadFunction(argReplacements[1]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
        
      } else if (isMethod("linebuffer_", "has_valid_data", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        // TODO: Replace with real lb stats
        auto replaceF = lbHasValidFunction(argReplacements[0]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
      } else if (matchesCallDemangled("halide_cpp_min", toRewrite)) {

        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        auto replaceF = hlsMinFunction(argReplacements[0]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
      } else if (matchesCallDemangled("halide_cpp_max", toRewrite)) {

        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        auto replaceF = hlsMaxFunction(argReplacements[0]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
        
      } else {
        cout << "Unsupported call" << valueString(toRewrite) << endl;
        if (canDemangle(func->getName())) {
          cout << "\tDemangled name = " << demangle(func->getName()) << endl;
        }
        assert(false);
      }
    } else if (BranchInst::classof(toRewrite)) {
      BranchInst* bi = dyn_cast<BranchInst>(toRewrite);
      if (bi->isConditional()) {
        //cout << "Error: Conditional branch " << valueString(toRewrite) << endl;
        //assert(false);
        assert(bi->getNumSuccessors() == 2);

        auto cond = findRewrite(bi->getOperand(0), rewrites);
        auto rLHS = map_find(bi->getSuccessor(0), bbRewrites);
        auto rRHS = map_find(bi->getSuccessor(1), bbRewrites);

        rewrites[toRewrite] = b.CreateCondBr(cond, rLHS, rRHS);
      } else {
        auto* targetInRewritten = map_find(bi->getSuccessor(0), bbRewrites);
        auto newBr = b.CreateBr(targetInRewritten);
        rewrites[toRewrite] = newBr;
      }

    } else if (PHINode::classof(toRewrite)) {
      int reservedVals = dyn_cast<PHINode>(toRewrite)->getNumIncomingValues();
      auto* replacement = b.CreatePHI(halideType(toRewrite->getType()), reservedVals);
      rewrites[toRewrite] = replacement;
    } else if (ZExtInst::classof(toRewrite)) {
      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);
      rewrites[toRewrite] = b.CreateZExt(rLHS, toRewrite->getType());
      
    } else if (TruncInst::classof(toRewrite)) {
      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);
      rewrites[toRewrite] = b.CreateTrunc(rLHS, toRewrite->getType());
      
    } else if (BinaryOperator::classof(toRewrite)) {
      llvm::Instruction::BinaryOps opcode =
        dyn_cast<BinaryOperator>(toRewrite)->getOpcode();

      cout << "Getting " << valueString(toRewrite->getOperand(0)) << endl;
      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);

      auto rRHS = findRewrite(toRewrite->getOperand(1), rewrites);      

      cout << "Got binop" << endl;
      rewrites[toRewrite] = b.CreateBinOp(opcode, rLHS, rRHS);
    } else if (ICmpInst::classof(toRewrite)) {
      llvm::ICmpInst::Predicate pred =
        dyn_cast<CmpInst>(toRewrite)->getPredicate();

      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);
      auto rRHS = findRewrite(toRewrite->getOperand(1), rewrites);

      rewrites[toRewrite] = b.CreateICmp(pred, rLHS, rRHS);
      
    } else if (ReturnInst::classof(toRewrite)) {
      assert(toRewrite->getType()->isVoidTy());
      rewrites[toRewrite] = b.CreateRet(nullptr);
    } else if (SExtInst::classof(toRewrite)) {
      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);
      rewrites[toRewrite] = b.CreateSExt(rLHS, toRewrite->getType());
    } else if (SelectInst::classof(toRewrite)) {
      auto cond = findRewrite(toRewrite->getOperand(0), rewrites);
      auto tv = findRewrite(toRewrite->getOperand(1), rewrites);
      auto fv = findRewrite(toRewrite->getOperand(2), rewrites);

      rewrites[toRewrite] = b.CreateSelect(cond, tv, fv);
    } else {
      cout << "Error in Halide stencil rewrite: Unsupported instr = " << valueString(toRewrite) << endl;
      assert(false);
    }

  }

  void populatePHIs(Function* orig,
                    Function* f,
                    map<Value*, Value*>& rewrites,
                    map<BasicBlock*, BasicBlock*>& bbRewrites) {
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        Instruction* instr = &instrR;
        if (PHINode::classof(instr)) {

          cout << "Found phi " << valueString(instr) << endl;
          auto newPhi = dyn_cast<PHINode>(instr);
          
          auto origP = findSource(dyn_cast<Value>(instr), rewrites);
          assert(PHINode::classof(origP));
          auto origPhi = dyn_cast<PHINode>(origP);

          cout << "Populating replacement for " << valueString(origPhi) << endl;
          
          for (int i = 0; i < origPhi->getNumIncomingValues(); i++) {
            cout << "Getting " << i << "th block" << endl;
            BasicBlock* replaceBB =
              map_find(origPhi->getIncomingBlock(i), bbRewrites);
            cout << "Getting " << i << "th value" << endl;            

            Value* replaceVal =
              findRewrite(origPhi->getIncomingValue(i), rewrites);

            cout << "Getting " << i << "th value" << endl;                        
            newPhi->addIncoming(replaceVal, replaceBB);
          }
        }
      }
    }
  }
  
  Function* rewriteHalideStencils(Function* orig) {
    vector<Type*> inputTypes;
    for (int i = 0; i < orig->arg_size(); i++) {
      Type* rwTp = halideType(getArg(orig, i)->getType());
      inputTypes.push_back(rwTp);
    }
    Function* f = mkFunc(inputTypes, string(orig->getName( )) + "_rewritten", &(getGlobalLLVMModule()));

    map<Value*, Value*> rewrites;
    for (int i = 0; i < orig->arg_size(); i++) {
      rewrites[getArg(orig, i)] = getArg(f, i);
    }

    map<BasicBlock*, BasicBlock*> bbRewrites;
    for (auto& bb : orig->getBasicBlockList()) {
      bbRewrites[&bb] = mkBB(string(bb.getName()), f);
    }
    
    for (auto& bb : orig->getBasicBlockList()) {
      for (auto& instrR : bb) {
        Instruction* instr = &instrR;
        rewriteInstr(f, orig, bbRewrites, rewrites, instr);
      }
    }

    populatePHIs(orig, f, rewrites, bbRewrites);

    cout << "Immediately after rewrite " << endl;
    cout << valueString(f) << endl;
    
    sanityCheck(f);
    
    return f;
  }

  int builtinFifoWidth(Type* tp) {
    if (StructType::classof(tp)) {
      return stoi(drop("builtin_fifo_", dyn_cast<StructType>(tp)->getName()));
    }
    assert(false);
  }
  
  bool isBuiltinFifoType(Type* tp) {
    if (StructType::classof(tp)) {
      return hasPrefix(dyn_cast<StructType>(tp)->getName(), "builtin_fifo_");
    }
    return false;
  }
  
  void assignModuleSpecs(Function* f, HardwareConstraints& hcs, HalideArchSettings& settings) {
    
    for (int i = 0; i < f->arg_size(); i++) {
      auto argTp = getPointedToType(getArg(f, i)->getType());
      if (isBuiltinFifoType(argTp)) {
        if (!settings.pushFifos) {
          hcs.modSpecs[getArg(f, i)] = fifoSpec(builtinFifoWidth(argTp), 128);
        } else {
          hcs.modSpecs[getArg(f, i)] = pushFifoSpec(builtinFifoWidth(argTp), 128);
        }
      }
    }
    
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        if (AllocaInst::classof(instr)) {
          auto allocTp = getPointedToType(instr->getType());
          cout << "Allocating type " << typeString(allocTp) << endl;
          if (isBuiltinFifoType(allocTp)) {
            if (!settings.pushFifos) {
              hcs.modSpecs[instr] = fifoSpec(builtinFifoWidth(allocTp), 128);
            } else {
              hcs.modSpecs[instr] = pushFifoSpec(builtinFifoWidth(allocTp), 128);
            }
          } else if (isBuiltinPushLBType(allocTp)) {
            LBSpec spec = lbSpecFromHLS(allocTp);
            hcs.modSpecs[instr] = pushLBModSpec(spec); //lbInWidth(allocTp), lbOutWidth(allocTp));
          } else if (IntegerType::classof(allocTp)) {
            hcs.memSpecs[instr] = registerSpec(getTypeBitWidth(allocTp));
          } else {
            cout << "Unrecognized alloc type = " << typeString(allocTp) << endl;
          }
        }
      }
    }

    hcs.memoryMapping = memoryOpLocations(f);
  }

  bool precedes(BasicBlock* predBlk, BasicBlock* succBlk, vector<BasicBlock*> blkOrder) {
    if (predBlk == succBlk) {
      return false;
    }
    int predPos =
      distance(blkOrder.begin(), find(blkOrder.begin(), blkOrder.end(), predBlk));

    int succPos =
      distance(blkOrder.begin(), find(blkOrder.begin(), blkOrder.end(), succBlk));

    return (succPos - predPos) > 0;
  }

  bool isRAMWrite(Instruction* instr) {
    if (CallInst::classof(instr)) {
      CallInst* ci = dyn_cast<CallInst>(instr);
      cout << "Name of called = "
           << string(ci->getCalledFunction()->getName())
           << endl;
      return hasPrefix(ci->getCalledFunction()->getName(), "ram.write.");
    }

    return false;
  }

  bool isRAMRead(Instruction* instr) {
    if (CallInst::classof(instr)) {
      CallInst* ci = dyn_cast<CallInst>(instr);
      return hasPrefix(ci->getCalledFunction()->getName(), "ram.read.");
    }

    return false;
  }

  bool isRAMType(Type* tp) {
    if (StructType::classof(tp)) {
      return hasPrefix(dyn_cast<StructType>(tp)->getName(), "class.ram_");
    }

    return false;
  }

  TaskSpec wholeFunctionTask(Function* const f) {
    set<BasicBlock*> blks;
    for (auto& bb : *f) {
      blks.insert(&bb);
    }
    return {blks};
  }
  
  void implementPushFifoWriteRef(llvm::Function* writeFifo,
                                 ExecutionConstraints& exec) {

    auto out = getArg(writeFifo, 0);


    auto dataPtr = getArg(writeFifo, 1);

    assert(PointerType::classof(dataPtr->getType()));

    auto dataPtrTp = dyn_cast<PointerType>(dataPtr->getType());

    auto tp = out->getType();
    
    int width = getTypeBitWidth(dataPtrTp->getElementType());
    
    auto writeDataF = writePort("in_data", width, tp);
    auto setValidF = writePort("write_valid", 1, tp);

    auto entryBlk = mkBB("entry_block", writeFifo);

    IRBuilder<> entryBuilder(entryBlk);
    auto setValid1 = entryBuilder.CreateCall(setValidF, {out, mkInt(1, 1)});
    auto data = entryBuilder.CreateLoad(dataPtr);    
    auto writeValue = entryBuilder.CreateCall(writeDataF, {out, data});
    auto ret = entryBuilder.CreateRet(nullptr);

    exec.add(instrEnd(data) == instrStart(writeValue));
    exec.add(instrEnd(data) == instrStart(setValid1));
    //exec.add(instrStart(writeValue) + 1 == instrStart(ret));
    exec.add(instrStart(writeValue) == instrStart(ret));
    
    addDataConstraints(writeFifo, exec);
  }
  
  void implementPushFifoReadRef(llvm::Function* readFifo, ExecutionConstraints& exec) {

    auto out = getArg(readFifo, 0);
    auto fifo = getArg(readFifo, 1);
    auto tp = getPointedToType(out->getType());

    int width = getTypeBitWidth(tp);

    auto readInDataF = readPort("out_data", width, tp);
    
    auto entryBlk = mkBB("entry_block", readFifo);

    IRBuilder<> entryBuilder(entryBlk);
    auto readValue = entryBuilder.CreateCall(readInDataF, {fifo});    
    auto store = entryBuilder.CreateStore(readValue, out);
    auto ret = entryBuilder.CreateRet(nullptr);
    
    exec.add(instrStart(store) == instrEnd(readValue));
    exec.add(instrEnd(store) == instrStart(ret));

    addDataConstraints(readFifo, exec);
  }  

  bool isPerfect(Loop* loop) {
    if (loop->getSubLoops().size() == 0) {
      return true;
    }

    return true;
  }

  class DataflowNestInfo {
  public:
    vector<int> tripCounts;
    set<BasicBlock*> body;
    set<Instruction*> blockingOps;
  };

  DataflowNestInfo computeDataflowInfo(Loop* loop, ScalarEvolution& scev) {
    DataflowNestInfo info;

    Loop* activeLoop = loop;
    while (activeLoop->getSubLoops().size() > 0) {
      assert(activeLoop->getSubLoops().size() == 1);

      unsigned tc = scev.getSmallConstantTripCount(activeLoop);
      cout << "Trip count of activeLoop = " << tc << endl;
      info.tripCounts.push_back(tc);
      
      activeLoop = activeLoop->getSubLoops()[0];

    }

    unsigned tc = scev.getSmallConstantTripCount(activeLoop);
    cout << "Trip count of base loop = " << tc << endl;
    info.tripCounts.push_back(tc);
    
    cout << "Body " << endl;
    for (auto blk : activeLoop->getBlocks()) {
      info.body.insert(blk);
      cout << tab(1) << "Includes block" << endl;
      cout << valueString(blk) << endl;
    }

    // Find all operations that we may need to block for
    for (auto blk : loop->getBlocks()) {
      for (auto& instrR : *blk) {
        auto instr = &instrR;
        if (matchesCall("lb_pop", instr) ||
            matchesCall("fifo_read_ref", instr)) {
          cout << tab(1) << "Blocking operation: " << valueString(instr) << endl;
          info.blockingOps.insert(instr);
        }
      }
    }

    return info;
  }

  void runCleanupPasses(Function* f) {
    FunctionPassManager FPM;
    FPM.addPass(SimplifyCFGPass());
    FPM.addPass(ADCEPass());        
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*f, FAM);
  }

  set<Instruction*> getBlockingOps(BasicBlock* const opBlock) {
    set<Instruction*> blocking;
    for (auto& instrR : *opBlock) {
      auto instr = &instrR;
      if (matchesCall("lb_pop", instr) ||
          matchesCall("fifo_read_ref", instr)) {
        blocking.insert(instr);
      }
    }
    
    return blocking;
  }
  
  void liftBlockingOps(Function* f) {
    DominatorTree dt(*f);
    LoopInfo li(dt);

    for (Loop* loop : li) {
      assert(loop->getBlocks().size() == 1);

      BasicBlock* bb = loop->getBlocks()[0];
      auto* canonicalVar = loop->getCanonicalInductionVariable();
      auto* ind =
        loop->getCanonicalInductionVariable()->getNextNonDebugInstruction();
      assert(ind != nullptr);
      assert(ind->getParent() == bb);

      BasicBlock* opBlock = bb->splitBasicBlock(ind);

      cout << "opBlock = " << valueString(opBlock) << endl;
      
      auto* loopCond =
        //extract<Instruction>(extract<BranchInst>(opBlock->getTerminator()));
        extract<ICmpInst>(extract<BranchInst>(opBlock->getTerminator())->getCondition());

      // TODO: Need to move this code
      cout << "Splitting at " << valueString(loopCond) << endl;

      BasicBlock* exitBlock = opBlock->splitBasicBlock(loopCond);
      auto* branchCond =
        extract<ICmpInst>(extract<BranchInst>(exitBlock->getTerminator())->getCondition());
      cout << "Lifted loop latch cond = " << valueString(branchCond) << endl;
      auto* lhs = branchCond->getOperand(0);
      auto* rhs = branchCond->getOperand(1);

      assert(ConstantInt::classof(rhs));
      assert(Instruction::classof(lhs));
      assert(dyn_cast<Instruction>(lhs)->getParent() == opBlock);

      auto newLHS = PHINode::Create(lhs->getType(), 2);
      newLHS->addIncoming(lhs, opBlock);
      newLHS->addIncoming(canonicalVar, bb);
      newLHS->insertBefore(branchCond);

      cout << "Loop latch after adding new index = " << endl;
      cout << valueString(dyn_cast<Instruction>(lhs)->getParent()) << endl;

      branchCond->setOperand(0, newLHS);
      // auto newBrCond = CmpInst::Create(ICmp::EQ, newLHS, rhs);
      // branchCond->replaceAllUsesWidth(newBrCond);
      // branchCond->eraseFromParent();
      
      // This terminator needs to be replaced
      TerminatorInst* validCheckBr = bb->getTerminator();
      set<Instruction*> blockingOps = getBlockingOps(opBlock);
      IRBuilder<> bbBuilder(bb);
      Value* allInputsValid = mkInt(1, 1);
      for (auto op : blockingOps) {
        if (matchesCall("fifo_read_ref", op)) {
          CallInst* c = extract<CallInst>(op);
          auto readDataValid = readPort(bbBuilder, c->getOperand(1), 1, "read_valid");
          allInputsValid = bbBuilder.CreateAnd(allInputsValid, readDataValid);
        } else if (matchesCall("lb_pop", op)) {
          CallInst* c = extract<CallInst>(op);
          auto readDataValid = readPort(bbBuilder, c->getOperand(1), 1, "valid");
          allInputsValid = bbBuilder.CreateAnd(allInputsValid, readDataValid);
        }
      }
      validCheckBr->eraseFromParent();
      bbBuilder.CreateCondBr(allInputsValid, opBlock, exitBlock);
    }

    cout << "Done splitting" << endl;
    cout << valueString(f) << endl;

  }
  
  // Bad name, should really be "dataFlowLoops" or something similar
  void forToWhileLoopOpt(Function* f, HalideArchSettings settings) {

    FunctionPassManager FPM;
    FPM.addPass(SimplifyCFGPass());
    //FPM.addPass(LoopSimplifyCFGPass());    
    FPM.addPass(DCEPass());
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*f, FAM);

    llvm::legacy::PassManager pm;
    pm.add(new LoopInfoWrapperPass());
    pm.add(new AAResultsWrapperPass());
    pm.add(new TargetLibraryInfoWrapperPass());
    pm.add(createLoopSimplifyCFGPass());
    pm.run(*(f->getParent()));
    
    // LoopPassManager LPM;
    // LPM.addPass(SimplifyCFGPass());
    // LoopAnalysisManager LAM;
    // PassBuilder lbp;
    // lbp.registerLoopAnalyses(LAM);
    // lbp.run(*f, LAM);
    
    cout << "Before Dataflow loop opts" << endl;
    cout << valueString(f) << endl;
    
    DominatorTree dt(*f);
    LoopInfo li(dt);
    TargetLibraryInfoImpl i;
    TargetLibraryInfo tli(i);
    AssumptionCache ac(*f);
    ScalarEvolution scev(*f, tli, ac, dt, li);

    map<Loop*, DataflowNestInfo> dataflowNests;
    map<Loop*, BasicBlock*> preds;
    map<Loop*, BasicBlock*> exits;

    for (Loop* loop : li) {
      cout << "Found loop in for to while conversion, depth = " << loop->getLoopDepth() << ", subloops = " << loop->getSubLoops().size() << endl;
      
      assert(isPerfect(loop));

      // Q: What is the first thing to do?
      // A: Compute trip counts for each inner loop, compute product of the trip counts and extract the body of the function
      DataflowNestInfo info = computeDataflowInfo(loop, scev);
      dataflowNests[loop]= info;

      BasicBlock* pred = loop->getLoopPredecessor();
      if (pred == nullptr) {
        cout << "Loop does not have unique predecessor" << endl;        
        assert(false);
      }
      preds[loop] = pred;

      BasicBlock* exit = loop->getUniqueExitBlock();
      if (exit == nullptr) {
        cout << "Loop does not have unique exit block" << endl;
        SmallVector<BasicBlock*, 8> exitBlocks;
        loop->getUniqueExitBlocks(exitBlocks);
        for (auto blk : exitBlocks) {
          cout << "Exit blk" << endl;
          cout << valueString(blk) << endl;
        }
        
        SmallVector<std::pair<const BasicBlock *, const BasicBlock *>, 8> exitEdges;
        loop->getExitEdges(exitEdges);

        for (auto edge : exitEdges) {
          cout << "Out from " << endl;
          cout << valueString(edge.first) << endl;
          cout << "to" << endl;
          cout << valueString(edge.second) << endl;          
        }
        assert(false);
      }
      exits[loop] = exit;
    }

    for (auto lpInfo : dataflowNests) {
      Loop* loop = lpInfo.first;
      DataflowNestInfo info = lpInfo.second;
      assert(info.body.size() == 1);

      if (info.tripCounts.size() > 1) {
        assert(info.tripCounts.size() == 2);

        // Need to flatten the loop

        Loop* innerLoop = loop->getSubLoops()[0];
        auto outerInd = loop->getCanonicalInductionVariable();
        assert(outerInd != nullptr);

        auto innerInd = innerLoop->getCanonicalInductionVariable();
        assert(innerInd != nullptr);

        auto innerLatch = innerLoop->getLoopLatch();
        assert(innerLatch != nullptr);

        TerminatorInst* latchTerm = innerLatch->getTerminator();
        BranchInst* latchBr = extract<BranchInst>(latchTerm);
        assert(latchBr->getNumSuccessors() == 2);
        auto s0 = latchBr->getSuccessor(0);
        auto s1 = latchBr->getSuccessor(1);
        assert((s0 == innerLatch) || (s1 == innerLatch));

        auto onlyNewDest = s0 == innerLatch ? s1 : s0;
        latchTerm->eraseFromParent();
        IRBuilder<> lt(innerLatch);
        lt.CreateBr(onlyNewDest);
        innerInd->removeIncomingValue(innerLatch);

        // Change the bound on the new outer loop
        {
          int totalTripCount = 1;
          for (auto tc : info.tripCounts) {
            totalTripCount *= tc;
          }
          cout << "Total trip count of flattened = " << totalTripCount << endl;
          // We only handle 16 bits on CGRA now
          assert(totalTripCount < 300000);

          BasicBlock* outerLatch = loop->getLoopLatch();

          assert(outerLatch != nullptr);
          
          BranchInst* latchBr = extract<BranchInst>(outerLatch->getTerminator());

          assert(latchBr->isConditional());          
          assert(latchBr->getNumSuccessors() == 2);

          //auto test = latchBr->getCondition();
          auto s0 = latchBr->getSuccessor(0);
          auto s1 = latchBr->getSuccessor(1);

          latchBr->eraseFromParent();

          IRBuilder<> lt(outerLatch);
          //lt.CreateCondBr(lt.CreateICmpEQ(outerInd, mkInt(totalTripCount, 16)), s0, s1);
          lt.CreateCondBr(lt.CreateICmpEQ(lt.CreateAdd(outerInd, mkInt(1, 32)), mkInt(totalTripCount, 32)), s0, s1);
        }

        
      }
    }

    runCleanupPasses(f);
    
    cout << "After loop flattening opt" << endl;
    cout << valueString(f) << endl;
    sanityCheck(f);

    liftBlockingOps(f);
  }

  bool isLB(Value* v) {
    if (!PointerType::classof(v->getType())) {
      return false;
    }

    return isBuiltinPushLBType(extract<PointerType>(v->getType())->getElementType());
  }
  
  bool isFifoWrite(Instruction* instr) {
    if (matchesCall("fifo_write", instr) ||
        matchesCall("lb_push", instr)) {
      return true;
    }

    return false;
  }
  
  bool isFifoRead(Instruction* instr) {
    if (matchesCall("fifo_read", instr) ||
        matchesCall("lb_pop", instr)) {
      return true;
    }

    return false;
  }
  
  set<Instruction*> fifoReads(Loop* lp) {
    set<Instruction*> rds;
    for (auto* bb : lp->getBlocks()) {
      for (auto& instr : *bb) {
        if (matchesCall("fifo_read", &instr) ||
            matchesCall("lb_pop", &instr)) {
          rds.insert(&instr);
        }
      }
    }

    return rds;
  }

  // Wr
  set<Instruction*> fifoWrites(Loop* lp) {
    set<Instruction*> rds;
    for (auto* bb : lp->getBlocks()) {
      for (auto& instr : *bb) {
        if (matchesCall("fifo_write", &instr) ||
            matchesCall("lb_push", &instr)) {
          rds.insert(&instr);
        }
      }
    }

    return rds;
  }

  std::vector<Instruction*> instrSequence(Instruction* start, const int sequenceLength) {
    vector<Instruction*> instrs{start};

    auto activeInstr = start;
    for (int i = 0; i < sequenceLength - 1; i++) {
      auto nextInstr = activeInstr->getNextNonDebugInstruction();
      if (nextInstr == nullptr) {
        return {};
      }

      instrs.push_back(nextInstr);
      activeInstr = nextInstr;
    }

    assert(instrs.size() == sequenceLength);
    return instrs;
  }
  
  void peepholeOptimizeFifoWrites(Function* f) {
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        if (isFifoRead(instr)) {
          vector<Instruction*> instrs = instrSequence(instr, 4);
          if (instrs.size() > 0) {
            cout << "Found instruction sequence after " << valueString(instr) << endl;
            for (auto i : instrs) {
              cout << tab(1) << valueString(i) << endl;
            }
            auto rd = instrs[0];
            auto pLd = instrs[1];
            auto pSt = instrs[2];
            auto pFw = instrs[3];

            if (!LoadInst::classof(pLd) ||
                !StoreInst::classof(pSt) ||
                !isFifoWrite(pFw)) {
              continue;
            }

            cout << "Found possible fifo rw opt sequence" << endl;
            auto rdReg = rd->getOperand(0);
            auto ldTarget = pLd->getOperand(0);
            auto stValue = pSt->getOperand(0);
            auto stTarget = pSt->getOperand(1);
            auto writeReg = pFw->getOperand(1);

            if ((rdReg == ldTarget) &&
                (pLd == stValue) &&
                (stTarget == writeReg)) {
              cout << "-- Found rw sequence to remove" << endl;
              pFw->setOperand(1, rdReg);
            }
          }
        }
      }
    }
  }

  bool isFifo(Value* v) {
    if (!PointerType::classof(v->getType())) {
      return false;
    }

    Type* u = extract<PointerType>(v->getType())->getElementType();
    if (!StructType::classof(u)) {
      return false;
    }

    return hasPrefix(extract<StructType>(u)->getName(), "builtin_fifo");
  }
  
  void optimizeFifos(Function* f) {
    // How to go about optimizing fifos?
    // Find loop nests that do not contain a fifo (linebuffer) read and fifo (linebuffer) write
    // then check that
    // - the read precedes the write
    // - the read value is immediately written to the output fifo

    // Find the loop nest that writes to the input fifo and have it write
    // to the output FIFO instead

    FunctionPassManager FPM;
    FPM.addPass(PromotePass());
    FPM.addPass(GVN());        
    FPM.addPass(SimplifyCFGPass());
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*f, FAM);

    peepholeOptimizeFifoWrites(f);

    DominatorTree dt(*f);
    LoopInfo li(dt);

    map<Value*, Value*> writeReplacements;
    map<Value*, Value*> readReplacements;    
    for (Loop* loop : li) {
      set<Instruction*> freads = fifoReads(loop);
      set<Instruction*> fwrites = fifoWrites(loop);

      cout << "# of fifo reads  = " << freads.size() << endl;
      cout << "# of fifo writes = " << fwrites.size() << endl;

      if ((freads.size() == 1) &&
          (fwrites.size() == 1)) {
        auto rd = *begin(freads);
        auto wr = *begin(fwrites);
        if (dt.dominates(rd, wr)) {
          cout << "Possible fifo transfer loop" << endl;

          auto read = rd->getOperand(0);
          cout << "Read    = " << valueString(read) << endl;
          auto written = wr->getOperand(1);
          cout << "Written = " << valueString(written) << endl;
          if (read == written) {
            cout << "Found fifo transfer loop" << endl;
            if (isFifo(rd->getOperand(1)) && isFifo(wr->getOperand(0))) {
              writeReplacements[rd->getOperand(1)] =
                wr->getOperand(0);
            } else if (isFifo(rd->getOperand(1)) && isLB(wr->getOperand(0))) {
              // cout << "Found lb replacement" << endl;
              // writeReplacements[rd->getOperand(1)] =
              //   wr->getOperand(0);
            } else if (isLB(rd->getOperand(1)) && isFifo(wr->getOperand(0))) {
              cout << "Found unneeded transfer from lb to fifo" << endl;
              readReplacements[rd->getOperand(1)] =
                wr->getOperand(0);
            } else {
              cout << "-- Not replaceable bc no pattern recognized" << endl;
              cout << tab(1) << "read source  = " << valueString(rd->getOperand(1));
              cout << tab(1) << "write source = " << valueString(wr->getOperand(0));
            }
          } else {
            cout << "-- Not replaceable bc operands dont match" << endl;
            cout << tab(1) << "read source  = " << valueString(rd->getOperand(1));
            cout << tab(1) << "write source = " << valueString(wr->getOperand(0));
          }

          // read = rd->getOperand(1);
          // if (read == written) {
          //   if (isLB(rd->getOperand(0)) && isFifo(wr->getOperand(0))) {
          //     auto lb = rd->getOperand(0);
          //     auto fifo = wr->getOperand(0);
          //     cout << "Found write from lb to fifo" << endl;
          //     readReplacements[wr->getOperand(0)] =
          //       rd->getOperand(1);
          //   }
          // }
        }
      }
    }

    // Delete all reads from keys in writeReplacements
    // Delete all writes to values in writeReplacements
    // Replace all writes to keys in writeReplacements with writes to corresponding values

    set<Instruction*> toErase;
    for (auto wr : writeReplacements) {
      auto oldReceiver = wr.first;
      auto newReceiver = wr.second;

      cout << "Old receiver = " << valueString(oldReceiver) << endl;
      cout << "New receiver = " << valueString(newReceiver) << endl;

      for (auto instr : allInstrs(f)) {
        if (isFifoRead(instr) && (instr->getOperand(1) == oldReceiver)) {
          toErase.insert(instr);
        }

        if (isFifoWrite(instr) && (instr->getOperand(0) == newReceiver)) {
          toErase.insert(instr);
        }

        if (isFifoWrite(instr) && (instr->getOperand(0) == oldReceiver)) {
          instr->setOperand(0, newReceiver);
        }
        
      }
    }

    // Delete all writes to receiver (value)
    // Replace all reads from receiver with reads from source
    //
    // map<Instruction*, Instruction*> rdReplace;
    // for (auto wr : readReplacements) {
    //   auto oldSource = wr.first;
    //   auto redundantReceiver = wr.second;

    //   cout << "Old source   = " << valueString(oldSource) << endl;
    //   cout << "Redundant rv = " << valueString(redundantReceiver) << endl;

    //   for (auto instr : allInstrs(f)) {
    //     if (isFifoWrite(instr) && (instr->getOperand(0) == redundantReceiver)) {
    //       cout << "Erasing write to fifo that should be replaced by lb " << endl; //valueString(instr) << endl;
    //       toErase.insert(instr);
    //     } else if (isFifoRead(instr) && (instr->getOperand(1) == redundantReceiver)) {
    //       CallInst* call = CallInst::Create(lbReadFunction(oldSource), {instr->getOperand(0), oldSource});
    //       //call->insertBefore(instr);
    //       rdReplace[instr] = call;
    //       //instr->setOperand(0, oldSource);
    //       toErase.insert(instr);
    //     } else if (isFifoRead(instr) && (instr->getOperand(1) == oldSource)) {
    //       toErase.insert(instr);
    //     }
    //     // if (isFifoWrite(instr) && (instr->getOperand(0) == oldReceiver)) {
    //     //   instr->setOperand(0, newReceiver);
    //     // }
        
    //   }
    // }

    // assert(false);

    // for (auto rd : rdReplace) {
    //   rd.first->insertBefore(rd.second);
    // }
    
    for (auto e : toErase) {
      e->eraseFromParent();
    }

    runCleanupPasses(f);

    cout << "After fifo removal" << endl;
    cout << valueString(f) << endl;
    
  }

  bool setWenOp(Instruction* instr) {
    if (isBuiltinPortWrite(instr)) {
      string name = getPortName(instr);
      if ((name == "wen") || (name == "write_valid")) {
        return true;
      }
    }

    return false;
  }

  void removeLoopBounds(Function* rewritten) {
    DominatorTree dt(*rewritten);
    LoopInfo li(dt);

    for (Loop* loop : li) {
      //assert(loop->getBlocks().size() == 1);
      BasicBlock* latch = loop->getLoopLatch();
      assert(latch != nullptr);

      BranchInst* br = extract<BranchInst>(latch->getTerminator());
      assert(br->getNumSuccessors() == 2);
      BasicBlock* tBlk = br->getSuccessor(0);
      BasicBlock* fBlk = br->getSuccessor(1);

      int loopBlockInd = 0;
      if (loop->contains(tBlk)) {
        loopBlockInd = 0;
      } else {
        assert(loop->contains(fBlk));
        loopBlockInd = 1;
      }

      Value* oldCond = br->getOperand(0);
      if (loopBlockInd == 0) {
        br->setOperand(0, mkInt(1, 1));
      } else {
        br->setOperand(0, mkInt(0, 1));
      }

      PHINode* node = nullptr;
      for (auto& instrR : *latch) {
        if (PHINode::classof(&instrR)) {
          node = dyn_cast<PHINode>(&instrR);
          break;
        }
      }

      auto nodeReplace = mkInt(0, getTypeBitWidth(node->getType()));
      node->replaceAllUsesWith(nodeReplace);
      node->eraseFromParent();
      RecursivelyDeleteTriviallyDeadInstructions(oldCond);

      cout << "Done deleting" << endl;
    }

    cout << "After top level bounds deletion" << endl;
    cout << valueString(rewritten) << endl;
  }
  
  void predicateFifoWrites(Function* rewritten) {
    DominatorTree dt(*rewritten);
    LoopInfo li(dt);

    for (Loop* loop : li) {
      if (loop->getBlocks().size() == 3) {
        cout << "Post inlining loop has blocks" << endl;
        for (auto blk : loop->getBlocks()) {
          cout << valueString(blk) << endl;
        }

        assert(loop->getBlocks().size() == 3);
        BasicBlock* exit = loop->getExitingBlock();
        assert(exit != nullptr);

        BasicBlock* header = loop->getHeader();
        assert(header != nullptr);

        BranchInst* headerBr = extract<BranchInst>(header->getTerminator());
        assert(headerBr->getNumSuccessors() == 2);

        BasicBlock* opBlock =
          headerBr->getSuccessor(0) == exit ? headerBr->getSuccessor(1) : headerBr->getSuccessor(0);

        Value* brCond = headerBr->getOperand(0);
        cout << "Header condition = " << valueString(brCond) << endl;

        for (auto& instrR : *opBlock) {
          auto instr = &instrR;
          if (setWenOp(instr)) {
            instr->setOperand(1, brCond);
          }
        }

        // NOTE: Assumes there is only one phi node to replace
        for (auto& instrR : *exit) {
          auto instr = &instrR;
          if (PHINode::classof(instr)) {
            auto phi = dyn_cast<PHINode>(instr);
            cout << "Found phi = " << valueString(phi) << " in end block" << endl;
            assert(phi->getNumIncomingValues() == 2);

            Value* headerInd = phi->getIncomingValueForBlock(header);
            Value* opInd = phi->getIncomingValueForBlock(opBlock);

            cout << "headerInd = " << valueString(headerInd) << endl;
            cout << "opInd     = " << valueString(opInd) << endl;
            
            // TODO: Check the branch ordering
            SelectInst* sel = SelectInst::Create(brCond, opInd, headerInd);

            sel->insertBefore(phi);
            phi->replaceAllUsesWith(sel);

            for (auto& piR : *header) {
              auto pi = &piR;
              if (PHINode::classof(pi)) {
                auto phiN = dyn_cast<PHINode>(pi);
                phiN->setIncomingValue(phiN->getBasicBlockIndex(exit), sel);
              }
            }
            // opInd->replaceAllUsesWith(sel);
            //phi->eraseFromParent();
            break;
          }
        }

        cout << "Done replacing phis" << endl;
        cout << valueString(rewritten) << endl;
        
        IRBuilder<> hBuilder(header);
        hBuilder.CreateBr(opBlock);

        exit->removePredecessor(header);
        headerBr->eraseFromParent();
      }
    }

    runCleanupPasses(rewritten);

    cout << "After valid predication" << endl;
    cout << valueString(rewritten) << endl;
  }

  void optimizeRAMs(Function* rewritten) {
    // RAM transformations?
    set<Instruction*> ramOps;
    map<Value*, map<Value*, Value*> > ramsToWrittenValues;
    map<Value*, set<Value*> > ramsToReads;
    for (auto instr : allInstrs(rewritten)) {
      if (isRAMWrite(instr)) {
        cout << valueString(instr) << " is ram write"  << endl;
        ramsToWrittenValues[instr->getOperand(0)][instr->getOperand(1)] =
          instr->getOperand(2);
      } else if (isRAMRead(instr)) {
        ramsToReads[instr->getOperand(0)].insert(instr);
      }
    }

    cout << "RAM writes" << endl;
    map<Value*, map<int, int> > ramsToConstValues;
    for (auto rm : ramsToWrittenValues) {
      cout << tab(1) << valueString(rm.first) << endl;
      for (auto ir : rm.second) {
        Value* addr = ir.first;
        Value* val = ir.second;

        if (ConstantInt::classof(addr) &&
            ConstantInt::classof(val)) {
          int addrI = getInt(addr);
          int valI = getInt(val);

          ramsToConstValues[rm.first][addrI] = valI;
        }
        cout << tab(2) << valueString(ir.first) << " -> " << valueString(ir.second) << endl;

      }
    }

    cout << "RAM constants" << endl;
    for (auto rm : ramsToConstValues) {
      cout << tab(1) << valueString(rm.first) << endl;
      for (auto ir : rm.second) {
        auto addr = ir.first;
        auto val = ir.second;
        cout << addr << " -> " << val << endl;
      }      
    }

    set<Instruction*> toErase;
    
    for (auto ram : ramsToReads) {
      if (contains_key(ram.first, ramsToConstValues)) {
        cout << valueString(ram.first) << "is const ram" << endl;
        for (auto rd : ram.second) {
          cout << "rd = " << valueString(rd) << endl;
          assert(Instruction::classof(rd));
          int addr = getInt(dyn_cast<Instruction>(rd)->getOperand(1));
          int valueI = map_find(addr, ramsToConstValues[ram.first]);
          Value* value = mkInt(valueI, getValueBitWidth(rd));
          cout << "Replacing " << valueString(rd) << " with " << valueString(value) << endl;
          rd->replaceAllUsesWith(value);
          toErase.insert(dyn_cast<Instruction>(rd));
          //dyn_cast<Instruction>(rd)->eraseFromParent();
        }
      }
    }

    // For now assume only use of rams is as kernels
    for (auto instr : allInstrs(rewritten)) {
      if (isRAMWrite(instr)) {
        toErase.insert(instr);
        //instr->eraseFromParent();
      } else if (AllocaInst::classof(instr)) {
        
        // if (isRAMType(getPointedToType(instr->getType()))) {
        //   //instr->eraseFromParent();
        //   toErase.insert(instr);
        // }
      } else {
        cout << "Not erasing " << valueString(instr) << endl;
      }
    }

    for (auto instr : toErase) {
      assert(elem(instr, allInstrs(rewritten)));
      cout << "Erasing instruction " << valueString(instr) << endl;
      
      instr->eraseFromParent();
    }

    toErase = {};
    for (auto instr : allInstrs(rewritten)) {
      if (AllocaInst::classof(instr)) {
        
        if (isRAMType(getPointedToType(instr->getType()))) {
          //instr->eraseFromParent();
          toErase.insert(instr);
        }
      } 
    }

    for (auto instr : toErase) {
      assert(elem(instr, allInstrs(rewritten)));
      cout << "Erasing instruction " << valueString(instr) << endl;
      instr->eraseFromParent();
    }
  }
  
  MicroArchitecture halideArch(Function* f, HalideArchSettings settings) {
    Function* rewritten =
      rewriteHalideStencils(f);

    optimizeModuleLLVM(*(rewritten->getParent()));
    optimizeStores(rewritten);
    
    cout << "Rewritten function" << endl;
    cout << valueString(rewritten) << endl;

    InterfaceFunctions interfaces;
    set<string> funcs;

    for (auto& bb : rewritten->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        if (CallInst::classof(instr)) {
          CallInst* ci = dyn_cast<CallInst>(instr);
          Function* func = ci->getCalledFunction();
          string name = ci->getCalledFunction()->getName();
          if (!elem(name, funcs)) {

            if (hasPrefix(name, "hls.slice") ||
                hasPrefix(name, "hls.max") ||
                hasPrefix(name, "hls.min")) {
              continue;
            }

            interfaces.addFunction(func);
            
            if (hasPrefix(name, "fifo_read_ref")) {
              if (!settings.pushFifos) {
                implementRVFifoReadRef(func, interfaces.getConstraints(func));
              } else {
                cout << "Implementing push read" << endl;
                implementPushFifoReadRef(func, interfaces.getConstraints(func));
              }
            } else if (hasPrefix(name, "fifo_write_ref")) {
              if (!settings.pushFifos) {
                implementRVFifoWriteRef(func, interfaces.getConstraints(func));
              } else {
                cout << "Implementing push write" << endl;                
                implementPushFifoWriteRef(func, interfaces.getConstraints(func));
              }
            } else if (hasPrefix(name, "lb_has_valid")) {
              implementLBHasValidData(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "ram.write.")) {
              implementRAMWrite0(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "ram.read.")) {
              implementRAMRead0(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "lb_push.")) {
              implementLBPush(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "lb_pop.")) {
              implementLBPop(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "hls.slice") ||
                       hasPrefix(name, "hls.max") ||
                       hasPrefix(name, "hls.min")) {
            } else {
              cout << "Error: Unsupported call " << valueString(ci) << endl;
              assert(false);
            }
            funcs.insert(name);
          }
        }
      }
    }


    cout << "Before RAM opts" << endl;
    cout << valueString(rewritten) << endl;

    optimizeRAMs(rewritten);
    
    cout << "After RAM optimization" << endl;
    cout << valueString(rewritten) << endl;

    if (settings.optimizeFifos) {
      optimizeFifos(rewritten);
    }

    if (settings.forToWhile) {
      forToWhileLoopOpt(rewritten, settings);
    }

    ExecutionConstraints exec;

    //addDataConstraints(rewritten, exec);
    inlineWireCalls(rewritten, exec, interfaces);

    DominatorTree DT(*rewritten);
    SmallVector<AllocaInst *, 200> PromotableAllocas;

    // For now assume all integer allocas are promotable
    for (auto instr : allInstrs(rewritten)) {
      if (AllocaInst::classof(instr)) {
        if (IntegerType::classof(getPointedToType(instr->getType()))) {
          PromotableAllocas.push_back(dyn_cast<AllocaInst>(instr));
        }
      }
    }
    PromoteMemToReg(PromotableAllocas, DT);

    optimizeModuleLLVM(*(rewritten->getParent()));
    optimizeStores(rewritten);

    FunctionPassManager FPM;
    FPM.addPass(SimplifyCFGPass());
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*rewritten, FAM);

    if (settings.predicateFifoWrites) {
      predicateFifoWrites(rewritten);
    }

    if (settings.removeLoopBounds) {
      removeLoopBounds(rewritten);
    }
    
    clearExecutionConstraints(rewritten, exec);
    
    addDataConstraints(rewritten, exec);

    set<TaskSpec> tasks;
    if (settings.loopTasks) {
      tasks = halideTaskSpecs(rewritten);
    } else {
      tasks = {wholeFunctionTask(rewritten)};
    }
    exec.tasks = tasks;

    std::set<PipelineSpec> toPipeline;
    // for (auto task : exec.tasks) {
    //   PipelineSpec s;
    //   s.staticII = 1;
    //   for (auto blk : task.blks) {
    //     s.blks.insert(blk);
    //   }
    //   toPipeline.insert(s);
    // }
    
    // Now: Populate HLS data structures
    HardwareConstraints hcs = standardConstraints();
    assignModuleSpecs(rewritten, hcs, settings);
    
    cout << "After inlining" << endl;
    cout << valueString(rewritten) << endl;
    auto preds = buildControlPreds(rewritten);

    SchedulingProblem p = createSchedulingProblem(rewritten, hcs, toPipeline, tasks, preds);
    exec.addConstraints(p, rewritten);

    map<Function*, SchedulingProblem> constraints{{rewritten, p}};
    Schedule s = scheduleFunction(rewritten, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, rewritten);
    cout << "STG is" << endl;
    graph.print(cout);

    std::map<Value*, int> memoryMap;
    MicroArchitecture arch = buildMicroArchitecture(graph, memoryMap, hcs);

    return arch;
  }


}
