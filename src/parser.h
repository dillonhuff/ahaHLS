#pragma once

#include "algorithm.h"

#include <fstream>
#include <streambuf>
#include <sstream>

#include "llvm_codegen.h"
#include "verilog_backend.h"

using namespace dbhc;
using namespace std;
using namespace llvm;

namespace ahaHLS {
  
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


}
