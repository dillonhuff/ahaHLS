#include "algorithm.h"

#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Scalar.h"
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Analysis/LoopAccessAnalysis.h>
#include <llvm/Analysis/ScalarEvolution.h>

#include <fstream>
#include <streambuf>
#include <sstream>
#include <functional>

#include "llvm_codegen.h"
#include "verilog_backend.h"
#include "test_utils.h"

using namespace dbhc;
using namespace ahaHLS;
using namespace std;

class SynthCppModule;
void optimizeModuleLLVM(SynthCppModule& mod);
void optimizeModuleLLVM(llvm::Module& mod);

int computeDD(ICHazard h, Instruction* src, Instruction* dest) {
  assert(src->getParent() == dest->getParent());
  
  OrderedBasicBlock obb(src->getParent());

  if (obb.dominates(src, dest)) {
    return 0;
  } else {
    return 1;
  }
}


void sequentialCalls(llvm::Function* f,
                     ExecutionConstraints& exec,
                     vector<ICHazard>& hazards) {
  for (auto& bb : f->getBasicBlockList()) {
    Instruction* first = nullptr;
    Instruction* second = nullptr;
    for (auto& instrP : bb) {
      auto instr = &instrP;
      if (CallInst::classof(instr)) {
        first = second;
        second = instr;

        
        if ((second != nullptr) && (first != nullptr)) {
          CallInst* firstCall = dyn_cast<CallInst>(first);
          CallInst* secondCall = dyn_cast<CallInst>(second);

          string firstCallName = string(firstCall->getCalledFunction()->getName());
          string secondCallName = string(secondCall->getCalledFunction()->getName());
          cout << "First call  = " << string(firstCall->getCalledFunction()->getName()) << endl;
          cout << "Second call = " << string(secondCall->getCalledFunction()->getName()) << endl;

          
          if (first->getOperand(0) == second->getOperand(0)) {
            cout << "\tCould possibly have internal hazard" << endl;
            maybe<ICHazard> h = findHazard(firstCallName, secondCallName, hazards);
            if (h.has_value()) {
              cout << "Found possible hazard or loosening" << endl;
              exec.addConstraint(buildConstraint(first, second, h.get_value()));
            } else {
              exec.addConstraint(instrEnd(first) < instrStart(second));
            }
          }
        }
      }
    }
  }

  // Add pipeline hazards
  for (auto& bb : f->getBasicBlockList()) {

    for (auto& instrP : bb) {
      auto first = &instrP;

      for (auto& instrQ : bb) {
        auto second = &instrQ;

        if (CallInst::classof(first) && CallInst::classof(second)) {
          CallInst* firstCall = dyn_cast<CallInst>(first);
          CallInst* secondCall = dyn_cast<CallInst>(second);

          string firstCallName = string(firstCall->getCalledFunction()->getName());
          string secondCallName = string(secondCall->getCalledFunction()->getName());
          cout << "First call  = " << string(firstCall->getCalledFunction()->getName()) << endl;
          cout << "Second call = " << string(secondCall->getCalledFunction()->getName()) << endl;

          
          if (first->getOperand(0) == second->getOperand(0)) {

            // if ((firstCallName == "hread") &&
            //     (secondCallName == "hwrite")) {

            //   cout << "Forcing read / write constraint" << endl;

            //   auto ccO = instrEnd(second) <= instrStart(first);
            //   //buildConstraint(first, second, h.get_value());
            //   assert(ccO->type() == CONSTRAINT_TYPE_ORDERED);
            //   auto cc = static_cast<Ordered*>(ccO);
            //   cc->isPipelineConstraint = true;
            //   cc->pipeline = &bb;
            //   cc->dd = 1;
            //   exec.addConstraint(cc);
            // }


            // if ((firstCallName == "fhread") &&
            //     (secondCallName == "fhwrite")) {

            //   cout << "Forcing read / write constraint" << endl;

            //   auto ccO = instrStart(second) <= instrStart(first);
            //   //buildConstraint(first, second, h.get_value());
            //   assert(ccO->type() == CONSTRAINT_TYPE_ORDERED);
            //   auto cc = static_cast<Ordered*>(ccO);
            //   cc->isPipelineConstraint = true;
            //   cc->pipeline = &bb;
            //   cc->dd = 1;
            //   exec.addConstraint(cc);
            // }
            
            {
              // Compute forward dep
              maybe<ICHazard> h = findHazard(firstCallName, secondCallName, hazards);

              if (h.has_value()) {
                cout << "Found possible hazard or loosening in II" << endl;

                // TODO: Add scev analysis?
                int dd = computeDD(h.get_value(), first, second);

                cout << "Dependence distance between " << valueString(first) << " and " << valueString(second) << " = " << dd << endl;


                auto ccO =
                  buildConstraint(first, second, h.get_value());
                assert(ccO->type() == CONSTRAINT_TYPE_ORDERED);
                auto cc = static_cast<Ordered*>(ccO);
                cc->isPipelineConstraint = true;
                cc->pipeline = &bb;
                cc->dd = dd;
              
                exec.addConstraint(cc);
              } else {
              }
            }

          }
        }
      }
    }
  }

}

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

Schedule scheduleInterfaceZeroReg(llvm::Function* f,
                                  HardwareConstraints& hcs,
                                  InterfaceFunctions& interfaces,
                                  std::set<BasicBlock*>& toPipeline,
                                  ExecutionConstraints& exec) {

  cout << "Before inlining" << endl;
  cout << valueString(f) << endl;

  addDataConstraints(f, exec);
  inlineWireCalls(f, exec, interfaces);

  // TODO: Where to put this stuff
  optimizeModuleLLVM(*(f->getParent()));
  optimizeStores(f);
  clearExecutionConstraints(f, exec);
  
  cout << "After inlining" << endl;
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

  if ((f->getName() == "histogram") ||
      (f->getName() == "histogram_fwd")) {

    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();
      if (BranchInst::classof(term)) {
        BranchInst* branch = dyn_cast<BranchInst>(term);
        if (branch->isConditional()) {
          for (auto succ : branch->successors()) {
            if (succ == &bb) {
              toPipeline.insert(&bb);
            }
          }
        }
      }
    }
  }

  SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
  exec.addConstraints(p, f);

  map<Function*, SchedulingProblem> constraints{{f, p}};
  
  Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

  return s;
}


template<typename ResultType, typename InputType>
ResultType* sc(InputType* tp) {
  return static_cast<ResultType*>(tp);
}

template<typename ResultType, typename InputType>
ResultType* extract(InputType* tp) {
  assert(ResultType::classof(tp));
  return sc<ResultType>(tp);
}

template<typename ResultType, typename InputType>
maybe<ResultType*> extractM(InputType* tp) {
  if (ResultType::classof(tp)) {
    return sc<ResultType>(tp);
  }

  return maybe<ResultType*>();
}

enum TokenType {
  TOKEN_TYPE_ID,
  TOKEN_TYPE_NUM,
  TOKEN_TYPE_SYMBOL,
  TOKEN_TYPE_KEYWORD,  
};


bool oneCharToken(const char c) {
  vector<char> chars = {'{', '}', ';', ')', '(', ',', '[', ']', ':', '-', '&', '+', '=', '>', '<', '*', '.'};
  return elem(c, chars);
}

bool isKeyword(const std::string& str) {
  vector<string> keywords{"void", "for", "return", "do", "while"};
  return elem(str, keywords);
}

class Token {
  std::string str;
  TokenType tp;
  
public:

  Token() {}
  
  Token(const std::string& str_) : str(str_), tp(TOKEN_TYPE_ID) {
    if (isKeyword(str)) {
      tp = TOKEN_TYPE_KEYWORD;
    }

    if (isdigit(str[0])) {
      tp = TOKEN_TYPE_NUM;
    }
  }
  Token(const std::string& str_,
        const TokenType tp_) : str(str_), tp(tp_) {}

  TokenType type() const { return tp; }
  
  bool isId() const { return type() == TOKEN_TYPE_ID; }
  bool isNum() const { return type() == TOKEN_TYPE_NUM; }
  std::string getStr() const { return str; }
};

bool operator<(const Token l, const Token r) {
  return l.getStr() < r.getStr();
}

bool isComparator(Token op) {
  vector<string> comps = {"==", ">", "<", "*", ">=", "<="};
  return elem(op.getStr(), comps);
}

std::ostream& operator<<(std::ostream& out, const Token& t) {
  out << t.getStr();
  return out;
}

bool operator==(const Token& a, const Token& b) {
  return a.getStr() == b.getStr();
}

bool operator!=(const Token& a, const Token& b) {
  return !(a == b);
}

template<typename T>
class ParseState {
  std::vector<T> ts;
  int pos;

public:

  ParseState(const std::vector<T>& toks) : ts(toks), pos(0) {}

  int currentPos() const { return pos; }
  void setPos(const int position) { pos = position; }

  bool nextCharIs(const Token t) const {
    
    return !atEnd() && (peekChar() == t);
  }

  T peekChar(const int offset) const {
    assert(((int) ts.size()) > (pos + offset));
    return ts[pos + offset];
  }
  
  T peekChar() const { return peekChar(0); }

  T parseChar() {
    assert(((int) ts.size()) > pos);

    T next = ts[pos];
    pos++;
    return next;
  }

  bool atEnd() const {
    return pos == ((int) ts.size());
  }

  int remainderSize() const {
    return ((int) ts.size()) - pos;
  }

  std::string remainder() const {
    stringstream ss;
    for (int i = pos; i < ts.size(); i++) {
      ss << ts.at(i) << " ";
    }
    return ss.str();
    //return ts.substr(pos);
  }
  
};

typedef ParseState<char> TokenState;

bool isBinop(const Token t) {
  vector<string> binopStrings{"=", "==", "+", "&", "-", "/", "^", "%", "&&", "||", "<=", ">=", "<", ">", "*"};
  return elem(t.getStr(), binopStrings);
}
bool isWhitespace(const char c) {
  return isspace(c);
}

template<typename OutType, typename TokenType, typename Parser>
std::vector<OutType> many(Parser p, ParseState<TokenType>& tokens) {
  std::vector<OutType> stmts;

  while (true) {
    auto res = p(tokens);
    if (!res.has_value()) {
      break;
    }

    stmts.push_back(res.get_value());
  }

  return stmts;
}

template<typename OutType, typename TokenType, typename Parser>
maybe<OutType> tryParse(Parser p, ParseState<TokenType>& tokens) {
  int lastPos = tokens.currentPos();
  //cout << "lastPos = " << lastPos << endl;
  
  maybe<OutType> val = p(tokens);
  if (val.has_value()) {
    return val;
  }

  tokens.setPos(lastPos);

  //cout << "try failed, now pos = " << tokens.currentPos() << endl;
  return maybe<OutType>();
}

template<typename OutType, typename TokenType, typename StatementParser, typename SepParser>
std::vector<OutType>
sepBy(StatementParser stmt, SepParser sep, ParseState<TokenType>& tokens) {
  std::vector<OutType> stmts;
  
  while (!tokens.atEnd()) {
    stmts.push_back(stmt(tokens));
    sep(tokens);
  }

  return stmts;
}

template<typename OutType, typename SepType, typename TokenType, typename StatementParser, typename SepParser>
std::vector<OutType>
sepBtwn(StatementParser stmt, SepParser sep, ParseState<TokenType>& tokens) {
  std::vector<OutType> stmts;
  
  while (true) {
    OutType nextStmt = stmt(tokens);
    stmts.push_back(nextStmt);
    auto nextSep = tryParse<SepType>(sep, tokens);
    if (!nextSep.has_value()) {
      break;
    }
  }

  return stmts;
}

template<typename OutType, typename SepType, typename TokenType, typename StatementParser, typename SepParser>
std::vector<OutType>
sepBtwn0(StatementParser stmt, SepParser sep, ParseState<TokenType>& tokens) {
  std::vector<OutType> stmts;

  maybe<OutType> nextStmt = stmt(tokens);
  if (!nextStmt.has_value()) {
    return {};
  } else {
    stmts.push_back(nextStmt.get_value());
  }

  auto nextSep = tryParse<SepType>(sep, tokens);
  if (!nextSep.has_value()) {
    return stmts;
  }
  
  while (true) {
    maybe<OutType> nextStmt = stmt(tokens);
    assert(nextStmt.has_value());
    stmts.push_back(nextStmt.get_value());
    auto nextSep = tryParse<SepType>(sep, tokens);
    if (!nextSep.has_value()) {
      break;
    }
  }

  return stmts;
}

template<typename F>
maybe<Token> consumeWhile(TokenState& state, F shouldContinue) {
  string tok = "";
  while (!state.atEnd() && shouldContinue(state.peekChar())) {
    tok += state.parseChar();
  }
  if (tok.size() > 0) {
    return Token(tok);
  } else {
    return maybe<Token>();
  }
}

bool isUnderscore(const char c) { return c == '_'; }
bool isAlphaNum(const char c) { return isalnum(c); }

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

void consumeWhitespace(TokenState& state) {
  while (true) {
    auto commentM = tryParse<Token>(parseComment, state);
    if (!commentM.has_value()) {
      auto ws = consumeWhile(state, isWhitespace);
      if (!ws.has_value()) {
        return;
      }
    }
  }
}

Token parse_token(TokenState& state) {
  if (isalnum(state.peekChar())) {
    auto res = consumeWhile(state, [](const char c) { return isAlphaNum(c) || isUnderscore(c); });
    assert(res.has_value());
    return res.get_value();
  } else if (oneCharToken(state.peekChar())) {
    maybe<Token> result = tryParse<Token>(mkParseStr("=="), state);
    if (result.has_value()) {
      return result.get_value();
    }

    result = tryParse<Token>(mkParseStr("->"), state);
    if (result.has_value()) {
      return result.get_value();
    }
    
    char res = state.parseChar();
    string r;
    r += res;
    return Token(r, TOKEN_TYPE_SYMBOL);
  } else {
    cout << "Cannot tokenize " << state.remainder() << endl;
    assert(false);
  }

}

std::vector<Token> tokenize(const std::string& classCode) {
  vector<char> chars;
  for (int i = 0; i < (int) classCode.size(); i++) {
    chars.push_back(classCode[i]);
  }
  TokenState state(chars);
  vector<Token> tokens;
  
  while (!state.atEnd()) {
    //cout << "Next char = " << state.peekChar() << endl;
    consumeWhitespace(state);

    if (state.atEnd()) {
      break;
    }

    Token t = parse_token(state);
    //cout << "Next char after token = " << state.peekChar() << endl;
    tokens.push_back(t);
  }

  return tokens;
}

enum ExpressionKind {
  EXPRESSION_KIND_IDENTIFIER,
  EXPRESSION_KIND_NUM,
  EXPRESSION_KIND_METHOD_CALL,
  EXPRESSION_KIND_FUNCTION_CALL,
  EXPRESSION_KIND_BINOP,
};

class Expression {
public:

  virtual ExpressionKind getKind() const = 0;

  virtual void print(std::ostream& out) const {
    assert(false);
  }

  virtual ~Expression() {}
  
};

std::ostream& operator<<(std::ostream& out, const Expression& e) {
  e.print(out);
  return out;
}

class FunctionCall : public Expression {
public:
  Token funcName;
  std::vector<Expression*> args;

  FunctionCall(const Token funcName_,
               const std::vector<Expression*>& args_) :
    funcName(funcName_), args(args_) {}

  std::string getName() const { return funcName.getStr(); }

  virtual ExpressionKind getKind() const override {
    return EXPRESSION_KIND_FUNCTION_CALL;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_FUNCTION_CALL;
  }

  virtual void print(std::ostream& out) const override {
    out << funcName << "(";
    for (auto arg : args) {
      out << *arg << ", ";
    }
    out << ")";
  }
  
  
};

class MethodCall : public Expression {

public:
  
  Token callerName;
  FunctionCall* called;

  MethodCall(const Token callerName_,
             FunctionCall* called_) :
    callerName(callerName_), called(called_) {}

  virtual ExpressionKind getKind() const override {
    return EXPRESSION_KIND_METHOD_CALL;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_METHOD_CALL;
  }

  virtual void print(std::ostream& out) const override {
    out << callerName << "->" << *called;
  }
  
};

class Identifier : public Expression {
public:

  Token name;
  
  Identifier(const Token name_) : name(name_) {}

  std::string getName() const { return name.getStr(); }

  virtual ExpressionKind getKind() const override {
    return EXPRESSION_KIND_IDENTIFIER;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_IDENTIFIER;
  }

  virtual void print(std::ostream& out) const override {
    out << getName();
  }
  
};

enum SynthCppTypeKind {
  SYNTH_CPP_TYPE_KIND_STRUCT,
  SYNTH_CPP_TYPE_KIND_VOID,
  SYNTH_CPP_TYPE_KIND_POINTER,
  SYNTH_CPP_TYPE_KIND_LABEL,
  SYNTH_CPP_TYPE_KIND_BITS
};

class SynthCppType {
public:

  virtual SynthCppTypeKind getKind() const { assert(false); }

  virtual ~SynthCppType() {
  }

  virtual void print(std::ostream& out) const = 0;

};

std::ostream& operator<<(std::ostream& out, const SynthCppType& tp) {
  tp.print(out);
  return out;
}

class TemplateType : public SynthCppType {
public:
  std::vector<Expression*> exprs;

  TemplateType(const std::vector<Expression*>& exprs_) : exprs(exprs_) {}

  ~TemplateType() {
    for (auto e : exprs) {
      delete e;
    }
  }
};

class SynthCppStructType : public SynthCppType {
public:

  Token name;

  SynthCppStructType(const Token name_) : name(name_) {}

  std::string getName() const { return name.getStr(); }

  virtual SynthCppTypeKind getKind() const override { return SYNTH_CPP_TYPE_KIND_STRUCT; }

  static bool classof(const SynthCppType* const tp) { return tp->getKind() == SYNTH_CPP_TYPE_KIND_STRUCT; }

  virtual void print(std::ostream& out) const override {
    out << name;
  }
  
};

class LabelType : public SynthCppType {
public:
  static bool classof(const SynthCppType* const tp) {
    return tp->getKind() == SYNTH_CPP_TYPE_KIND_LABEL;
  }

  virtual SynthCppTypeKind getKind() const override { return SYNTH_CPP_TYPE_KIND_LABEL; }

  virtual void print(std::ostream& out) const override {
    out << "label_type";
  }
};

class SynthCppPointerType : public SynthCppType {
public:

  SynthCppType* elementType;
  SynthCppPointerType(SynthCppType* elem_) : elementType(elem_) {}

  SynthCppType* getElementType() const { return elementType; }

  static bool classof(const SynthCppType* const tp) { return tp->getKind() == SYNTH_CPP_TYPE_KIND_POINTER; }
  
  virtual SynthCppTypeKind getKind() const override { return SYNTH_CPP_TYPE_KIND_POINTER; }

  virtual void print(std::ostream& out) const override {
    out << *getElementType() << "&";
  }
  
};

class SynthCppDataType : public SynthCppType {
public:

  static bool classof(const SynthCppType* const tp) { return (tp->getKind() == SYNTH_CPP_TYPE_KIND_BITS) ||
      (tp->getKind() == SYNTH_CPP_TYPE_KIND_VOID); }

  virtual void print(std::ostream& out) const override {
    out << "data_type";
  }

};

class SynthCppBitsType : public SynthCppDataType {
public:

  int width;

  SynthCppBitsType(const int width_) : width(width_) {}

  int getWidth() const { return width; }

  static bool classof(const SynthCppType* const tp) { return (tp->getKind() == SYNTH_CPP_TYPE_KIND_BITS); }
  
  virtual SynthCppTypeKind getKind() const override { return SYNTH_CPP_TYPE_KIND_BITS; }

  virtual void print(std::ostream& out) const override {
    out << "bits[" << getWidth() << "]";
  }
  
};

class VoidType : public SynthCppDataType {
public:

  static bool classof(const SynthCppType* const tp) { return tp->getKind() == SYNTH_CPP_TYPE_KIND_VOID; }
  
  virtual SynthCppTypeKind getKind() const override { return SYNTH_CPP_TYPE_KIND_VOID; }

  virtual void print(std::ostream& out) const override {
    out << "void";
  }
  
};

class BinopExpr : public Expression {
public:
  Expression* lhs;
  Token op;
  Expression* rhs;
  
  BinopExpr(Expression* lhs_, Token op_, Expression* rhs_) :
    lhs(lhs_), op(op_), rhs(rhs_) {}

  virtual ExpressionKind getKind() const {
    return EXPRESSION_KIND_BINOP;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_BINOP;
  }

  virtual void print(std::ostream& out) const {
    out << "(" << *lhs << " " << op << " " << *rhs << ")";
  }
  
};

class IntegerExpr : public Expression {
public:
  
  std::string digits;
  
  IntegerExpr(const std::string& digits_) : digits(digits_) {}

  int getInt() const { return stoi(digits); }

  virtual void print(std::ostream& out) const {
    out << digits;
  }
  
  virtual ExpressionKind getKind() const {
    return EXPRESSION_KIND_NUM;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_NUM;
  }
  
};

enum StatementKind {
  STATEMENT_KIND_CLASS_DECL,
  STATEMENT_KIND_FUNCTION_DECL,
  STATEMENT_KIND_ARG_DECL,  
  STATEMENT_KIND_ASSIGN,
  STATEMENT_KIND_FOR,
  STATEMENT_KIND_EXPRESSION,
  STATEMENT_KIND_RETURN,
  STATEMENT_KIND_DO_WHILE,
};

class Statement {
public:
  bool hasL;
  Token label;

  Statement() : hasL(false) {}

  virtual void print(std::ostream& out) const {
    assert(false);
  }

  Token getLabel() const { return label; }

  bool hasLabel() const { return hasL; }

  void setLabel(const Token l) {
    hasL = true;
    label = l;
  }

  virtual StatementKind getKind() const {
    assert(false);
  }

  virtual ~Statement() {
  }

};

std::ostream& operator<<(std::ostream& out, const Statement& stmt) {
  stmt.print(out);
  return out;
}

class ClassDecl : public Statement {
public:
  Token name;
  std::vector<Statement*> body;

  ClassDecl(Token name_, std::vector<Statement*>& body_) :
    name(name_), body(body_) {}

  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_CLASS_DECL;
  }

  virtual StatementKind getKind() const {
    return STATEMENT_KIND_CLASS_DECL;
  }

  virtual void print(std::ostream& out) const {
    out << "class " << name << "{ INSERT_BODY; }";
  }
  
};

class AssignStmt : public Statement {
public:
  Token var;
  Expression* expr;

  AssignStmt(Token var_, Expression* expr_) : var(var_), expr(expr_) {}

  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_ASSIGN;
  }

  virtual StatementKind getKind() const {
    return STATEMENT_KIND_ASSIGN;
  }

  virtual void print(std::ostream& out) const {
    out << var << " = " << *expr;
  }
  
};

class ForStmt : public Statement {
public:
  Statement* init;
  Expression* exitTest;
  Statement* update;
  std::vector<Statement*> stmts;

  ForStmt(Statement* init_,
          Expression* exitTest_,
          Statement* update_,
          std::vector<Statement*>& stmts_) :
  init(init_), exitTest(exitTest_), update(update_), stmts(stmts_) {}

  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_FOR;
  }

  virtual StatementKind getKind() const {
    return STATEMENT_KIND_FOR;
  }

  virtual void print(std::ostream& out) const {
    out << "for (INSERT) { INSERT; }";
  }
  
};

class ExpressionStmt : public Statement {
public:
  Expression* expr;

  ExpressionStmt(Expression* expr_) : expr(expr_) {}

  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_EXPRESSION;
  }

  virtual StatementKind getKind() const {
    return STATEMENT_KIND_EXPRESSION;
  }

  virtual void print(std::ostream& out) const {
    out << *expr;
  }
};

maybe<Statement*> parseStatement(ParseState<Token>& tokens);

class ArgumentDecl : public Statement {
public:

  SynthCppType* tp;
  Token name;
  Expression* arraySize;

  ArgumentDecl(SynthCppType* tp_, Token name_) : tp(tp_), name(name_), arraySize(nullptr) {}
  ArgumentDecl(SynthCppType* tp_, Token name_, Expression* arraySize_) :
    tp(tp_), name(name_), arraySize(arraySize_) {}

  virtual void print(std::ostream& out) const {
    out << "ARGDECL " << name;
  }
  
  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_ARG_DECL;
  }

  virtual StatementKind getKind() const {
    return STATEMENT_KIND_ARG_DECL;
  }
  
};

class ReturnStmt : public Statement {
public:
  Expression* returnVal;

  ReturnStmt() : returnVal(nullptr) {}
  ReturnStmt(Expression* expr) : returnVal(expr) {}

  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_RETURN;
  }

  virtual StatementKind getKind() const {
    return STATEMENT_KIND_RETURN;
  }

  virtual void print(std::ostream& out) const {
    out << "return " << *returnVal;
  }
  
};

class FunctionDecl : public Statement {
public:
  SynthCppType* returnType;
  Token name;
  std::vector<ArgumentDecl*> args;
  std::vector<Statement*> body;

  FunctionDecl(SynthCppType* returnType_,
               Token name_,
               std::vector<ArgumentDecl*>& args_,
               std::vector<Statement*>& body_) :
    returnType(returnType_),
    name(name_),
    args(args_),
    body(body_) {}

  std::string getName() const { return name.getStr(); }

  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_FUNCTION_DECL;
  }
  
  virtual StatementKind getKind() const {
    return STATEMENT_KIND_FUNCTION_DECL;
  }
  

};

class ParserModule {
  std::vector<Statement*> stmts;
  
public:

  ParserModule(const std::vector<Statement*>& stmts_) : stmts(stmts_) {}

  std::vector<Statement*> getStatements() const { return stmts; }

  ~ParserModule() {
    for (auto stmt : stmts) {
      delete stmt;
    }
  }
};

std::ostream& operator<<(std::ostream& out, const ParserModule& mod) {
  return out;
}

void parseStmtEnd(ParseState<Token>& tokens) {
  //cout << "Statement end token == " << tokens.peekChar() << endl;
  assert(tokens.parseChar() == Token(";"));
}

maybe<Token> parseComma(ParseState<Token>& tokens) {
  Token t = tokens.parseChar();
  if (t.getStr() == ",") {
    return t;
  }

  return maybe<Token>();
}

maybe<Token> parseSemicolon(ParseState<Token>& tokens) {
  Token t = tokens.parseChar();
  if (t.getStr() == ";") {
    return t;
  }

  return maybe<Token>();
}

maybe<Identifier*> parseId(ParseState<Token>& tokens) {
  Token t = tokens.parseChar();
  if (t.isId()) {
    return new Identifier(t);
  }

  return maybe<Identifier*>();
}

maybe<FunctionCall*> parseFunctionCall(ParseState<Token>& tokens);

maybe<Expression*> parseMethodCall(ParseState<Token>& tokens) {
  Token t = tokens.parseChar();
  if (!t.isId()) {
    return maybe<Expression*>();
  }

  Token delim = tokens.parseChar();
  if ((delim != Token("->")) &&
      (delim != Token("."))) {
    return maybe<Expression*>();
  }

  //cout << "-- In method call, parsing function call " << tokens.remainder() << endl;
  maybe<FunctionCall*> fCall = parseFunctionCall(tokens);
  if (fCall.has_value()) {
    return new MethodCall(t, fCall.get_value());
  }

  return maybe<Expression*>();
}

Expression* parseExpression(ParseState<Token>& tokens);
maybe<Expression*> parseExpressionMaybe(ParseState<Token>& tokens);

maybe<Expression*> parsePrimitiveExpressionMaybe(ParseState<Token>& tokens) {
  //cout << "-- Parsing primitive expression " << tokens.remainder() << endl;

  if (tokens.atEnd()) {
    return maybe<Expression*>();
  }
  
  if (tokens.nextCharIs(Token("("))) {
    tokens.parseChar();

    //cout << "Inside parens " << tokens.remainder() << endl;
    auto inner = parseExpressionMaybe(tokens);
    if (inner.has_value()) {
      if (tokens.nextCharIs(Token(")"))) {
        tokens.parseChar();
        return inner;
      }
    }
    return maybe<Expression*>();
  }

  
  auto fCall = tryParse<FunctionCall*>(parseFunctionCall, tokens);
  if (fCall.has_value()) {
    return fCall.get_value();
  }

  //cout << "---- Trying to parse method call " << tokens.remainder() << endl;
  auto mCall = tryParse<Expression*>(parseMethodCall, tokens);
  if (mCall.has_value()) {
    return mCall;
  }
  
  // Try parsing a function call
  // If that does not work try to parse an identifier
  // If that does not work try parsing a parenthesis
  auto id = tryParse<Identifier*>(parseId, tokens);
  if (id.has_value()) {
    return id.get_value();
  }

  //cout << "Expressions = " << tokens.remainder() << endl;
  if (!tokens.atEnd() && tokens.peekChar().isNum()) {
    return new IntegerExpr(tokens.parseChar().getStr());
  }

  return maybe<Expression*>();
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

int precedence(Token op) {
  map<string, int> prec{{"+", 100}, {"==", 99}, {"-", 100}, {"*", 100}, {"<", 99}, {">", 99}};
  assert(contains_key(op.getStr(), prec));
  return map_find(op.getStr(), prec);
}

Expression* popOperand(vector<Expression*>& postfixString) {
  assert(postfixString.size() > 0);

  Expression* top = postfixString.back();
  postfixString.pop_back();
  
  auto idM = extractM<Identifier>(top);
  if (idM.has_value() && isBinop(idM.get_value()->getName())) {
    auto rhs = popOperand(postfixString);
    auto lhs = popOperand(postfixString);
    return new BinopExpr(lhs, idM.get_value()->getName(), rhs);
  }

  return top;
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

int getDataWidth(const std::string& name) {
  if (hasPrefix(name, "bit_")) {
    return stoi(name.substr(4));
  } else if (hasPrefix(name, "sint_")) {
    return stoi(name.substr(5));
  } else {
    assert(hasPrefix(name, "uint_"));
    return stoi(name.substr(5)); 
  }
}

maybe<SynthCppType*> parseBaseType(ParseState<Token>& tokens) {
  if (tokens.peekChar().isId()) {
    
    //cout << tokens.peekChar() << " is id" << endl;    

    Token tpName = tokens.parseChar();

    if (tokens.atEnd() || (tokens.peekChar() != Token("<"))) {
      string name = tpName.getStr();
      if (hasPrefix(name, "bit_") || hasPrefix(name, "sint_") || hasPrefix(name, "uint_")) {
        int width = getDataWidth(name);
        return new SynthCppBitsType(width);
      }

      return new SynthCppStructType(tpName);
    }

  }

  if (tokens.peekChar() == Token("void")) {
    tokens.parseChar();
    return new VoidType();
  }

  return maybe<SynthCppType*>();
}

maybe<SynthCppType*> parseType(ParseState<Token>& tokens) {
  auto tp = parseBaseType(tokens);

  // Check if its a pointer
  if (!tokens.atEnd() && (tokens.peekChar() == Token("&"))) {
    tokens.parseChar();
    return new SynthCppPointerType(tp.get_value());
  }

  return tp;
}

maybe<ArgumentDecl*> parseArgDeclMaybe(ParseState<Token>& tokens) {
  // cout << "Parsing arg declaration = " << tokens.remainder() << endl;
  // cout << "Remaining tokens = " << tokens.remainderSize() << endl;
  maybe<SynthCppType*> tp = parseType(tokens);

  if (!tp.has_value()) {
    return maybe<ArgumentDecl*>();
  }


  //cout << "After parsing type = " << tokens.remainder() << endl;

  Token argName = tokens.parseChar();

  if (!argName.isId()) {
    return maybe<ArgumentDecl*>();
  }

  //cout << "After parsing expression = " << tokens.remainder() << endl;
    
  if (tokens.peekChar() == Token("[")) {
    tokens.parseChar();

    auto e = parseExpressionMaybe(tokens);

    //cout << "After parsing expression = " << tokens.remainder() << endl;
    if (!e.has_value()) {
      return maybe<ArgumentDecl*>();
    }

    if (tokens.peekChar() == Token("]")) {
      tokens.parseChar();

      return new ArgumentDecl(tp.get_value(), argName, e.get_value());
    } else {
      return maybe<ArgumentDecl*>();      
    }
    
  }

  return new ArgumentDecl(tp.get_value(), argName);
}

ArgumentDecl* parseArgDecl(ParseState<Token>& tokens) {
  auto d = parseArgDeclMaybe(tokens);
  if (d.has_value()) {
    return d.get_value();
  }

  assert(false);
}

maybe<Statement*> parseFuncDecl(ParseState<Token>& tokens) {
  maybe<SynthCppType*> tp = tryParse<SynthCppType*>(parseType, tokens);
  if (!tp.has_value()) {
    return maybe<Statement*>();
  }

  // Create function declaration
  Token funcName = tokens.parseChar();

  if (!funcName.isId()) {
    return maybe<Statement*>();
  }

  if (tokens.peekChar() == Token("(")) {
    assert(tokens.parseChar() == Token("("));

    vector<ArgumentDecl*> classStmts =
      sepBtwn0<ArgumentDecl*, Token>(parseArgDeclMaybe, parseComma, tokens);

    assert(tokens.parseChar() == Token(")"));

    assert(tokens.parseChar() == Token("{"));

    vector<Statement*> funcStmts =
      many<Statement*>(parseStatement, tokens);

    assert(tokens.parseChar() == Token("}"));
    
    return new FunctionDecl(tp.get_value(), funcName, classStmts, funcStmts);
  }

  return maybe<Statement*>();

}

maybe<Token> parseLabel(ParseState<Token>& tokens) {
  if (tokens.atEnd()) {
    return maybe<Token>();
  }

  Token t = tokens.parseChar();
  if (!t.isId()) {
    return maybe<Token>();
  }

  if (tokens.atEnd()) {
    return maybe<Token>();
  }
  
  Token semi = tokens.parseChar();
  if (semi != Token(":")) {
    return maybe<Token>();
  }

  return t;
}

maybe<Statement*> parseFunctionCallStmt(ParseState<Token>& tokens) {
  maybe<FunctionCall*> p = parseFunctionCall(tokens);
  if (!p.has_value()) {
    return maybe<Statement*>();
  }

  Token semi = tokens.parseChar();
  if (semi != Token(";")) {
    return maybe<Statement*>();
  }

  return new ExpressionStmt(static_cast<FunctionCall*>(p.get_value()));
}

maybe<Statement*> parseAssignStmt(ParseState<Token>& tokens) {
  //cout << "Starting parse assign \" " << tokens.remainder() << "\"" << endl;

  if (tokens.atEnd()) {
    return maybe<Statement*>();
  }

  Token id = tokens.peekChar();
  if (!id.isId()) {
    return maybe<Statement*>();
  }
  tokens.parseChar();

  //cout << "After name remainder is \"" << tokens.remainder() << "\"" << endl;

  if (!tokens.nextCharIs(Token("="))) {
    return maybe<Statement*>();
  }
  tokens.parseChar();

  //cout << "Remaining after eq is " << tokens.remainder() << endl;
  auto r = parseExpressionMaybe(tokens);
  if (!r.has_value()) {
    cout << "No expr" << endl;
    return maybe<Statement*>();
  }

  return new AssignStmt(id, r.get_value());
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

class DoWhileLoop : public Statement {
public:

  Expression* test;
  vector<Statement*> body;
  
  DoWhileLoop(Expression* e_,
              std::vector<Statement*>& stmts_) : test(e_), body(stmts_) {}
  
  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_DO_WHILE;
  }
  
  virtual StatementKind getKind() const {
    return STATEMENT_KIND_DO_WHILE;
  }

};

maybe<Statement*> parseDoWhileLoop(ParseState<Token>& tokens) {
  //cout << "Parsing do = " << tokens.remainder() << endl;
  
  if (tokens.nextCharIs(Token("do"))) {
    tokens.parseChar();

    if (!tokens.nextCharIs(Token("{"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    vector<Statement*> stmts =
      many<Statement*>(parseStatement, tokens);

    if (!tokens.nextCharIs(Token("}"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    if (!tokens.nextCharIs(Token("while"))) {
      return maybe<Statement*>();
    }
    tokens.parseChar();

    maybe<Expression*> expr = parseExpression(tokens);
    if (expr.has_value()) {

      if (!tokens.nextCharIs(Token(";"))) {
        return maybe<Statement*>();
      }
      tokens.parseChar();
      
      return new DoWhileLoop(expr.get_value(), stmts);
    }

    return maybe<Statement*>();
    
  }

  return maybe<Statement*>();
}
  
maybe<Statement*> parseStatementNoLabel(ParseState<Token>& tokens) {
  // Try to parse for loop
  auto doStmt = tryParse<Statement*>(parseDoWhileLoop, tokens);
  if (doStmt.has_value()) {
    return doStmt;
  }

  auto forStmt = tryParse<Statement*>(parseForLoop, tokens);
  if (forStmt.has_value()) {
    return forStmt;
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

ParserModule parse(const std::vector<Token>& tokens) {
  ParseState<Token> pm(tokens);
  vector<Statement*> stmts =
    many<Statement*>(parseStatement, pm);

  ParserModule m(stmts);
  
  return m;
}


// llvm::Type* llvmPointerFor(SynthCppType* const tp) {
//   //return llvmTypeFor(tp)->getPointerTo();
//   // if (SynthCppStructType::classof(tp)) {
//   //   return structType(static_cast<SynthCppStructType* const>(tp)->getName())->getPointerTo();
//   // } else {
//   //   cout << "Getting llvm pointer for " << *tp << endl;
//   //   assert(false);
//   // }
// }

bool isPrimitiveStruct(SynthCppStructType*  const st) {
  string name = st->getName();
  return hasPrefix(name, "bit_") || hasPrefix(name, "sint_") || hasPrefix(name, "uint_");
}

int getWidth(SynthCppStructType* tp) {
  assert(isPrimitiveStruct(tp));
  string name = tp->getName();
  if (hasPrefix(name, "bit_")) {
    return stoi(name.substr(4));
  } else if (hasPrefix(name, "sint_")) {
    return stoi(name.substr(5));
  } else {
    assert(hasPrefix(name, "uint_"));
    return stoi(name.substr(5));    
  }
}

llvm::Type* llvmTypeFor(SynthCppType* const tp) {
  if (SynthCppPointerType::classof(tp)) {
    return llvmTypeFor(sc<SynthCppPointerType>(tp)->getElementType())->getPointerTo();
    //return llvmPointerFor(static_cast<SynthCppPointerType* const>(tp)->getElementType());
  } else if (VoidType::classof(tp)) {
    return voidType();
  } else if (SynthCppBitsType::classof(tp)) {
    return intType(extract<SynthCppBitsType>(tp)->getWidth());
  } else {
    assert(SynthCppStructType::classof(tp));
    auto st = static_cast<SynthCppStructType* const>(tp);
    // if (isPrimitiveStruct(st)) {
    //   int width = getWidth(st);

    // } else {
      Type* argTp = structType(st->getName());
      return argTp;
      //}
  }
}

class SynthCppFunction {
public:
  Token nameToken;
  llvm::Function* func;
  std::map<std::string, SynthCppType*> symtab;
  SynthCppType* retType;
  ExecutionConstraints* constraints;

  bool hasReturnType() {
    return retType != nullptr;
  }

  bool hasReturnValue() {
    return (retType != nullptr) && (!VoidType::classof(retType));
  }
  
  SynthCppType* returnType() {
    assert(retType != nullptr);
    return retType;
  }
  
  llvm::Function* llvmFunction() { return func; }

  std::string getName() const {
    return nameToken.getStr();
  }
};

std::ostream& operator<<(std::ostream& out, const SynthCppFunction& f) {
  out << " " << f.getName() << "(ARGS) {" << endl;
  out << "}" << endl;

  return out;
}

SynthCppFunction* builtinStub(std::string name, std::vector<llvm::Type*>& args, SynthCppType* retType) {
  SynthCppFunction* stub = new SynthCppFunction();
  stub->nameToken = Token(name);
  stub->retType = retType;
  stub->func = mkFunc(args, llvmTypeFor(retType), name);
  
  return stub;
}

class SynthCppClass {
public:

  Token name;
  std::map<std::string, SynthCppType*> memberVars;
  std::map<std::string, SynthCppFunction*> methods;

  std::string getName() const { return name.getStr(); }
  
  SynthCppFunction* getMethod(const Token name) {
    cout << "Getting method for " << name << endl;
    return map_find(name.getStr(), methods);
  }

  int getPortWidth(Token vName) {
    for (auto v : memberVars) {
      cout << "Checking member var " << v.first << endl;
      if (v.first == vName.getStr()) {
        cout << "Found member variable " << v.first << " with type " << *(v.second) << endl;
        assert(SynthCppStructType::classof(v.second));
        string name = sc<SynthCppStructType>(v.second)->getName();
        assert(hasPrefix(name, "input_") || (hasPrefix(name, "output_")));
        if (hasPrefix(name, "input_")) {
          return stoi(name.substr(string("input_").size()));
        } else {
          return stoi(name.substr(string("output_").size()));          
        }
      }
    }

    cout << "Error: No member named " << vName << " in " << name << endl;
    assert(false);
  }
};

std::ostream& operator<<(std::ostream& out, const SynthCppClass& mod) {
  out << "class " << mod.getName() << "{" << endl;
  for (auto v : mod.methods) {
    out << tab(1) << v.first << " : " << *(v.second) << ";" << endl;
  }
  out << "};" << endl;

  return out;
}

bool isInputPort(SynthCppType* const tp) {
  auto ps = extractM<SynthCppStructType>(tp);
  if (!ps.has_value()) {
    return false;
  }

  string name = ps.get_value()->getName();
  if (hasPrefix(name, "input_")) {
    return true;
  }

  return false;
}

bool isOutputPort(SynthCppType* const tp) {
  auto ps = extractM<SynthCppStructType>(tp);
  if (!ps.has_value()) {
    return false;
  }

  string name = ps.get_value()->getName();
  if (hasPrefix(name, "output_")) {
    return true;
  }

  return false;
}

bool isPortType(SynthCppType* const tp) {
  return isOutputPort(tp) || isInputPort(tp);
}

int portWidth(SynthCppType* const tp) {
  assert(isPortType(tp));
  auto portStruct = extract<SynthCppStructType>(tp);

  string name = portStruct->getName();
  if (isInputPort(tp)) {
    string prefix = "input_";
    string width = name.substr(prefix.size());
    return stoi(width);
  } else {
    assert(isOutputPort(tp));

    string prefix = "output_";
    string width = name.substr(prefix.size());
    return stoi(width);
  }
}

vector<Type*> functionInputs(FunctionDecl* fd) {
  vector<Type*> inputTypes;
  for (auto argDecl : fd->args) {
    cout << "\targ = " << argDecl->name << endl;
    Type* argTp = llvmTypeFor(argDecl->tp);

    if (!SynthCppPointerType::classof(argDecl->tp)) {
      assert(SynthCppDataType::classof(argDecl->tp));
      inputTypes.push_back(argTp);
    } else {
      inputTypes.push_back(argTp);
    }
  }

  return inputTypes;
}

SynthCppStructType* extractBaseStructType(SynthCppType* tp) {
  if (SynthCppStructType::classof(tp)) {
    return sc<SynthCppStructType>(tp);
  }

  assert(SynthCppPointerType::classof(tp));
  auto pTp = sc<SynthCppPointerType>(tp);
  auto underlying = pTp->getElementType();

  assert(SynthCppStructType::classof(underlying));

  return sc<SynthCppStructType>(underlying);
}

class SymbolTable {
public:
  std::vector<std::map<std::string, SynthCppType*>* > tableStack;

  void pushTable(std::map<std::string, SynthCppType*>* table) {
    tableStack.push_back(table);
  }

  void popTable() {
    tableStack.pop_back();
  }

  void setType(const std::string& name, SynthCppType* tp) {
    tableStack.back()->insert({name, tp});
  }

  void print(std::ostream& out) {
    for (auto ts : tableStack) {
      out << tab(1) << "Table stack" << endl;
      for (auto str : *ts) {
        out << tab(2) << "symbol = " << str.first << endl;
      }
    }
  }

  SynthCppType* getType(const std::string& str) {
    int depth = ((int) tableStack.size()) - 1;

    for (int i = depth; i >= 0; i--) {
      if (contains_key(str, *(tableStack.at(i)))) {
        return map_find(str, *(tableStack.at(i)));
      }
    }

    cout << "Error: Cannot find type for " << str << endl;
    print(cout);
    assert(false);
  }
  
};

class CodeGenState {
public:

  SynthCppClass* activeClass;
  SynthCppFunction* activeFunction;
  BasicBlock* activeBlock;
  int globalNum;

  SymbolTable symtab;

  CodeGenState() : activeBlock(nullptr) {}

  BasicBlock& getActiveBlock() const { return *activeBlock; }
  void setActiveBlock(BasicBlock* blk) {
    activeBlock = blk;
  }

  IRBuilder<> builder() { return IRBuilder<>(activeBlock); }

  void pushClassContext(SynthCppClass* ac) {
    activeClass = ac;
  }

  void popClassContext() {
    activeClass = nullptr;
  }

  SynthCppClass* getActiveClass() {
    return activeClass;
  }
};

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
class SynthCppModule {

  HardwareConstraints hcs;
  InterfaceFunctions interfaces;
  
public:

  llvm::LLVMContext context;
  unique_ptr<llvm::Module> mod;
  std::vector<SynthCppClass*> classes;
  std::vector<SynthCppFunction*> functions;
  std::set<BasicBlock*> blocksToPipeline;

  CodeGenState cgs;
  SynthCppFunction* activeFunction;
  int globalNum;
  std::map<Token, Instruction*> labelsToInstructions;
  std::map<Token, BasicBlock*> labelsToBlockStarts;
  std::map<Token, BasicBlock*> labelsToBlockEnds;
  
  std::string uniqueNumString() {
    auto s = std::to_string(globalNum);
    globalNum++;
    return s;
  }

  void genLLVMCopyTo(llvm::Value* receiver,
                     llvm::Value* source) {
    
    cgs.builder().CreateCall(mkFunc({receiver->getType(), source->getType()}, voidType(), "copy_" + typeString(receiver->getType())), {receiver, source});
  }

  llvm::Value* bvCastTo(Value* value, Type* const destTp) {
    int vWidth = getTypeBitWidth(value->getType());
    int rWidth = getTypeBitWidth(destTp);

    if (vWidth == rWidth) {
      return value;
    }

    if (vWidth < rWidth) {
      return cgs.builder().CreateSExt(value, destTp);
    }

    assert(vWidth > rWidth);
    
    return cgs.builder().CreateTrunc(value, destTp);
  }
  
  // argNum could be 1 if the function being synthesized is actually a
  // method
  void setArgumentSymbols(IRBuilder<>& b,
                          map<string, SynthCppType*>& symtab,
                          vector<ArgumentDecl*>& args,
                          Function* f,
                          int argOffset) {

    cout << "f = " << endl;
    cout << valueString(f) << endl;
    cout << "argOffset = " << argOffset << endl;
    //int argNum = argOffset;
    int argNum = 0;    
    for (auto argDecl : args) {
      cout << "\targ = " << argDecl->name << endl;

      // Create local copy if argument is passed by value
      // For arguments originally passed by pointer:
      // - Add the underlying type to the value map (setValue)
      // For arguments originally passed by value
      // - Create internal copy
      symtab[argDecl->name.getStr()] = argDecl->tp;
      cout << "Setting " << argDecl->name.getStr() << " in symbol table" << endl;
      if (!SynthCppPointerType::classof(argDecl->tp)) {
        auto val = cgs.builder().CreateAlloca(llvmTypeFor(argDecl->tp));
        cgs.builder().CreateStore(getArg(f, argNum + argOffset), val);
        setValue(argDecl->name, val);
      } else {
        setValue(argDecl->name, getArg(f, argNum + argOffset));
      }

      argNum++;
    }

  }

  
  SynthCppModule(ParserModule& parseRes) {
    activeFunction = nullptr;

    globalNum = 0;
    hcs = standardConstraints();
    
    mod = llvm::make_unique<Module>("synth_cpp", context);
    setGlobalLLVMContext(&context);
    setGlobalLLVMModule(mod.get());

    for (auto stmt : parseRes.getStatements()) {

      if (ClassDecl::classof(stmt)) {
        ClassDecl* decl = static_cast<ClassDecl* const>(stmt);
        ModuleSpec cSpec;

        SynthCppClass* c = new SynthCppClass();
        c->name = decl->name;
        cgs.symtab.pushTable(&(c->memberVars));
        cgs.pushClassContext(c);
        
        for (auto st : decl->body) {
          if (ArgumentDecl::classof(st)) {
            auto decl = sc<ArgumentDecl>(st);
            c->memberVars[decl->name.getStr()] = decl->tp;
          } else if (FunctionDecl::classof(st)) {

            // I would like to be able to generate method
            // and function code with the same generator so
            // that I dont end up with argument duplication
            auto methodFuncDecl = sc<FunctionDecl>(st);
            if (methodFuncDecl->getName() == "defaults") {
              for (auto stmt : methodFuncDecl->body) {
                pair<string, int> defaultValue = extractDefault(stmt);
                cSpec.defaultValues.insert(defaultValue);
              }
            } else {
              vector<Type*> argTps =
                functionInputs(methodFuncDecl);

              cout << "Method " << methodFuncDecl->getName() << " has arg types before return value and this:" << endl;
              for (auto a : argTps) {
                cout << tab(1) << typeString(a) << endl;
              }
            
              vector<Type*> tps;
              tps.push_back(llvmTypeFor(new SynthCppPointerType(new SynthCppStructType(c->name))));
              for (auto a : argTps) {
                tps.push_back(a);
              }

              cout << "Method " << methodFuncDecl->getName() << " has arg types" << endl;
              for (auto a : tps) {
                cout << tab(1) << typeString(a) << endl;
              }
              SynthCppFunction* sf = new SynthCppFunction();
              activeFunction = sf;
              sf->nameToken = methodFuncDecl->name;
              // Change voidType to the function output type
              auto f = mkFunc(tps, llvmTypeFor(methodFuncDecl->returnType), sf->getName());
              interfaces.addFunction(f);
              sf->func = f;
              sf->retType = methodFuncDecl->returnType;
              sf->constraints = &(interfaces.getConstraints(f));

              auto bb = mkBB("entry_block", f);
              cgs.setActiveBlock(bb);
              
              //IRBuilder<> b(bb);

              bool hasReturn = false; //sf->hasReturnValue();
              auto bd = cgs.builder();
              setArgumentSymbols(bd, sf->symtab, methodFuncDecl->args, f, 1 + (hasReturn ? 1 : 0));
              cgs.symtab.pushTable(&(sf->symtab));
              cout << "After setting argument symbols for "  << string(f->getName()) << endl;
              cgs.symtab.print(cout);
              
            
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
              c->methods[sf->getName()] = sf;

              sanityCheck(f);
              
              //setAllAllocaMemTypes(hcs, f, registerSpec(32));
            
              activeFunction = nullptr;
            }
          } else {
            assert(false);
          }
        }
        classes.push_back(c);

        // TODO: Wrap this up in to a function
        // Add interface class module spec to hardware constraints
        cSpec.name = c->getName();
        cSpec.hasClock = true;
        cSpec.hasRst = true;

        for (auto vTp : c->memberVars) {
          auto tp = vTp.second;
          if (isPortType(tp)) {
            if (isOutputPort(tp)) {
              addOutputPort(cSpec.ports, portWidth(tp), vTp.first);
            } else {
              assert(isInputPort(tp));

              // Set non-default values to be insensitive
              string portName = vTp.first;
              if (!contains_key(portName, cSpec.defaultValues)) {
                cSpec.insensitivePorts.insert(portName);
              }
              addInputPort(cSpec.ports, portWidth(tp), vTp.first);
            }
          }
        }
        cout << "class has name " << c->getName() << endl;
        hcs.typeSpecs[c->getName()] = [cSpec](StructType* tp) { return cSpec; };
        hcs.hasTypeSpec(c->getName());

        cgs.symtab.popTable();
        cgs.popClassContext();
        
      } else if (FunctionDecl::classof(stmt)) {
        auto fd = static_cast<FunctionDecl*>(stmt);
        vector<Type*> inputTypes = functionInputs(fd);
        auto sf = new SynthCppFunction();
        sf->nameToken = fd->name;
        //activeSymtab = &(sf->symtab);
        cgs.symtab.pushTable(&(sf->symtab));

        // Add return type as first argument
        llvm::Function* f = mkFunc(inputTypes, llvmTypeFor(fd->returnType), sf->getName());

        // Add this function to the interface functions
        interfaces.addFunction(f);
        sf->constraints = &interfaces.getConstraints(f);

        auto bb = mkBB("entry_block", f);
        cgs.setActiveBlock(bb);
        
        //IRBuilder<> b(bb);

        //bool hasReturn = sf->hasReturnValue();
        auto bd = cgs.builder();
        setArgumentSymbols(bd, sf->symtab, fd->args, f, 0);

        // Now need to iterate over all statements in the body creating labels
        // that map to starts and ends of statements
        // and also adding code for each statement to the resulting function, f.
        sf->func = f;        
        activeFunction = sf;
        cout << "# of statements = " << fd->body.size() << endl;
        for (auto stmt : fd->body) {
          cout << "Statement" << endl;
          genLLVM(stmt);
        }

        BasicBlock* activeBlock = &(cgs.getActiveBlock());
          //&(activeFunction->llvmFunction()->getEntryBlock());
        if (activeBlock->getTerminator() == nullptr) {
          cout << "Basic block " << valueString(activeBlock) << "has no terminator" << endl;
          cgs.builder().CreateRet(nullptr);
        }

        // IC: Need to loosen this based on IC constraints
        // And: Need to add hazard handling for pipelines
        // Set all calls to be sequential by default
        vector<ICHazard> hazards;
        if (f->getName() == "histogram") {
          hazards.push_back({"hread", "hwrite", true, true, 0, CMP_LTEZ});
          hazards.push_back({"hwrite", "hread", false, true, 0, CMP_LTEZ});
        } else if (f->getName() == "histogram_fwd") {
          hazards.push_back({"fhread", "fhwrite", true, true, 0, CMP_LTEZ});
          hazards.push_back({"fhwrite", "fhread", true, true, 0, CMP_LTEZ});
        }

        // TODO: Add pipeline calls here as well?
        sequentialCalls(f, interfaces.getConstraints(f), hazards);
        
        functions.push_back(sf);
        activeFunction = nullptr;

        sanityCheck(f);

        cgs.symtab.popTable();
      }
    }

  }

  map<std::string, llvm::Value*> valueMap;

  bool hasValue(Token t) const {
    return contains_key(t.getStr(), valueMap);
  }
  
  llvm::Value* getValueFor(Token t) {
    cout << "Getting value for " << t.getStr() << endl;
    assert(contains_key(t.getStr(), valueMap));
    return map_find(t.getStr(), valueMap);
  }

  void setValue(Token t, llvm::Value* v) {
    valueMap[t.getStr()] = v;
    assert(contains_key(t.getStr(), valueMap));    
  }

  EventTime eventFromLabel(string arg0Name, const string& labelName) {
    if (contains_key(Token(arg0Name), labelsToInstructions)) {
      Instruction* instrLabel = map_find(Token(arg0Name), labelsToInstructions);
      cout << "Instruction labeled = " << valueString(instrLabel) << endl;
      
      if (labelName == "start") {
        return {ExecutionAction(instrLabel), false, 0};
      } else {
        assert(labelName == "end");
        return {ExecutionAction(instrLabel), true, 0};
      }
    } else {
      assert(contains_key(Token(arg0Name), labelsToBlockStarts));
      assert(contains_key(Token(arg0Name), labelsToBlockEnds));

      if (labelName == "start") {
        BasicBlock* blkLabel = map_find(Token(arg0Name), labelsToBlockStarts);
        return {ExecutionAction(blkLabel), false, 0};        
      } else {
        assert(labelName == "end");

        BasicBlock* blkLabel = map_find(Token(arg0Name), labelsToBlockEnds);
        return {ExecutionAction(blkLabel), true, 0};
      }
    }
  }

  EventTime parseEventTime(Expression* const e) {
    auto mBop = extractM<BinopExpr>(e);
    if (mBop.has_value()) {
      auto bop = mBop.get_value();
      Token op = bop->op;
      EventTime tm = parseEventTime(bop->lhs);
      cout << "Integer rhs type = " << bop->rhs->getKind() << endl;
      IntegerExpr* val = extract<IntegerExpr>(bop->rhs);

      return tm + val->getInt();
    } else {
      cout << "Call type = " << e->getKind() << endl;      
      auto labelCall = extract<FunctionCall>(e);
      string name = labelCall->funcName.getStr();
      cout << "name = " << name << endl;
      assert((name == "start") || (name == "end"));

      Expression* arg0 = labelCall->args.at(0);
      cout << "arg0Kind = " << arg0->getKind() << endl;
      auto arg0Id = extract<Identifier>(arg0);
      string arg0Name = arg0Id->getName();

      cout << "got arg0 name = " << arg0Name << endl;

      return eventFromLabel(arg0Name, name);
    }
  }

  ExecutionConstraint* parseConstraint(Expression* const e) {
    BinopExpr* bop = extract<BinopExpr>(e);
    Token op = bop->op;
    cout << "Parsing binop = " << op << endl;
    assert(isComparator(op));

    Expression* lhs = bop->lhs;
    EventTime lhsTime = parseEventTime(lhs);
    Expression* rhs = bop->rhs;
    EventTime rhsTime = parseEventTime(rhs);

    if (op.getStr() == "==") {
      return lhsTime == rhsTime;
    } else if (op.getStr() == "<") {
      return lhsTime < rhsTime;
    } else {
      assert(false);
    }
  }

  bool isData(Type* const tp) {
    if (IntegerType::classof(tp)) {
      return true;
    }

    if (StructType::classof(tp)) {
      StructType* stp = dyn_cast<StructType>(tp);
      return stp->elements().size() > 0;
    }

    return false;
  }
  
  llvm::Value* genLLVM(Expression* const e) {
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
        cout << "Width of port " << labelId->getName() << " in class " << cgs.activeClass->getName() << " is " << outWidth << endl;

        SynthCppClass* sExpr = cgs.getActiveClass();
        SynthCppType* classTp = new SynthCppStructType(sExpr->name);
        Type* structType = llvmTypeFor(classTp);

        auto f =
          readPort(labelId->name.getStr(), outWidth, structType->getPointerTo());

        cout << "read port function = " << valueString(f) << endl;
        
        assert(activeFunction != nullptr);
        assert(activeFunction->llvmFunction() != nullptr);

        cout << "Active function = " << activeFunction->nameToken << endl;
        cout << valueString(activeFunction->llvmFunction()) << endl;
        
        int thisOffset = 0;
        return bd.CreateCall(f, {getArg(activeFunction->llvmFunction(), thisOffset)});
      }

      // Generate llvm for each argument
      vector<Value*> args;

      for (auto arg : called->args) {
        args.push_back(genLLVM(arg));
      }

      // TODO: Need to change width here
      string fName = called->funcName.getStr();
      cout << "fName = " << fName << endl;
      SynthCppFunction* calledFunc = nullptr;
      if ((fName == "read_port")) {
        assert(false);
      } else if (fName == "set_port") {
        assert(false);
      } else {
        calledFunc = getFunction(called->funcName.getStr());
      }
      assert(calledFunc != nullptr);

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
        }
        args.push_back(argLLVM);
      }

      return bd.CreateCall(calledFunc->llvmFunction(), args);

    } else if (IntegerExpr::classof(e)) {
      IntegerExpr* i = static_cast<IntegerExpr* const>(e);
      string digits = i->digits;
      auto val = stoi(digits);
      return mkInt(val, 32);
    } else {
      cout << "Unsupported expression in LLVM codegen" << endl;
      assert(false);      
    }
  }

  SynthCppType* getTypeForId(const Token id) {
    return cgs.symtab.getType(id.getStr());
  }

  SynthCppClass* getClassByName(const Token id) {
    for (auto c : classes) {
      if (c->getName() == id.getStr()) {
        return c;
      }
    }

    cout << "Error: Cannot find class with name " << id << endl;
    assert(false);
  }
  
  SynthCppClass* getClass(const Token id) {
    string idName = id.getStr();
    cout << "Getting class for " << idName << endl;
    SynthCppType* tp = getTypeForId(id);

    cout << "Got type for " << idName << endl;

    auto classType = extractBaseStructType(tp);
    for (auto c : classes) {
      if (c->name == classType->name) {
        return c;
      }
    }

    assert(false);
  }

  void genLLVM(ForStmt* const stmt) {
    Statement* init = stmt->init;
    Expression* exitTest = stmt->exitTest;
    Statement* update = stmt->update;
    auto stmts = stmt->stmts;
    
    auto bd = cgs.builder();

    // Need entry block to check
    auto loopTestBlock = mkBB( "for_blk_init_test_" + uniqueNumString(), activeFunction->llvmFunction());
    auto loopBodyBlock = mkBB( "for_body_" + uniqueNumString(), activeFunction->llvmFunction());
    auto nextBlock = mkBB( "for_body_" + uniqueNumString(), activeFunction->llvmFunction());    

    genLLVM(init);
    bd.CreateBr(loopTestBlock);

    cgs.setActiveBlock(loopTestBlock);
    auto testCond = genLLVM(exitTest);
    cgs.builder().CreateCondBr(testCond, loopBodyBlock, nextBlock);

    cgs.setActiveBlock(loopBodyBlock);
    for (auto stmt : stmts) {
      genLLVM(stmt);
    }
    genLLVM(update);
    cgs.builder().CreateBr(loopTestBlock);

    // Need major work block

    // Need exit block
    cgs.setActiveBlock(nextBlock);
  }
  
  void genLLVM(ArgumentDecl* const decl) {
    auto bd = cgs.builder();
    
    string valName = decl->name.getStr();
    Type* tp = llvmTypeFor(decl->tp);
    // TODO: add to name map?
    cgs.symtab.setType(valName, decl->tp);
    //auto n = b.CreateAlloca(tp, nullptr, valName);
    auto n = bd.CreateAlloca(tp, nullptr, valName);
    // Add to constraints?
    int width = getTypeBitWidth(tp);
    setMemSpec(n, getHardwareConstraints(), {0, 0, 1, 1, width, 1, false, {{{"width", std::to_string(width)}}, "register"}});
    setValue(decl->name, n);
  }

  void genLLVM(AssignStmt* const stmt) {

    // Note: Should really be an expression
    Token t = stmt->var;
    Expression* newVal = stmt->expr;

    Value* v = genLLVM(newVal);

    if (stmt->hasLabel()) {
      Token l = stmt->label;
      cout << "Label on assign = " << stmt->label << endl;

      // TODO: Remove this hack and replace with something more general
      //BasicBlock* blk = &(activeFunction->llvmFunction()->getEntryBlock());
      BasicBlock* blk = &(cgs.getActiveBlock());
      cout << "Block for label = " << valueString(blk) << endl;
      Instruction* last = &(blk->back());

      cout << "Last instruction" << valueString(last) << endl;
      labelsToInstructions[stmt->label] = last;
    }

    Value* tV = getValueFor(t);

    genSetCode(tV, v);
  }

  void genLLVM(ReturnStmt* const stmt) {
    auto bd = cgs.builder();

    Expression* retVal = stmt->returnVal;
    Value* v = nullptr;
    if (retVal != nullptr) {
      v = genLLVM(retVal);
    }
    bd.CreateRet(v);
    
    if (stmt->hasLabel()) {
      Token l = stmt->label;
      cout << "Label on assign = " << stmt->label << endl;
      BasicBlock* blk = &(cgs.getActiveBlock());
      cout << "Block for label = " << valueString(blk) << endl;
      Instruction* last = &(blk->back());

      cout << "Last instruction" << valueString(last) << endl;
      labelsToInstructions[stmt->label] = last;
    }

  }
  
  void genSetCode(Value* receiver, Value* value) {
    auto bd = cgs.builder();
    // Check types?
    
    Type* rType = receiver->getType();
    Type* vType = value->getType();

    cout << "receiver = " << valueString(receiver) << endl;
    cout << "value    = " << valueString(value) << endl;    
    cout << "rType = " << typeString(rType) << endl;
    cout << "vType = " << typeString(vType) << endl;

    if (rType == vType->getPointerTo()) {
      bd.CreateStore(value, receiver);
    } else {
      assert(PointerType::classof(rType));
      auto underlying = dyn_cast<PointerType>(rType)->getElementType();
      if (isData(underlying) &&
          isData(vType)) {

        auto valueCast = bvCastTo(value, underlying);
        assert(rType == valueCast->getType()->getPointerTo());
        bd.CreateStore(valueCast, receiver);
      } else {
        cout << "Error: Incompatible types in assignment, receiver "
             << valueString(receiver) << ", value " << valueString(value) << endl;
      }
    }
  }

  void genLLVM(DoWhileLoop* stmt) {
    cout << "Do while loop" << endl;
    Expression* test = stmt->test;
    vector<Statement*> stmts = stmt->body;

    auto lastBlock = cgs.builder();
    auto loopBlock =
      mkBB("while_loop_" + uniqueNumString(), activeFunction->llvmFunction());
    lastBlock.CreateBr(loopBlock);

    cgs.setActiveBlock(loopBlock);

    // Create exit block
    auto nextBlock =
      mkBB("after_while_" + uniqueNumString(), activeFunction->llvmFunction());

    for (auto stmt : stmts) {
      genLLVM(stmt);
    }

    // End of loop
    auto exitCond = genLLVM(test);
    cgs.builder().CreateCondBr(exitCond, loopBlock, nextBlock);
    
    cgs.setActiveBlock(nextBlock);

    if (stmt->hasLabel()) {
      Token label = stmt->getLabel();
      labelsToBlockStarts[label] = loopBlock;
      labelsToBlockEnds[label] = loopBlock;
    }
  }
  
  void genLLVM(Statement* const stmt) {
    auto bd = cgs.builder();
    
    if (ExpressionStmt::classof(stmt)) {
      auto es = static_cast<ExpressionStmt* const>(stmt);
      Expression* e = es->expr;
      genLLVM(e);


      if (stmt->hasLabel()) {
        Token l = stmt->label;
        cout << "Label = " << stmt->label << endl;
        //BasicBlock* blk = &(activeFunction->llvmFunction()->getEntryBlock());
        BasicBlock* blk = &(cgs.getActiveBlock());        
        cout << "Block for label = " << valueString(blk) << endl;
        Instruction* last = &(blk->back());

        cout << "Last instruction" << valueString(last) << endl;
        labelsToInstructions[stmt->label] = last;
      }
      
    } else if (ArgumentDecl::classof(stmt)) {
      auto decl = static_cast<ArgumentDecl* const>(stmt);
      genLLVM(decl);
    } else if (ForStmt::classof(stmt)) {
      auto loop = static_cast<ForStmt* const>(stmt);
      genLLVM(loop);
    } else if (AssignStmt::classof(stmt)) {
      auto asg = static_cast<AssignStmt* const>(stmt);
      genLLVM(asg);
      
    } else if (ReturnStmt::classof(stmt)) {
      genLLVM(sc<ReturnStmt>(stmt));
    } else if (DoWhileLoop::classof(stmt)) {
      genLLVM(sc<DoWhileLoop>(stmt));
    } else {
      // Add support for variable declarations, assignments, and for loops
      cout << "No support for code generation for statement" << endl;
    }

    if (stmt->hasLabel()) {
      cout << "Label = " << stmt->label << endl;
      // How do I tag statement starts and ends with a label?
      // Crude: Track the active block in CodeGenState and just attach
      // the start and end to the last instruction?
    }
    
  }

  SynthCppFunction* getFunction(const std::string& name) {
    cout << "Getting function for " << name << endl;

    if (name == "set_port") {
      assert(false);
    }

    if (name == "add_constraint") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("add_constraint", inputs, new VoidType());
      
      return stb;
    }


    if (name == "start") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("start", inputs, new SynthCppStructType(Token("bit_32")));
      return stb;
    }

    if (name == "end") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("end", inputs, new SynthCppStructType(Token("bit_32")));
      return stb;
    }

    if (name == "read_port") {
      assert(false);
    }
    
    for (auto f : functions) {
      cout << "f name = " << f->getName() << endl;
      cout << "name   = " << name << endl;
      if (f->getName() == name) {
        return f;
      }
    }
    assert(false);
  }

  HardwareConstraints& getHardwareConstraints() {
    return hcs;
  }

  InterfaceFunctions& getInterfaceFunctions() {
    return interfaces;
  }

  std::set<BasicBlock*>& getBlocksToPipeline() {
    return blocksToPipeline;
  }
  
  std::vector<SynthCppClass*> getClasses() const {
    return classes;
  }

  std::vector<SynthCppFunction*> getFunctions() const {
    return functions;
  }

};

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
    scheduleInterfaceZeroReg(f->llvmFunction(),
                             scppMod.getHardwareConstraints(),
                             scppMod.getInterfaceFunctions(),
                             scppMod.getBlocksToPipeline(),
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

void checkRAMContents(const std::string& ramName,
                      int startCycle,
                      vector<string>& expectedValues,
                      TestBenchSpec& tb) {
  for (int i = 0; i < expectedValues.size(); i++) {
    string next = expectedValues[i];
    int time = startCycle + i;
    //tb.actionOnCondition("total_cycles == " + to_string(time), ramName + "_debug_addr <= 1;");

    tb.actionsInCycles[time].push_back(ramName + "_debug_addr = " + to_string(i) + ";");
    string argData = ramName + "_debug_data";
    string cond = ramName + "_debug_data === " + next;
    string assertString = "if (!(" + cond + ")) begin $display(\"ERROR in cycle %d: addr " + to_string(i) + " should be " + next + ", but is %d\", total_cycles, " + argData + "); $finish(1); end";
    
    tb.actionsInCycles[time].push_back(assertString);
    
    //("total_cycles == " + to_string(time + 1), assertString);
  }
}

void setRAM(const std::string& ramName,
            int startCycle,
            vector<string>& values,
            TestBenchSpec& tb) {
  for (int i = 0; i < values.size(); i++) {
    string next = values[i];
    int time = startCycle + i;
    tb.actionOnCondition("total_cycles == " + to_string(time), ramName + "_debug_write_en <= 1;");
    tb.actionOnCondition("total_cycles == " + to_string(time), ramName + "_debug_write_addr <= " + to_string(i) + ";");
    tb.actionOnCondition("total_cycles == " + to_string(time), ramName + "_debug_write_data <= " + next + ";");
  }

  tb.actionOnCondition("total_cycles == " + to_string(startCycle + values.size()), ramName + "_debug_write_en <= 0;");
}

int main() {

  {
    ifstream t("./experiments/hist_rams.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    assert(parseMod.getStatements().size() >= 2);

    SynthCppModule scppMod(parseMod);

    assert(scppMod.getClasses().size() >= 1);
    assert(scppMod.getFunctions().size() >= 1);

    auto arch = synthesizeVerilog(scppMod, "histogram");

    cout << "Histogram STG" << endl;
    arch.stg.print(cout);

    assert(arch.stg.pipelines.size() == 1);
    Pipeline p = *begin(arch.stg.pipelines);
    cout << "Pipeline ii = " << p.II() << endl;
    
    assert(p.II() == 2);

    auto result =
      sc<Argument>(getArg(scppMod.getFunction("histogram")->llvmFunction(),
                          0));

    auto h =
      sc<Argument>(getArg(scppMod.getFunction("histogram")->llvmFunction(),
                          1));
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.maxCycles = 500;
    tb.name = "histogram";
    tb.useModSpecs = true;
    tb.settablePort(result, "debug_addr");    
    tb.settablePort(result, "debug_write_addr");
    tb.settablePort(result, "debug_write_data");
    tb.settablePort(result, "debug_write_en");

    tb.settablePort(h, "debug_addr");        
    tb.settablePort(h, "debug_write_addr");
    tb.settablePort(h, "debug_write_data");
    tb.settablePort(h, "debug_write_en");
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 110, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 111, string("rst_reg <= 0;"));

    // Note: No forwarding yet
    vector<string> values;
    for (int i = 0; i < 100; i++) {
      values.push_back(to_string(i));
    }
    setRAM("arg_0", 1, values, tb);

    vector<string> hValues;
    for (int i = 0; i < 256; i++) {
      hValues.push_back(to_string(0));
    }
    setRAM("arg_1", 1, hValues, tb);
    
    vector<string> expectedValues;
    for (int i = 0; i < 100; i++) {
      expectedValues.push_back(to_string(1));
    }
    checkRAMContents("arg_1", 300, expectedValues, tb);
    
    emitVerilogTestBench(tb, arch, testLayout);

    assert(runIVerilogTest("histogram_tb.v", "histogram", " builtins.v RAM.v delay.v ram_primitives.v histogram.v HistRAM.v ImgRAM.v"));
  }

  {
    ifstream t("./experiments/hist_rams.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());
    auto tokens = tokenize(str);
    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    assert(parseMod.getStatements().size() >= 2);

    SynthCppModule scppMod(parseMod);

    assert(scppMod.getClasses().size() >= 1);
    assert(scppMod.getFunctions().size() >= 1);

    auto arch = synthesizeVerilog(scppMod, "histogram_fwd");

    cout << "Histogram STG" << endl;
    arch.stg.print(cout);

    assert(arch.stg.pipelines.size() == 1);
    Pipeline p = *begin(arch.stg.pipelines);
    cout << "Pipeline ii = " << p.II() << endl;
    
    assert(p.II() == 1);

    auto result =
      sc<Argument>(getArg(scppMod.getFunction("histogram_fwd")->llvmFunction(),
                          0));

    auto h =
      sc<Argument>(getArg(scppMod.getFunction("histogram_fwd")->llvmFunction(),
                          1));
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.maxCycles = 500;
    tb.name = "histogram_fwd";
    tb.useModSpecs = true;
    tb.settablePort(result, "debug_addr");    
    tb.settablePort(result, "debug_write_addr");
    tb.settablePort(result, "debug_write_data");
    tb.settablePort(result, "debug_write_en");

    tb.settablePort(h, "debug_addr");        
    tb.settablePort(h, "debug_write_addr");
    tb.settablePort(h, "debug_write_data");
    tb.settablePort(h, "debug_write_en");
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 110, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 111, string("rst_reg <= 0;"));

    // Note: No forwarding yet
    vector<string> values;
    for (int i = 0; i < 100; i++) {
      values.push_back(to_string(10));
    }
    setRAM("arg_0", 1, values, tb);

    vector<string> hValues;
    for (int i = 0; i < 256; i++) {
      hValues.push_back(to_string(0));
    }
    setRAM("arg_1", 1, hValues, tb);
    
    vector<string> expectedValues;
    for (int i = 0; i < 100; i++) {
      if (i == 10) {
        expectedValues.push_back(to_string(100));        
      } else {
        expectedValues.push_back("0");
      }
      //expectedValues.push_back(to_string(1));
    }
    checkRAMContents("arg_1", 400, expectedValues, tb);
    
    emitVerilogTestBench(tb, arch, testLayout);

    assert(runIVerilogTest("histogram_fwd_tb.v", "histogram_fwd", " builtins.v RAM.v delay.v ram_primitives.v histogram_fwd.v FwdHistRAM.v ImgRAM.v"));
  }

  {
    ifstream t("./experiments/hist_rams.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());
    auto tokens = tokenize(str);
    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    assert(parseMod.getStatements().size() >= 2);

    SynthCppModule scppMod(parseMod);

    assert(scppMod.getClasses().size() >= 1);
    assert(scppMod.getFunctions().size() >= 1);

    auto arch = synthesizeVerilog(scppMod, "histogram_fwd");

    cout << "Histogram STG" << endl;
    arch.stg.print(cout);

    assert(arch.stg.pipelines.size() == 1);
    Pipeline p = *begin(arch.stg.pipelines);
    cout << "Pipeline ii = " << p.II() << endl;
    
    assert(p.II() == 1);

    auto result =
      sc<Argument>(getArg(scppMod.getFunction("histogram_fwd")->llvmFunction(),
                          0));

    auto h =
      sc<Argument>(getArg(scppMod.getFunction("histogram_fwd")->llvmFunction(),
                          1));
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.maxCycles = 500;
    tb.name = "histogram_fwd";
    tb.useModSpecs = true;
    tb.settablePort(result, "debug_addr");    
    tb.settablePort(result, "debug_write_addr");
    tb.settablePort(result, "debug_write_data");
    tb.settablePort(result, "debug_write_en");

    tb.settablePort(h, "debug_addr");        
    tb.settablePort(h, "debug_write_addr");
    tb.settablePort(h, "debug_write_data");
    tb.settablePort(h, "debug_write_en");
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 110, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 111, string("rst_reg <= 0;"));

    // Note: No forwarding yet
    vector<string> values;
    for (int i = 0; i < 100; i++) {
      values.push_back(to_string(i));
    }
    setRAM("arg_0", 1, values, tb);

    vector<string> hValues;
    for (int i = 0; i < 256; i++) {
      hValues.push_back(to_string(0));
    }
    setRAM("arg_1", 1, hValues, tb);
    
    vector<string> expectedValues;
    for (int i = 0; i < 100; i++) {
      expectedValues.push_back(to_string(1));
    }
    checkRAMContents("arg_1", 400, expectedValues, tb);
    
    emitVerilogTestBench(tb, arch, testLayout);

    assert(runIVerilogTest("histogram_fwd_tb.v", "histogram_fwd", " builtins.v RAM.v delay.v ram_primitives.v histogram_fwd.v FwdHistRAM.v ImgRAM.v"));
  }
  
  {
    string test = "class ip_header { };";
    vector<Token> tokens = tokenize(test);

    cout << "# of tokens " << tokens.size() << endl;

    assert(tokens.size() == 5);
  }

  {
    string test = "void write(bit32 data, bit5 addr) { set_port(wen, 1); set_port(wdata, data); set_port(waddr, addr); }";

    vector<Token> tokens = tokenize(test);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    assert(tokens[2].getStr() == "(");
    assert(tokens.back().getStr() == "}");    
  }

  {
    string test = "bits[5 : 0]";

    vector<Token> tokens = tokenize(test);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    assert(tokens.size() == 6);
    assert(tokens[0].getStr() == "bits");
    assert(tokens[3].getStr() == ":");
  }

  {
    string test = "x == 8";

    vector<Token> tokens = tokenize(test);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    assert(tokens.size() == 3);
    assert(tokens[1].getStr() == "==");
  }

  {
    string test = "x = 8 == 7";

    vector<Token> tokens = tokenize(test);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    assert(tokens.size() == 5);
    assert(tokens[1].getStr() == "=");
    assert(tokens[3].getStr() == "==");
  }
  
  {
    string test = "(8 - x) * 4 + 7";

    vector<Token> tokens = tokenize(test);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    assert(tokens.size() == 9);
    assert(tokens[1].getStr() == "8");
    assert(tokens[5].getStr() == "*");
  }

  {
    std::string str = "input_23";
    ParseState<Token> st(tokenize(str));
    auto tp = parseType(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "void";
    ParseState<Token> st(tokenize(str));
    auto tp = parseType(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();

    cout << "Passed parse void" << endl;
  }
  
  {
    std::string str = "void write(bit_5 addr, bit_32 data) {}";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "void write_packet(bit_5 addr, fifo& payload) {}";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  // {
  //   std::string str = "return readValue;";
  //   cout << "TEST CASE: " << str << endl;
    
  //   ParseState<Token> st(tokenize(str));
  //   auto tp = parseStatement(st);
  //   assert(tp.has_value());

  //   cout << "Statement = " << *(tp.get_value()) << endl;
  //   cout << "Remainder = " << st.remainder() << endl;
  //   assert(st.atEnd());

  //   auto rStmt = extractM<ReturnStmt>(tp.get_value());

  //   assert(rStmt.has_value());

  //   delete tp.get_value();
  // }
  
  {
    std::string str = "input_23 wdata;";
    cout << "TEST CASE: " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "input wdata[23]";
    ParseState<Token> st(tokenize(str));
    auto tp = parseArgDeclMaybe(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "// Hello this is a comment\ninput wdata[23]";
    //std::string str = "input wdata[23]";    
    ParseState<Token> st(tokenize(str));
    auto tp = parseArgDeclMaybe(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }
  
  {
    std::string str = "set_wdata: set_port(wen, 1);";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "read()";
    cout << "TEST CASE " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseExpressionMaybe(st);
    assert(tp.has_value());

    assert(st.atEnd());

    cout << "done with read" << endl;
    
    delete tp.get_value();
  }
  
  {
    std::string str = "start(set_wen)";
    cout << "TEST CASE " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseFunctionCall(st);
    assert(tp.has_value());

    assert(st.atEnd());

    cout << "done with " << str << endl;
    delete tp.get_value();
  }

  {
    std::string str = "start(set_wen) == start(set_wdata)";

    cout << "TEST CASE " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseExpressionMaybe(st);
    assert(tp.has_value());

    assert(st.atEnd());

    cout << "done with " << str << endl;

    delete tp.get_value();
  }
  
  {
    std::string str = "add_constraint(start(set_wen) == start(set_wdata));";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {

    std::string str = "start(set_wdata) + 3 == end(set_waddr)";
    cout << "TEST CASE " << str << endl;
    ParseState<Token> st(tokenize(str));
    auto tp = parseExpressionMaybe(st);
    assert(tp.has_value());

    assert(st.atEnd());

    auto be = extractM<BinopExpr>(tp.get_value());
    assert(be.has_value());
    cout << "be op = " << be.get_value()->op << endl;
    
    assert(be.get_value()->op == Token("=="));

    cout << "done with " << str << endl;
    
    delete tp.get_value();
  }

  {
    std::string str = "class ram {};";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "read_ready: is_ready = read_port(s_eth_hdr_ready);";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }
  
  {
    std::string str = "transmitter->write_header(dest_mac, src_mac, type)";
    cout << "TEST CASE " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseExpressionMaybe(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "transmitter->write_byte(payload->read(), is_last)";
    cout << "TEST CASE " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseExpressionMaybe(st);
    assert(tp.has_value());

    cout << "Remaining state = " << st.remainder() << endl;
    assert(st.atEnd());

    delete tp.get_value();
  }


  {
    std::string str = "(i < 320*320)";
    cout << "TEST CASE " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseExpressionMaybe(st);
    assert(tp.has_value());

    cout << "Remaining state = " << st.remainder() << endl;
    assert(st.atEnd());

    delete tp.get_value();
  }
  
  {
    std::string str = "transmitter->write_header(dest_mac, src_mac, type);";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {

    std::string str = "i = i + 1";
    cout << "TEST CASE << " << str << endl;
    
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "for (i = 0; i < payload_size; i = i + 1) {}";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }
  
  {
    std::string str = "for (i = 0; i < payload_size; i = i + 1) {"
      "bit_1 is_last;"
      "transmitter->write_byte(payload->read(), is_last);}";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "for (i = 0; i < payload_size; i = i + 1) {"
      "is_last = i == (payload_size - 1);"
      "}";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {

    std::string str = "do { i = i + 1; } while (i);";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "do { i = i + 1; } while (i < 320*320);";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str =
      "in_word0.write_wire_32(read_port(word0));";

    cout << "TEST CASE: " << str << endl;

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    cout << "Result statement = " << *(tp.get_value()) << endl;
    assert(st.atEnd());

    delete tp.get_value();
  }
  
  {
    std::string str =
    "do {"
      "in_word0.write_wire_32(read_port(word0));"
      "i = i + 1;"
      "} while (i < 320*320);";

    cout << "TEST CASE: " << str << endl;

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }
  
  cout << "Done with statement tests" << endl;

  {
    ifstream t("./experiments/axi_iclass.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_read_burst_func");

      map<llvm::Value*, int> layout = {};
      TestBenchSpec tb;
      auto result =
        sc<Argument>(getArg(scppMod.getFunction("axi_read_burst_func")->llvmFunction(),
                            0));
      map<string, int> testLayout = {};
      tb.runCycles = 30;
      tb.maxCycles = 60; // No
      tb.name = "axi_read_burst_func";
      tb.useModSpecs = true;
      tb.settablePort(result, "read_valid");

      tb.setArgPort(result, "read_valid", 0, "0");
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));        
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      tb.setArgPort(result, "read_valid", 20, "1");
      tb.setArgPort(result, "read_valid", 21, "0");

      map_insert(tb.actionsOnCycles, 21, assertString("arg_0_out_data === (34)"));

      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("axi_read_burst_func_tb.v", "axi_read_burst_func", " builtins.v axi_read_burst_func.v RAM.v delay.v ram_primitives.v axi_ram.v"));
    }

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_burst_multi");

      map<llvm::Value*, int> layout = {};
      TestBenchSpec tb;
      auto result =
        sc<Argument>(getArg(scppMod.getFunction("axi_burst_multi")->llvmFunction(),
                            0));
      map<string, int> testLayout = {};
      tb.runCycles = 50;
      tb.maxCycles = 60; // No
      tb.name = "axi_burst_multi";
      tb.useModSpecs = true;
      tb.settablePort(result, "read_valid");

      tb.setArgPort(result, "read_valid", 0, "0");
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));        
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      int checkStart = 40;
      tb.setArgPort(result, "read_valid", checkStart, "1");
      tb.setArgPort(result, "read_valid", checkStart + 1, "1");
      tb.setArgPort(result, "read_valid", checkStart + 2, "1");
      tb.setArgPort(result, "read_valid", checkStart + 3, "1");
      tb.setArgPort(result, "read_valid", checkStart + 4, "0");      

      map_insert(tb.actionsOnCycles, checkStart + 1, assertString("arg_0_out_data === (1)"));
      map_insert(tb.actionsOnCycles, checkStart + 2, assertString("arg_0_out_data === (2)"));
      map_insert(tb.actionsOnCycles, checkStart + 3, assertString("arg_0_out_data === (3)"));
      map_insert(tb.actionsOnCycles, checkStart + 4, assertString("arg_0_out_data === (4)")); 

      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("axi_burst_multi_tb.v", "axi_burst_multi", " builtins.v axi_burst_multi.v RAM.v delay.v ram_primitives.v axi_ram.v"));
    }

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_write_burst");

      map<llvm::Value*, int> layout = {};
      TestBenchSpec tb;
      auto result =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            0));
      auto input =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            1));
      auto size =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            2));
      auto startLoc =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            3));
      
      map<string, int> testLayout = {};
      tb.runCycles = 100;
      tb.maxCycles = 150; // No
      tb.name = "axi_write_burst";
      tb.useModSpecs = true;
      tb.settablePort(input, "write_valid");
      tb.settablePort(input, "in_data");            
      tb.settablePort(result, "read_valid");

      tb.settablePort(size, "wen");
      tb.settablePort(size, "wdata");            

      tb.settablePort(startLoc, "wen");
      tb.settablePort(startLoc, "wdata");            

      tb.setArgPort(size, "wen", 4, "1");
      tb.setArgPort(size, "wdata", 4, "4");
      tb.setArgPort(size, "wen", 5, "0");      

      tb.setArgPort(startLoc, "wen", 4, "1");
      tb.setArgPort(startLoc, "wdata", 4, "10");      
      tb.setArgPort(startLoc, "wen", 5, "0");
      
      tb.setArgPort(result, "read_valid", 0, "0");
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      int setStartCycle = 5;
      int burstSize = 5;
      for (int i = 0; i < burstSize; i++) {
        tb.setArgPort(input, "write_valid", setStartCycle + i, "1");
        tb.setArgPort(input, "in_data", setStartCycle + i, to_string(i + 1));
      }
      tb.setArgPort(input, "write_valid", setStartCycle + burstSize, "0");
      
      int checkStart = 90;
      tb.setArgPort(result, "read_valid", checkStart, "1");
      tb.setArgPort(result, "read_valid", checkStart + 1, "1");
      tb.setArgPort(result, "read_valid", checkStart + 2, "1");
      tb.setArgPort(result, "read_valid", checkStart + 3, "1");
      tb.setArgPort(result, "read_valid", checkStart + 4, "0");      

      map_insert(tb.actionsOnCycles, checkStart + 1, assertString("arg_0_out_data === (1)"));
      map_insert(tb.actionsOnCycles, checkStart + 2, assertString("arg_0_out_data === (2)"));
      map_insert(tb.actionsOnCycles, checkStart + 3, assertString("arg_0_out_data === (3)"));
      map_insert(tb.actionsOnCycles, checkStart + 4, assertString("arg_0_out_data === (4)")); 

      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("axi_write_burst_tb.v", "axi_write_burst", " builtins.v axi_write_burst.v RAM.v delay.v ram_primitives.v axi_ram.v"));
    }

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_wb");
    }    

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_rb");
    }    

  }
      
  {
    ifstream t("./experiments/register_iclass.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    SynthCppModule scppMod(parseMod);

    cout << "Before synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
    for (auto func : scppMod.getInterfaceFunctions().constraints) {
      cout << tab(1) << "# of constraints on " <<
        string(func.first->getName()) << " = " <<
        func.second.constraints.size() << endl;
    }

    {
      auto arch = synthesizeVerilog(scppMod, "store_to_reg");

      map<llvm::Value*, int> layout = {};

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 30;
      tb.maxCycles = 100;
      tb.name = "store_to_reg";
      tb.useModSpecs = true;
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 19, assertString("arg_0_out === (15)"));
    
      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("store_to_reg_tb.v", "store_to_reg", " builtins.v store_to_reg.v RAM.v delay.v ram_primitives.v"));
    }

    {
      auto arch = synthesizeVerilog(scppMod, "instantiate_reg");
    }

  }
  
  {
    ifstream t("./experiments/ram_iclass.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    assert(parseMod.getStatements().size() >= 2);

    SynthCppModule scppMod(parseMod);

    assert(scppMod.getClasses().size() >= 1);
    assert(scppMod.getFunctions().size() >= 1);

    cout << "Before synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
    for (auto func : scppMod.getInterfaceFunctions().constraints) {
      cout << tab(1) << "# of constraints on " <<
        string(func.first->getName()) << " = " <<
        func.second.constraints.size() << endl;
    }

    auto arch = synthesizeVerilog(scppMod, "filter_ram");

    map<llvm::Value*, int> layout = {};

    auto in =
      sc<Argument>(getArg(scppMod.getFunction("filter_ram")->llvmFunction(), 0));
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 70;
    tb.maxCycles = 100;
    tb.name = "filter_ram";
    tb.useModSpecs = true;
    tb.settablePort(in, "debug_addr");
    tb.settablePort(in, "debug_write_addr");
    tb.settablePort(in, "debug_write_data");
    tb.settablePort(in, "debug_write_en");            

    tb.setArgPort(in, "debug_write_addr", 1, "0");
    tb.setArgPort(in, "debug_write_data", 1, "6");
    tb.setArgPort(in, "debug_write_en", 1, "1");    

    tb.setArgPort(in, "debug_write_addr", 2, "1");
    tb.setArgPort(in, "debug_write_data", 2, "8");
    tb.setArgPort(in, "debug_write_en", 2, "1");    

    tb.setArgPort(in, "debug_write_en", 3, "0");
    map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
    tb.setArgPort(in, "debug_addr", 76, "10");
    map_insert(tb.actionsOnCycles, 76, assertString("arg_0_debug_data === (8 + 6)"));
    
    emitVerilogTestBench(tb, arch, testLayout);

    // Need to figure out how to inline register specifications
    assert(runIVerilogTest("filter_ram_tb.v", "filter_ram", " builtins.v filter_ram.v RAM.v delay.v ram_primitives.v"));
  }

  {
    ifstream t("./experiments/eth_axi_tx.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    ParserModule mod = parse(tokens);

    cout << "Ethernet mod" << endl;
    cout << mod << endl;

    
    assert(mod.getStatements().size() >= 1);

    {
      SynthCppModule scppMod(mod);    
      auto arch = synthesizeVerilog(scppMod, "write_header_func");
    }

    {
      SynthCppModule scppMod(mod);    
      auto arch = synthesizeVerilog(scppMod, "write_byte_func");
 
      llvm::legacy::PassManager pm;
      pm.add(new LoopInfoWrapperPass());
      pm.add(new AAResultsWrapperPass());
      pm.add(new TargetLibraryInfoWrapperPass());
      pm.add(createGVNPass());
      pm.add(createDeadStoreEliminationPass());
      cout << "Before GVN pass" << endl;
      cout << valueString(scppMod.getFunction("write_byte_func")->llvmFunction()) << endl;
      
      pm.run(*(scppMod.mod.get()));

      cout << "After GVN" << endl;
      cout << valueString(scppMod.getFunction("write_byte_func")->llvmFunction()) << endl;
    }

    {
      SynthCppModule scppMod(mod);    
      auto arch = synthesizeVerilog(scppMod, "write_one_byte_packet");
      map<llvm::Value*, int> layout = {};

      auto tx =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 4));
      auto dest_mac =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 0));
      auto src_mac =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 1));
      auto type =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 2));
      auto payload =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 3));

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 200;
      tb.maxCycles = 300;
      tb.name = "write_one_byte_packet";
      tb.useModSpecs = true;
      tb.settablePort(tx, "m_axis_tready");
      tb.settablePort(dest_mac, "wdata");
      tb.settablePort(src_mac, "wdata");
      tb.settablePort(type, "wdata");
      tb.settablePort(payload, "wdata");                  

      tb.settablePort(dest_mac, "wen");
      tb.settablePort(src_mac, "wen");
      tb.settablePort(type, "wen");
      tb.settablePort(payload, "wen");                  

      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
      map_insert(tb.actionsInCycles, 1, string("arg_0_wdata <= 25;"));
      map_insert(tb.actionsInCycles, 1, string("arg_1_wdata <= 13;"));
      map_insert(tb.actionsInCycles, 1, string("arg_2_wdata <= 8;"));
      map_insert(tb.actionsInCycles, 1, string("arg_3_wdata <= 49;"));

      map_insert(tb.actionsInCycles, 1, string("arg_0_wen <= 1;"));
      map_insert(tb.actionsInCycles, 1, string("arg_1_wen <= 1;"));
      map_insert(tb.actionsInCycles, 1, string("arg_2_wen <= 1;"));
      map_insert(tb.actionsInCycles, 1, string("arg_3_wen <= 1;"));

      map_insert(tb.actionsInCycles, 2, string("arg_0_wen <= 0;"));
      map_insert(tb.actionsInCycles, 2, string("arg_1_wen <= 0;"));
      map_insert(tb.actionsInCycles, 2, string("arg_2_wen <= 0;"));
      map_insert(tb.actionsInCycles, 2, string("arg_3_wen <= 0;"));
      
      map_insert(tb.actionsInCycles, 0, string("arg_4_m_axis_tready = 1;"));
      map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
      emitVerilogTestBench(tb, arch, testLayout);

      // Need to figure out how to inline register specifications
      assert(runIVerilogTest("write_one_byte_packet_tb.v", "write_one_byte_packet", " builtins.v write_one_byte_packet.v RAM.v delay.v ram_primitives.v eth_axis_tx.v"));
      
    }

  }

  // {
  //   ifstream t("./experiments/fadd.cpp");
  //   std::string str((std::istreambuf_iterator<char>(t)),
  //                   std::istreambuf_iterator<char>());

  //   auto tokens = tokenize(str);
  //   ParserModule mod = parse(tokens);
    
  //   SynthCppModule scppMod(mod);

  //   cout << "-- Float adder" << endl;
  //   SynthCppClass* c = scppMod.getClassByName(Token("adder"));
  //   cout << *c << endl;
  //   cout << "-- End of adder" << endl;

  //   auto arch = synthesizeVerilog(scppMod, "fadd_32");

  //   map<llvm::Value*, int> layout = {};

  //   auto in0 =
  //     sc<Argument>(getArg(scppMod.getFunction("fadd_32")->llvmFunction(), 0));
  //   auto in1 =
  //     sc<Argument>(getArg(scppMod.getFunction("fadd_32")->llvmFunction(), 1));
  //   TestBenchSpec tb;
  //   map<string, int> testLayout = {};
  //   tb.memoryInit = {};
  //   tb.memoryExpected = {};
  //   tb.runCycles = 200;
  //   tb.maxCycles = 300;
  //   tb.name = "fadd_32";
  //   tb.useModSpecs = true;
  //   tb.settablePort(in0, "in_data");
  //   tb.settablePort(in1, "in_data");
      
  //   map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
  //   emitVerilogTestBench(tb, arch, testLayout);

  //   // Need to figure out how to inline register specifications
  //   //assert(runIVerilogTest("fadd_32_tb.v", "fadd_32", " builtins.v fadd_32.v"));
  // }

  class Img {
    vector<int> values;
    int nRows, nCols;

  public:

    Img(const int nRows_, const int nCols_) : nRows(nRows_), nCols(nCols_) {
      values.resize(nRows*nCols);
    }

    int get(const int i, const int j) {
      assert(i < nRows);
      assert(j < nCols);
      
      return values[i*nCols + j];
    }

    void set(const int i, const int j, const int val) {
      values[i*nCols + j] = val;
    }

  };

  {
    ifstream t("./experiments/median_filter.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    ParserModule mod = parse(tokens);
    
    SynthCppModule scppMod(mod);

    auto arch = synthesizeVerilog(scppMod, "run_median_func");

    {
    //   int imgWidth = 5;
    //   Img image(imgWidth, imgWidth);
    //   for (int i = 0; i < imgWidth; i++) {
    //     for (int j = 0; j < imgWidth; j++) {
    //       image.set(i, j, i*imgWidth + j);
    //     }
    //   }

      auto word0 =
        sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 1));
      auto word1 =
        sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 2));
      auto word2 =
        sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 3));

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 30;
      tb.maxCycles = 50;
      tb.name = "run_median_func";
      tb.useModSpecs = true;

      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
    
    //   tb.actionOnCondition("1", "$display(\"pixel1 = %d, pixel2 = %d, pixel3 = %d, pixel4 = %d\", arg_4_in_wire, arg_5_in_wire, arg_6_in_wire, arg_7_in_wire);");

    //   int loadWidth = 4;
    //   int startLoadCycle = 3;
    //   int stencilWidth = 3;

    //   int activeCycle = startLoadCycle;
    //   vector<Argument*> rows{word0, word1, word2};

    //   //for (int i = 0; i < imgWidth - (stencilWidth - 1); i++) {
    //   for (int i = 0; i < imgWidth - 1; i++) {

    //     // Clear row
    //     for (int k = 0; k < 3; k++) {
    //       setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
    //       activeCycle++;
    //     }
        
    //     for (int j = 0; j < imgWidth - (loadWidth - 1); j += loadWidth) {
    //     //for (int j = 0; j < imgWidth; j += loadWidth) {
    //       // Assemble values;
    //       for (int row = 0; row < stencilWidth; row++) {
    //         auto word = rows[row];
    //         string values = "";
    //         for (int col = 0; col < loadWidth; col++) {
    //           if ((i + row) < imgWidth) {
    //             values += "8'd" + to_string(image.get(i + row, j + col));
    //           } else {
    //             values += "8'hff";
    //           }

    //           if (col != (loadWidth - 1)) {
    //             values += ",";
    //           }
    //         }
    //         tb.setArgPort(word, "in_wire", activeCycle,
    //                       //startLoadCycle + i + (j / loadWidth),
    //                       "{" + values + "}");
    //       }
    //       activeCycle++;            
          

    //     }

    //     // setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
    //     // activeCycle++;
    //   }

    //   // for (int k = 0; k < 3; k++) {
    //   //   setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
    //   //   activeCycle++;
    //   // }
      
      tb.settablePort(word0, "in_wire");
      tb.settablePort(word1, "in_wire");
      tb.settablePort(word2, "in_wire");    

      //map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
      emitVerilogTestBench(tb, arch, testLayout);
      assert(runIVerilogTest("run_median_func_tb.v", "run_median_func", " builtins.v run_median_func.v RAM.v delay.v ram_primitives.v eth_axis_tx.v median_wires.v median.v state_machine.v node.v common_network.v dff_3_pipe.v pixel_network.v"));
    }

  }
  
}
