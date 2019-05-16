#include "parser.h"

#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Scalar.h"
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Analysis/LoopAccessAnalysis.h>
#include <llvm/Analysis/ScalarEvolution.h>

#include <functional>

#include "verilog_backend.h"
#include "test_utils.h"

using namespace dbhc;
using namespace std;

namespace ahaHLS {

  maybe<Token> parseStr(const std::string target, TokenState& chars) {
    string str = "";
    for (int i = 0; i < (int) target.size(); i++) {
      if (chars.atEnd()) {
        return maybe<Token>();
      }

      char next = chars.parseChar();
      if (target[i] == next) {
        str += next;
      } else {
        return maybe<Token>();
      }
    }
  
    return maybe<Token>(Token(str));
  }

  std::function<maybe<Token>(TokenState& chars)> mkParseStr(const std::string str) {
    return [str](TokenState& state) { return parseStr(str, state); };
  }

  maybe<Token> parseComment(TokenState& state) {
    // Parse any number of comment lines and whitespace
    auto result = tryParse<Token>(mkParseStr("//"), state);
    if (result.has_value()) {
      while (!state.atEnd() && !(state.peekChar() == '\n')) {
        state.parseChar();
      }

      if (!state.atEnd()) {
        cout << "Parsing end char" << endl;
        state.parseChar();
      }

      return Token("//");

    } else {
      return maybe<Token>();
    }

  }

  maybe<FunctionCall*> parseFunctionCall(ParseState<Token>& tokens) {
    Token t = tokens.parseChar();
    if (!t.isId()) {
      return maybe<FunctionCall*>();
    }

    Token paren = tokens.parseChar();
    if (paren != Token("(")) {
      return maybe<FunctionCall*>();
    }

    //cout << "parsing funcall " << tokens.remainder() << endl;
    vector<Expression*> callArgs =
      sepBtwn0<Expression*, Token>(parseExpressionMaybe, parseComma, tokens);

    paren = tokens.parseChar();
    if (paren != Token(")")) {
      return maybe<FunctionCall*>();
    }

    return new FunctionCall(t, callArgs);
  }

  maybe<Expression*> parseExpressionMaybe(ParseState<Token>& tokens) {
    //cout << "-- Parsing expression " << tokens.remainder() << endl;

    vector<Token> operatorStack;
    vector<Expression*> postfixString;
  
    while (true) {
      auto pExpr = parsePrimitiveExpressionMaybe(tokens);
      //cout << "After primitive expr = " << tokens.remainder() << endl;
      if (!pExpr.has_value()) {
        break;
      }

      postfixString.push_back(pExpr.get_value());
    
      if (tokens.atEnd() || !isBinop(tokens.peekChar())) {
        break;
      }

      Token binop = tokens.parseChar();
      if (!isBinop(binop)) {
        break;
      }

      //cout << "Adding binop " << binop << endl;
      if (operatorStack.size() == 0) {
        //cout << tab(1) << "Op stack empty " << binop << endl;      
        operatorStack.push_back(binop);
      } else if (precedence(binop) > precedence(operatorStack.back())) {
        //cout << tab(1) << "Op has higher precedence " << binop << endl;      
        operatorStack.push_back(binop);
      } else {
        while (true) {
          Token topOp = operatorStack.back();
          operatorStack.pop_back();

          //cout << "Popping " << topOp << " from op stack" << endl;

          postfixString.push_back(new Identifier(topOp));
        
          if ((operatorStack.size() == 0) ||
              (precedence(binop) > precedence(operatorStack.back()))) {
            break;
          }
        }

        operatorStack.push_back(binop);
      }
    }

    // Pop and print all operators on the stack
    //cout << "Adding ops" << endl;
    // Reverse order of this?
    for (auto op : operatorStack) {
      //cout << tab(1) << "Popping operator " << op << endl;
      postfixString.push_back(new Identifier(op));
    }

    if (postfixString.size() == 0) {
      return maybe<Expression*>();
    }

    //cout << "Building final value" << endl;
    //cout << "Postfix string" << endl;
    // for (auto s : postfixString) {
    //   cout << tab(1) << *s << endl;
    // }

    Expression* final = popOperand(postfixString);
    assert(postfixString.size() == 0);
    assert(final != nullptr);

    //cout << "Returning expression " << *final << endl;
    return final;
  }

  Expression* parseExpression(ParseState<Token>& tokens) {
    auto res = parseExpressionMaybe(tokens);
    if (res.has_value()) {
      return res.get_value();
    }

    assert(false);
  }

  maybe<Statement*> parseHazard(ParseState<Token>& tokens) {
    if (!tokens.nextCharIs(Token("hazard"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    if (tokens.peekChar() == Token("(")) {
      assert(tokens.parseChar() == Token("("));

      vector<ArgumentDecl*> args =
        sepBtwn0<ArgumentDecl*, Token>(parseArgDeclMaybe, parseComma, tokens);

      assert(tokens.parseChar() == Token(")"));

      assert(tokens.parseChar() == Token("{"));

      vector<Statement*> funcStmts =
        many<Statement*>(parseStatement, tokens);

      //cout << "After hazard = " << tokens.remainder() << endl;

      assert(tokens.parseChar() == Token("}"));
    
      return new HazardDecl(args, funcStmts);
    }

    return maybe<Statement*>();
  }
  
  maybe<Statement*> parsePipeline(ParseState<Token>& tokens) {
    if (!tokens.nextCharIs(Token("pipeline"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    auto iiExpr = parseExpressionMaybe(tokens);
    if (!iiExpr.has_value()) {
      return maybe<Statement*>();
    }

    if (!tokens.nextCharIs(Token("{"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    auto stmts = many<Statement*>(parseStatement, tokens);

    if (!tokens.nextCharIs(Token("}"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();
    

    return new PipelineBlock(iiExpr.get_value(), stmts);
  }
  
  maybe<Statement*> parseForLoop(ParseState<Token>& tokens) {

    //cout << "Parsing for loop " << tokens.remainder() << endl;

    if (!tokens.nextCharIs(Token("for"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    //cout << "for loop decl " << tokens.remainder() << endl;  

    if (!tokens.nextCharIs(Token("("))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    //cout << "Getting for init " << tokens.remainder() << endl;
  
    auto init = parseStatement(tokens);
    if (!init.has_value()) {
      return maybe<Statement*>();
    }

    //cout << "Getting for test " << tokens.remainder() << endl;

    auto test = parseExpressionMaybe(tokens);
    if (!test.has_value()) {
      return maybe<Statement*>();
    }
  
    if (!tokens.nextCharIs(Token(";"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    auto update = parseStatement(tokens);
    if (!update.has_value()) {
      return maybe<Statement*>();
    }
  
    if (!tokens.nextCharIs(Token(")"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    if (!tokens.nextCharIs(Token("{"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    auto stmts = many<Statement*>(parseStatement, tokens);

    if (!tokens.nextCharIs(Token("}"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    return new ForStmt(init.get_value(), test.get_value(), update.get_value(), stmts);
  
  }

  maybe<ArgumentDecl*> parseStructFieldMaybe(ParseState<Token>& tokens) {

    auto decl = parseArgDeclMaybe(tokens);
    if (!decl.has_value()) {
      return maybe<ArgumentDecl*>();
    }

    if (!tokens.nextCharIs(Token(";"))) {
      return maybe<ArgumentDecl*>();
    }
    tokens.parseChar();

    return decl;
  }
  
  maybe<Statement*> parseStructStmt(ParseState<Token>& tokens) {
    if (tokens.nextCharIs(Token("struct"))) {
      tokens.parseChar();

      cout << "Parsing struct " << tokens.remainder() << endl;

      Token name = tokens.peekChar();
      tokens.parseChar();

      if (!tokens.nextCharIs(Token("{"))) {
        return maybe<Statement*>();
      }
      tokens.parseChar();

      cout << "Parsing fields " << tokens.remainder() << endl;
      
      vector<ArgumentDecl*> fields =
        many<ArgumentDecl*, Token>(parseStructFieldMaybe, tokens);

      if (!tokens.nextCharIs(Token("}"))) {
        return maybe<Statement*>();
      }
      tokens.parseChar();

      cout << "Got fields " << tokens.remainder() << endl;      

      if (!tokens.nextCharIs(Token(";"))) {
        return maybe<Statement*>();
      }
      tokens.parseChar();

      return new StructDecl(name, fields);
    }

    return maybe<Statement*>();
  }
  
  maybe<Statement*> parseStatementNoLabel(ParseState<Token>& tokens) {
    // Try to parse for loop

    auto structStmt = tryParse<Statement*>(parseStructStmt, tokens);
    if (structStmt.has_value()) {
      return structStmt;
    }
    
    auto doStmt = tryParse<Statement*>(parseDoWhileLoop, tokens);
    if (doStmt.has_value()) {
      return doStmt;
    }

    auto forStmt = tryParse<Statement*>(parseForLoop, tokens);
    if (forStmt.has_value()) {
      return forStmt;
    }

    auto pipeStmt = tryParse<Statement*>(parsePipeline, tokens);
    if (pipeStmt.has_value()) {
      return pipeStmt;
    }

    auto hazardStmt = tryParse<Statement*>(parseHazard, tokens);
    if (hazardStmt.has_value()) {
      return hazardStmt;
    }
    
    if (tokens.peekChar() == Token("return")) {
      tokens.parseChar();
      auto e = parseExpressionMaybe(tokens);
      if (e.has_value()) {
        if (tokens.nextCharIs(Token(";"))) {
          tokens.parseChar();
          return new ReturnStmt(e.get_value());
        } else {
          return maybe<Statement*>();
        }
      } else {

        if (tokens.nextCharIs(Token(";"))) {
          tokens.parseChar();
          return new ReturnStmt();
        } else {
          return maybe<Statement*>();
        }

      }
    }
  
    if (tokens.peekChar() == Token("class")) {
      tokens.parseChar();
      Token name = tokens.parseChar();

      assert(tokens.parseChar() == Token("{"));

      vector<Statement*> classStmts =
        many<Statement*>(parseStatement, tokens);

      assert(tokens.parseChar() == Token("}"));
      assert(tokens.parseChar() == Token(";"));

      return new ClassDecl(name, classStmts);
    }

    maybe<Statement*> funcDecl =
      tryParse<Statement*>(parseFuncDecl, tokens);

    if (funcDecl.has_value()) {
      return funcDecl;
    }

    //cout << "Statement after trying funcDecl " << tokens.remainder() << endl;  

    auto assign = tryParse<Statement*>(parseAssignStmt, tokens);
    if (assign.has_value()) {
      if (tokens.nextCharIs(Token(";"))) {
        tokens.parseChar();
      }
      return assign;
    }

    //cout << "Statement after assign " << tokens.remainder() << endl;

    // Should do: tryParse function declaration
    // Then: tryParse member declaration
    int posBefore = tokens.currentPos();
    auto decl = tryParse<ArgumentDecl*>(parseArgDeclMaybe, tokens);
  
    if (decl.has_value()) {
      if (tokens.peekChar() == Token(";")) {
        tokens.parseChar();
        return decl.get_value();
      }
    }

    tokens.setPos(posBefore);

    auto call = tryParse<Expression*>(parseExpressionMaybe, tokens);

    if (call.has_value() && tokens.nextCharIs(Token(";"))) {
      tokens.parseChar();
      return new ExpressionStmt(call.get_value());
    }


    return maybe<Statement*>();
  }

  maybe<Statement*> parseStatement(ParseState<Token>& tokens) {
    //cout << "Starting to parse statement " << tokens.remainder() << endl;
  
    if (tokens.atEnd()) {
      return maybe<Statement*>();
    }
  
    // Try to parse a label?
    auto label = tryParse<Token>(parseLabel, tokens);
  
    auto stmt = parseStatementNoLabel(tokens);

    if (!stmt.has_value()) {
      return maybe<Statement*>();
    }

    if (label.has_value()) {
      auto stmtV = stmt.get_value();
      stmtV->setLabel(label.get_value());
      return stmtV;
    }
    return stmt;
  }

  void optimizeModuleLLVM(SynthCppModule& mod);
  void optimizeModuleLLVM(llvm::Module& mod);

  void setZeroRows(TestBenchSpec& tb, const int cycleNo, const int stencilWidth, const int loadWidth, vector<Argument*> words) {
    for (int row = 0; row < stencilWidth; row++) {
      auto word = words[row];
      string values = "";
      for (int col = 0; col < loadWidth; col++) {
        values += "8'd0";
        if (col != (loadWidth - 1)) {
          values += ",";
        }
      }
      tb.setArgPort(word, "in_wire", cycleNo,
                    "{" + values + "}");
    }
  }


  // Simpler store elimination, since our formulation has no aliasing by
  // construction
  void optimizeStores(llvm::Function* f) {
    bool erased = true;
    while (erased) {
      erased = false;
      for (auto& bb : f->getBasicBlockList()) {
        for (auto& instr : bb) {
          //int numUses = instr.getNumUses();

          if (AllocaInst::classof(&instr)) {
            bool allStores = true;
            for (auto& user : instr.uses()) {
              if (!StoreInst::classof(user.getUser())) {
                allStores = false;
              }
            }

            if (allStores) {

              cout << "All uses of " << valueString(&instr) << " are stores" << endl;
              for (auto& user : instr.uses()) {
                cout << "Erasing " << valueString(user) << endl;
                dyn_cast<Instruction>(user.getUser())->eraseFromParent();
              }

              instr.eraseFromParent();
            
              erased = true;
              break;
            }
          }
        }

        if (erased) {
          break;
        }
      }
    }
  }

  MemorySpec pss(const int width) {
    return {0, 0, 1, 1, width, 1, false, {{{"width", std::to_string(width)}}, "reg_passthrough"}};
  }

  bool isPresent(InstructionTime& time, llvm::Function* const f) {
    ExecutionAction action = time.action;
    if (action.isTag()) {
      return true;
    }

    if (action.isBasicBlock()) {
      BasicBlock* bb = action.getBasicBlock();
      for (auto& other : f->getBasicBlockList()) {
        if (bb == &other) {
          return true;
        }
      }

      return false;
    }

    if (action.isInstruction()) {
      Instruction* instr = action.getInstruction();
      for (auto& bb : f->getBasicBlockList()) {
        for (auto& other : bb) {
          if (instr == &other) {
            return true;
          }
        }
      }

      return false;
    }

    return false;
  }

  void clearExecutionConstraints(llvm::Function* const f,
                                 ExecutionConstraints& exec) {
    set<ExecutionConstraint*> toRemove;
    for (auto c : exec.constraints) {
      if (c->type() == CONSTRAINT_TYPE_ORDERED) {
        auto oc = static_cast<Ordered*>(c);
        bool startPresent = isPresent(oc->before, f);
        bool endPresent = isPresent(oc->after, f);

        if (!startPresent || !endPresent) {
          toRemove.insert(c);
        }
      } else {
        assert(false);
      }
    }

    for (auto r : toRemove) {
      exec.remove(r);
    }
  }

  // Challenges for added hazards
  // * Inlining pipelined loops
  // * Representing initiation intervals and dependence distances in ExecutionConstraints
  // * Finding method calls that match a hazard with name mangling
  // * Finding initiation intervals in solved scheduling problem after inlining
  // * Confusion about relationship between SchedulingProblem and ExecutionConstraints

  // What flow would I like:
  // 1. All scheduling constraints added to ExecutionConstraints
  // 2. Execution constraints lowered in to a SchedulingProblem
  // 3. Solve scheduling problem
  // 4. Extract ExecutionConstraints
  Schedule scheduleInterfaceZeroReg(SynthCppModule& mod,
                                    // Top level function
                                    SynthCppFunction* sf,
                                    ExecutionConstraints& exec) {

    auto& hcs = mod.getHardwareConstraints();
    auto& interfaces = mod.getInterfaceFunctions();
    auto f = sf->llvmFunction();
    auto& toPipeline = sf->pipelines;

    // Need to add SynthCppModule as an argument. Then iterate over
    // each pair of instructions and check if it matches the hazard
    // condition.
    // cout << "Classes and hazards" << endl;
    // for (auto cl : mod.classes) {
    //   cout << "Hazards in " << cl->getName() << endl;
    //   for (auto h : cl->hazards) {
    //     cout << tab(1) << h.sourceMethod << ", " << h.sinkMethod << endl;
    //   }
    // }

    cout << "Before inlining" << endl;
    cout << valueString(f) << endl;

    addDataConstraints(f, exec);

    // Problems:
    // * One is that currently ExecutionConstraints
    // only model constraints on the starts and ends of instructions
    // they do not model constraints on the relative start and end times
    // of different instances of instructions in a trace.
    // * I have not added inter-call constraints to the language syntax
    // * I need to preserve the results of inter-call constraints during
    // inlining

    // There is a tension between expressive models of built-in hardware
    // (read / write port) and the ability to write constraints on larger
    // operations.

    // Q: Why couldnt I just start by adding pipeline constraints to exec
    // and then letting the values inside them be inlined?
    // A: Because the execution constraints in normal pipelining involve
    // II, but ExecutionConstraints only allows order constraints that
    // fit in difference logic

    // Q: Maybe the thing to do is to start by writing code to do hazard
    // analysis before inlining?

    // Other angles: HLS for mixed signal? Interaction with analog components?

    // TODO: Before inlining add special function hazards to the memory
    // Note: I will need SCEV no matter what, and probably alias analysis too

    exec.toPipeline = toPipeline;

    optimizeModuleLLVM(*(f->getParent()));
    // No stores
    optimizeStores(f);
    clearExecutionConstraints(f, exec);

    createMemoryConstraints(f, hcs, exec);


    inlineWireCalls(f, exec, interfaces);

    cout << "Immediately after inlining" << endl;
    cout << valueString(f) << endl;
    
    // TODO: Where to put this stuff
    optimizeModuleLLVM(*(f->getParent()));
    optimizeStores(f);
    clearExecutionConstraints(f, exec);
  
    cout << "After inlining and store optimization" << endl;
    cout << valueString(f) << endl;

    setAllAllocaMemTypes(hcs, f, pss(32));
    hcs.memoryMapping =
      memoryOpLocations(f);

    // Single load optimization
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        int numUsers = instr->getNumUses();

        if ((BinaryOperator::classof(instr) ||
             UnaryInstruction::classof(instr) ||
             LoadInst::classof(instr) ||
             CmpInst::classof(instr))
            && (numUsers == 1)) {
          auto& user = *(instr->uses().begin());
          assert(Instruction::classof(user));
          auto userInstr = dyn_cast<Instruction>(user.getUser());
          exec.add(instrEnd(instr) == instrStart(userInstr));
        }
      }
    }

    // cout << "Hardware memory storage names" << endl;
    // for (auto mspec : hcs.memSpecs) {
    //   cout << valueString(mspec.first) << " -> " << mspec.second.modSpec.name << endl;
    // }


    auto preds = buildControlPreds(f);    
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline, preds);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    return s;
  }

  pair<string, int> extractDefault(Statement* stmt) {
    auto eStmt = extract<ExpressionStmt>(stmt);
    auto expr = eStmt->expr;
    FunctionCall* writeCall = extract<FunctionCall>(expr);
    assert(writeCall->getName() == "write_port");
    Expression* portId = writeCall->args[0];
    Identifier* id = extract<Identifier>(portId);
    Expression* portVal = writeCall->args[1];
    IntegerExpr* val = extract<IntegerExpr>(portVal);

    return {id->getName(), val->getInt()};
  }

  int countTerminators(const BasicBlock& bb) {
    int numTerminators = 0;
    for (auto& instr : bb) {
      if (TerminatorInst::classof(&instr)) {
        numTerminators++;
      }
    }

    return numTerminators;
  }

  void sanityCheck(llvm::Function* f) {
    for (auto& bb : f->getBasicBlockList()) {
      int numTerminators = countTerminators(bb);
      if (numTerminators != 1) {
        cout << "Error: In function " << endl;
        cout << valueString(f) << endl;
        cout << "basic block " << endl;
        cout << valueString(&bb) << " has zero or multiple terminators" << endl;
        assert(false);
      }
    }
  }

  // Idea: Caller constraints that inline in to each user of a function?
  // For each called user function check if caller constraints are satisified
  // and if not propagate them up the stack? A form of type checking I suppose?
  void optimizeModuleLLVM(llvm::Module& mod) {
    llvm::legacy::PassManager pm;
    pm.add(new LoopInfoWrapperPass());
    pm.add(new AAResultsWrapperPass());
    pm.add(new TargetLibraryInfoWrapperPass());
    pm.add(createGVNPass());
    pm.add(createDeadStoreEliminationPass());
      
    pm.run(mod);
  }

  void optimizeModuleLLVM(SynthCppModule& scppMod) {
    optimizeModuleLLVM(*(scppMod.mod.get()));
  }

  MicroArchitecture
  synthesizeVerilog(SynthCppModule& scppMod, const std::string& funcName) {
    SynthCppFunction* f = scppMod.getFunction(funcName);

    // Q: How do we pass the hardware constraints on f in to the synthesis flow?
    cout << "Scheduling function" << endl;
    cout << valueString(f->llvmFunction()) << endl;

    cout << "In synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
    for (auto func : scppMod.getInterfaceFunctions().constraints) {
      cout << tab(1) << "# of constraints on " <<
        string(func.first->getName()) << " = " <<
        func.second.constraints.size() << endl;
    }

    // Set pointers to primitives to be registers, not memories
    for (auto& arg : f->llvmFunction()->args()) {
      Type* argTp = arg.getType();
      if (PointerType::classof(argTp)) {
        Type* underlying = dyn_cast<PointerType>(argTp)->getElementType();
        if (IntegerType::classof(underlying)) {
          cout << "Should set " << valueString(&arg) << " to be register" << endl;
          scppMod.getHardwareConstraints().modSpecs.insert({&arg, registerModSpec(getTypeBitWidth(underlying))});
          scppMod.getHardwareConstraints().memSpecs.insert({&arg, registerSpec(getTypeBitWidth(underlying))});
        }
      }
    }
  
    Schedule s =
      scheduleInterfaceZeroReg(scppMod,
                               f,
                               scppMod.getInterfaceFunctions().getConstraints(f->llvmFunction()));

    STG graph = buildSTG(s, f->llvmFunction());

    // TODO: Generate these automatically, or change generation code
    // to treat LLVM i<N> as builtin?

    // cout << "Hardware memory constraints before " << endl;
    // for (auto mspec : scppMod.getHardwareConstraints().memSpecs) {
    //   cout << valueString(mspec.first) << " -> " << mspec.second.modSpec.name << endl;
    // }
  
    //setAllAllocaMemTypes(scppMod.getHardwareConstraints(), f->llvmFunction(), registerSpec(32));

    cout << "STG is" << endl;
    graph.print(cout);

    map<Value*, int> layout;  
    auto arch = buildMicroArchitecture(graph, layout, scppMod.getHardwareConstraints());

    VerilogDebugInfo info;
    emitVerilog(arch, info);

    return arch;
  }

  BasicBlock*
  SynthCppModule::addBB(const std::string& name, llvm::Function* const f) {
    auto bb = mkBB(name, f);
    if (cgs.inPipeline) {
      cgs.activePipeline.blks.insert(bb);
    }

    return bb;
  }

  void SynthCppModule::pushPipeline(const int II) {
    assert(activeFunction != nullptr);
    
    cgs.activePipeline = PipelineSpec();
    cgs.activePipeline.staticII = II;
    cgs.inPipeline = true;
  }

  void SynthCppModule::popPipeline() {
    assert(cgs.inPipeline);
    cgs.inPipeline = false;

    assert(activeFunction != nullptr);

    activeFunction->pipelines.insert(cgs.activePipeline);

    auto bd = cgs.builder();
    auto* nextBB = addBB("after_pipeline_" + uniqueNumString(), activeFunction->llvmFunction());
    bd.CreateBr(nextBB);

    cgs.setActiveBlock(nextBB);
  }

  int extractInt(Expression* expr) {
    cout << "Extracting II from " << *expr << endl;
    IntegerExpr* exp = extract<IntegerExpr>(expr);
    return exp->getInt();
  }
  
  void SynthCppModule::genLLVM(PipelineBlock* const pipe) {

    cout << "Generating llvm for pipeline" << endl;
    Expression* targetII = pipe->ii;
    int ii = extractInt(targetII);

    cout << "Pushing pipeline" << endl;    
    pushPipeline(ii);

    cout << "Pushed pipeline" << endl;        
    for (auto stmt : pipe->body) {
      genLLVM(stmt);
    }

    cout << "Popping pipeline" << endl;            
    popPipeline();

    cout << "Popped pipeline" << endl;                
  }

  void SynthCppModule::addMethodDecl(FunctionDecl* methodFuncDecl,
                                     ModuleSpec& cSpec) {
    // I would like to be able to generate method
    // and function code with the same generator so
    // that I dont end up with argument duplication
    //auto methodFuncDecl = sc<FunctionDecl>(st);
    if (methodFuncDecl->getName() == "defaults") {
      for (auto stmt : methodFuncDecl->body) {
        pair<string, int> defaultValue = extractDefault(stmt);
        cSpec.defaultValues.insert(defaultValue);
      }
    } else {
      vector<Type*> argTps =
        functionInputs(methodFuncDecl);

      // cout << "Method " << methodFuncDecl->getName() << " has arg types before return value and this:" << endl;
      // for (auto a : argTps) {
      //   cout << tab(1) << typeString(a) << endl;
      // }
            
      vector<Type*> tps;
      tps.push_back(llvmTypeFor(new SynthCppPointerType(new SynthCppStructType(cgs.getActiveClass()->name))));
      for (auto a : argTps) {
        tps.push_back(a);
      }

      // cout << "Method " << methodFuncDecl->getName() << " has arg types" << endl;
      // for (auto a : tps) {
      //   cout << tab(1) << typeString(a) << endl;
      // }
      SynthCppFunction* sf = new SynthCppFunction();
      activeFunction = sf;
      sf->nameToken = methodFuncDecl->name;
      // Change voidType to the function output type
      auto f = mkFunc(tps, llvmTypeFor(methodFuncDecl->returnType), sf->getName());
      interfaces.addFunction(f);
      sf->func = f;
      sf->retType = methodFuncDecl->returnType;
      sf->constraints = &(interfaces.getConstraints(f));

      auto bb = addBB("entry_block", f);
      cgs.setActiveBlock(bb);
              
      //IRBuilder<> b(bb);

      bool hasReturn = false; //sf->hasReturnValue();
      auto bd = cgs.builder();
      setArgumentSymbols(bd, sf->symtab, methodFuncDecl->args, f, 1 + (hasReturn ? 1 : 0));
      cgs.symtab.pushTable(&(sf->symtab));
      cout << "After setting argument symbols for "  << string(f->getName()) << endl;
      cgs.symtab.print(cout);
              

      // Set "this" to have value of first argument
      Value* thisArg = getArg(f, (hasReturn ? 1 : 0));
      setValue(Token("this"), thisArg);
      for (auto stmt : methodFuncDecl->body) {
        cout << "Statement" << endl;
        genLLVM(stmt);
      }

      BasicBlock* activeBlock = &(cgs.getActiveBlock());
      //&(activeFunction->llvmFunction()->getEntryBlock());
      if (activeBlock->getTerminator() == nullptr) {
        cout << "Basic block " << valueString(activeBlock) << "has no terminator" << endl;
              
        cgs.builder().CreateRet(nullptr);
      }

      cout << "Just generated code for method " << endl;
      cout << valueString(sf->llvmFunction()) << endl;
      cgs.getActiveClass()->methods[sf->getName()] = sf;

      sanityCheck(f);
              
      //setAllAllocaMemTypes(hcs, f, registerSpec(32));
            
      activeFunction = nullptr;
    }
    
  }

  int getIndex(const std::string& fieldName,
               StructDecl* const stmt) {
    int i = 0;
    for (auto& argDec : stmt->fields) {
      if (argDec->name.getStr() == fieldName) {
        return i;
      }
      i++;
    }
    assert(false);
  }
  
  llvm::Value* SynthCppModule::structFieldPtr(Value* baseVal,
                                              const std::string& fieldName) {
    Type* baseTp = baseVal->getType();
    cout << "Base vl = " << valueString(baseVal) << endl;    
    cout << "Base tp = " << typeString(baseTp) << endl;
    assert(PointerType::classof(baseTp));
    Type* under = sc<PointerType>(baseTp)->getElementType();
    assert(StructType::classof(under));

    //StructType* stp = sc<StructType>(under);
    StructDecl* decl = map_find(under, structDefs);

    int fieldIndex = getIndex(fieldName, decl);
    cout << "Index of " << fieldName << " is " << fieldIndex << endl;
    assert(false);
  }
  
  llvm::Value* SynthCppModule::genFieldAccess(FieldAccess* const e) {
    Value* baseExpr = genLLVM(e->base);
    return structFieldPtr(baseExpr, e->field.getStr());
  }

  void SynthCppModule::addHazard(HazardDecl* hazard, ModuleSpec& cSpec) {
    auto args = hazard->args;
    assert(args.size() == 2);

    string sourceMethod = extract<SynthCppStructType>(args[0]->tp)->name.getStr();
    string sinkMethod = extract<SynthCppStructType>(args[1]->tp)->name.getStr();

    auto stmts = hazard->body;
    assert(stmts.size() == 1);

    ExpressionStmt* expS = extract<ExpressionStmt>(stmts[0]);
    Expression* expr = expS->expr;

    FunctionCall* hazardCall = extract<FunctionCall>(expr);
    assert(hazardCall->getName() == "implies");
    assert(hazardCall->args.size() == 2);
    
    //Statement* hazardSTmt = stmts[0];
    cSpec.hazards.push_back({sourceMethod, sinkMethod, hazardCall->args[0], hazardCall->args[1]});
    //cgs.getActiveClass()->hazards.push_back({sourceMethod, sinkMethod});
  }

  llvm::Value* SynthCppModule::genLLVM(Expression* const e) {
    auto bd = cgs.builder();
    
    if (Identifier::classof(e)) {

      Identifier* id = static_cast<Identifier* const>(e);
      if (!hasValue(id->name)) {
        cout << "Error: Id has no value = " << id->name << endl;        
        assert(false);
      }

      // Load the register value if we are dealing with an identifier for
      // a pointer to a piece of data? Load the pointer value
      // if we are dealing with an identifier for a pointer to a structure?

      Value* v = getValueFor(id->name);

      // TODO: Get SynthCppType instead?
      Type* tp = v->getType();
      assert(PointerType::classof(tp));
      Type* underlying = dyn_cast<PointerType>(tp)->getElementType();

      if (isData(underlying)) {
        return loadReg(bd, getValueFor(id->name));
      } else {
        assert(StructType::classof(underlying));
        return getValueFor(id->name);
      }

    } else if (BinopExpr::classof(e)) {
      BinopExpr* be = static_cast<BinopExpr* const>(e);
      auto bd = cgs.builder();
      auto l = genLLVM(be->lhs);
      auto r = genLLVM(be->rhs);

      cout << "left     = " << valueString(l) << endl;
      cout << "left tp  = " << typeString(l->getType()) << endl;
      cout << "rght tp  = " << typeString(r->getType()) << endl;

      assert(!PointerType::classof(l->getType()));
      assert(!PointerType::classof(r->getType()));

      auto lBaseType = l->getType();
      auto rBaseType = r->getType();

      if (IntegerType::classof(lBaseType) &&
          IntegerType::classof(rBaseType)) {
        if (l->getType() != r->getType()) {
          int lWidth = getTypeBitWidth(lBaseType);
          int rWidth = getTypeBitWidth(rBaseType);

          if (lWidth < rWidth) {
            l = bd.CreateSExt(l, rBaseType);
          } else {
            assert(lWidth > rWidth);
            r = bd.CreateSExt(r, lBaseType);         
          }
        }
      } else {
        assert(l->getType() == r->getType());
      }

      if (be->op.getStr() == "+") {
        return bd.CreateAdd(l, r);
      } else if (be->op.getStr() == "<") {
        return bd.CreateICmpSLT(l, r);
      } else if (be->op.getStr() == "*") {
        return bd.CreateMul(l, r);        
      } else if (be->op.getStr() == "-") {
        return bd.CreateSub(l, r);
      } else if (be->op.getStr() == "==") {
        return bd.CreateICmpEQ(l, r);
      } else {
        cout << "Error: Unsupported binop: " << be->op << endl;
        assert(false);
      }

    } else if (FunctionCall::classof(e)) {
      auto called = sc<FunctionCall>(e);

      string name = called->funcName.getStr();
      if (name == "add_constraint") {
        // TODO: Add constraint to active execonstraints
        ExecutionConstraints& exe =
          getInterfaceFunctions().getConstraints(activeFunction->llvmFunction());

        ExecutionConstraint* c =
          parseConstraint(called->args[0]);

        cout << "Adding constraint " << *c << endl;
        exe.add(c);
        return nullptr;
      }

      if ((name == "set_port") || (name == "write_port")) {
        assert(called->args.size() == 2);
        
        Expression* labelExpr = called->args[0];

        Identifier* labelId = extract<Identifier>(labelExpr);
        Expression* valueExpr = called->args[1];

        cout << "Value expression in write port is " << *valueExpr << endl;
        auto vExpr = genLLVM(valueExpr);
        cout << "LLVM value for expression is " << valueString(vExpr) << endl;
        
        SynthCppClass* sExpr = cgs.getActiveClass();
        SynthCppType* classTp = new SynthCppStructType(sExpr->name);
        Type* structType = llvmTypeFor(classTp);
        //auto bitWidth = getValueBitWidth(vExpr);
        auto f = writePort(labelId->name.getStr(), getValueBitWidth(vExpr), structType->getPointerTo());

        assert(activeFunction != nullptr);
        assert(activeFunction->llvmFunction() != nullptr);

        // cout << "Active function = " << activeFunction->nameToken << endl;
        // cout << valueString(activeFunction->llvmFunction()) << endl;

        int thisOffset = 0;
        return bd.CreateCall(f, {getArg(activeFunction->llvmFunction(), thisOffset), vExpr});
      }

      if (name == "stall") {

        Expression* valueExpr = called->args[0];
        auto vExpr = genLLVM(valueExpr);
        
        return bd.CreateCall(stallFunction(), {vExpr});
      }

      if (name == "read_port") {
        assert(called->args.size() == 1);
        
        Expression* labelExpr = called->args[0];

        cout << "read port: " << *labelExpr << endl;

        Identifier* labelId = extract<Identifier>(labelExpr);

        // TODO: Replace with more general
        int outWidth = cgs.activeClass->getPortWidth(labelId->getName());

        SynthCppClass* sExpr = cgs.getActiveClass();
        SynthCppType* classTp = new SynthCppStructType(sExpr->name);
        Type* structType = llvmTypeFor(classTp);
        auto f =
          readPort(labelId->name.getStr(), outWidth, structType->getPointerTo());

        assert(activeFunction != nullptr);
        assert(activeFunction->llvmFunction() != nullptr);

        cout << "Active function = " << activeFunction->nameToken << endl;
        cout << valueString(activeFunction->llvmFunction()) << endl;

        int thisOffset = 0;
        return bd.CreateCall(f, {getArg(activeFunction->llvmFunction(), thisOffset)});
      }
      
      SynthCppFunction* calledFunc = getFunction(called->funcName.getStr());

      // Generate llvm for each argument
      vector<Value*> args;

      for (auto arg : called->args) {

        // TODO: Add argument binding code from method calls here
        args.push_back(genLLVM(arg));
      }

      return bd.CreateCall(calledFunc->llvmFunction(), args);      
    } else if (MethodCall::classof(e)) {
      // Dummy code
      auto methodCall =
        static_cast<MethodCall* const>(e);

      // Should really be an expression
      Token caller = methodCall->callerName;
      FunctionCall* called = methodCall->called;
      SynthCppClass* cs = getClass(caller);
      SynthCppFunction* calledFunc = cs->getMethod(called->funcName);

      // Generate llvm for each argument
      vector<Value*> args;

      args.push_back(getValueFor(caller));
      int synthFuncIndex = 0;
      Function* calledLLVM = calledFunc->llvmFunction();
      for (auto arg : called->args) {
        auto argLLVM = genLLVM(arg);
        auto argParam = getArg(calledLLVM, synthFuncIndex + 1);

        // TODO: Insert this in function calls as well
        // Check if the argument being passed was a value
        if (!PointerType::classof(argLLVM->getType()) &&
            PointerType::classof(argParam->getType())) {
          cout << "Argument " << valueString(argLLVM) << " is value but bound type of parameter is " << valueString(getArg(calledLLVM, synthFuncIndex + 1)) << " (pointer), need to create temp first" << endl;

          auto argStorage = bd.CreateAlloca(argLLVM->getType());
          bd.CreateStore(argLLVM, argStorage);
          argLLVM = argStorage;
        } else if (PointerType::classof(argLLVM->getType()) &&
                   !PointerType::classof(argParam->getType())) {
          cout << "Argument " << valueString(argLLVM) << " is pointer but bound type of parameter is " << valueString(getArg(calledLLVM, synthFuncIndex + 1)) << " (value), need to dereference first" << endl;
          assert(false);
        }
        args.push_back(argLLVM);

        synthFuncIndex++;
      }

      return bd.CreateCall(calledFunc->llvmFunction(), args);

    } else if (IntegerExpr::classof(e)) {
      IntegerExpr* i = static_cast<IntegerExpr* const>(e);
      string digits = i->digits;
      auto val = stoi(digits);
      return mkInt(val, 32);
    } else if (FieldAccess::classof(e)) {
      return genFieldAccess(sc<FieldAccess>(e));
    } else {
      cout << "Unsupported expression in LLVM codegen" << endl;
      assert(false);      
    }
  }

  maybe<Expression*> parseFieldAccess(ParseState<Token>& tokens) {
    Token t = tokens.parseChar();
    if (!t.isId()) {
      return maybe<Expression*>();
    }

    cout << "Parsing expression " << tokens.remainder() << endl;
    
    // maybe<Expression*> base = parseExpressionMaybe(tokens);
    // if (!base.has_value()) {
    //   return maybe<Expression*>();
    // }

    Expression* base = new Identifier(t);

    Token delim = tokens.parseChar();
    if ((delim != Token("."))) {
      return maybe<Expression*>();
    }

    //cout << "-- In method call, parsing function call " << tokens.remainder() << endl;

    if (tokens.atEnd()) {
      return maybe<Expression*>();
    }

    Token field = tokens.parseChar();
    if (!field.isId()) {
      return maybe<Expression*>();
    }
    
    return new FieldAccess(base, field);
  }

  void SynthCppModule::addStructDecl(StructDecl* const stmt) {
    string name = stmt->name.getStr();
    vector<llvm::Type*> elems;
    //map<string, int> layout;
    for (auto& argDecl : stmt->fields) {
      assert(argDecl->arraySize == nullptr);
      elems.push_back(llvmTypeFor(argDecl->tp));
    }
    auto sTp = StructType::create(context, elems, name, true);
    structDefs.insert({sTp, stmt});
  }
  
}
