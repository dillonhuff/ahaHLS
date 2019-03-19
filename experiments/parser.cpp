#include "algorithm.h"

#include <fstream>
#include <streambuf>
#include <sstream>
#include <functional>

#include "llvm_codegen.h"
#include "verilog_backend.h"

using namespace dbhc;
using namespace ahaHLS;
using namespace std;

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
  vector<char> chars = {'{', '}', ';', ')', '(', ',', '[', ']', ':', '-', '&', '+', '=', '>', '<', '*'};
  return elem(c, chars);
}

bool isKeyword(const std::string& str) {
  vector<string> keywords{"void", "for"};
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
  vector<string> binopStrings{"=", "==", "+", "&", "-", "/", "^", "%", "&&", "||", "<=", ">=", "<", ">"};
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
Token consumeWhile(TokenState& state, F shouldContinue) {
  string tok = "";
  while (!state.atEnd() && shouldContinue(state.peekChar())) {
    tok += state.parseChar();
  }
  return tok;
}

bool isUnderscore(const char c) { return c == '_'; }
bool isAlphaNum(const char c) { return isalnum(c); }

maybe<Token> parseStr(const std::string target, TokenState& chars) {
  string str = "";
  for (int i = 0; i < (int) target.size(); i++) {
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

Token parse_token(TokenState& state) {
  if (isalnum(state.peekChar())) {
    return consumeWhile(state, [](const char c) { return isAlphaNum(c) || isUnderscore(c); });
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
    cout << "Cannot parse " << state.remainder() << endl;
    assert(false);
  }

}

Token consumeWhitespace(TokenState& state) {
  return consumeWhile(state, isWhitespace);
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

  virtual ~Expression() {}
  
};

class FunctionCall : public Expression {
public:
  Token funcName;
  std::vector<Expression*> args;

  FunctionCall(const Token funcName_,
               const std::vector<Expression*>& args_) :
    funcName(funcName_), args(args_) {}

  virtual ExpressionKind getKind() const {
    return EXPRESSION_KIND_FUNCTION_CALL;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_FUNCTION_CALL;
  }
  
};

class MethodCall : public Expression {

public:
  
  Token callerName;
  FunctionCall* called;

  MethodCall(const Token callerName_,
             FunctionCall* called_) :
    callerName(callerName_), called(called_) {}

  virtual ExpressionKind getKind() const {
    return EXPRESSION_KIND_METHOD_CALL;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_METHOD_CALL;
  }
  
};

class Identifier : public Expression {
public:

  Token name;
  
  Identifier(const Token name_) : name(name_) {}

  std::string getName() const { return name.getStr(); }

  virtual ExpressionKind getKind() const {
    return EXPRESSION_KIND_IDENTIFIER;
  }

  static bool classof(Expression* e) {
    return e->getKind() == EXPRESSION_KIND_IDENTIFIER;
  }
  
};

enum SynthCppTypeKind {
  SYNTH_CPP_TYPE_KIND_STRUCT,
  SYNTH_CPP_TYPE_KIND_VOID,
  SYNTH_CPP_TYPE_KIND_POINTER,
  SYNTH_CPP_TYPE_KIND_LABEL,  
};

class SynthCppType {
public:

  virtual SynthCppTypeKind getKind() const { assert(false); }

  virtual ~SynthCppType() {
  }
};

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

  virtual SynthCppTypeKind getKind() const { return SYNTH_CPP_TYPE_KIND_STRUCT; }

  static bool classof(const SynthCppType* const tp) { return tp->getKind() == SYNTH_CPP_TYPE_KIND_STRUCT; }
};

class LabelType : public SynthCppType {
public:
  static bool classof(const SynthCppType* const tp) {
    return tp->getKind() == SYNTH_CPP_TYPE_KIND_LABEL;
  }

  virtual SynthCppTypeKind getKind() const { return SYNTH_CPP_TYPE_KIND_LABEL; }  
};

class VoidType : public SynthCppType {
public:

  static bool classof(const SynthCppType* const tp) { return tp->getKind() == SYNTH_CPP_TYPE_KIND_VOID; }
  
  virtual SynthCppTypeKind getKind() const { return SYNTH_CPP_TYPE_KIND_VOID; }
};

class SynthCppPointerType : public SynthCppType {
public:

  SynthCppType* elementType;
  SynthCppPointerType(SynthCppType* elem_) : elementType(elem_) {}

  SynthCppType* getElementType() { return elementType; }

  static bool classof(const SynthCppType* const tp) { return tp->getKind() == SYNTH_CPP_TYPE_KIND_POINTER; }
  
  virtual SynthCppTypeKind getKind() const { return SYNTH_CPP_TYPE_KIND_POINTER; }
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
  
};

class IntegerExpr : public Expression {
public:
  
  std::string digits;
  
  IntegerExpr(const std::string& digits_) : digits(digits_) {}

  int getInt() const { return stoi(digits); }

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
  STATEMENT_KIND_EXPRESSION
};

class Statement {
public:
  bool hasL;
  Token label;

  Statement() : hasL(false) {}

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

  static bool classof(const Statement* const stmt) {
    return stmt->getKind() == STATEMENT_KIND_ARG_DECL;
  }

  virtual StatementKind getKind() const {
    return STATEMENT_KIND_ARG_DECL;
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

  cout << "-- In method call, parsing function call " << tokens.remainder() << endl;
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

    cout << "Inside parens " << tokens.remainder() << endl;
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

maybe<Expression*> parseExpressionMaybe(ParseState<Token>& tokens) {
  cout << "-- Parsing expression " << tokens.remainder() << endl;

  vector<Expression*> exprs;
  vector<Token> binops;

  while (true) {
    auto pExpr = parsePrimitiveExpressionMaybe(tokens);
    if (!pExpr.has_value()) {
      break;
    }

    exprs.push_back(pExpr.get_value());    
    
    if (tokens.atEnd() || !isBinop(tokens.peekChar())) {
      break;
    }

    Token binop = tokens.parseChar();
    binops.push_back(binop);
    auto rest = parseExpressionMaybe(tokens);
    exprs.push_back(rest.get_value());
  }

  cout << "Got " << exprs.size() << " expressions" << endl;

  if (exprs.size() == 0) {
    cout << "No expression at " << tokens.remainder() << endl;
    return maybe<Expression*>();
  }

  assert(exprs.size() == (binops.size() + 1));

  if (binops.size() == 0) {
    cout << "returning expression, remainder = " << tokens.remainder() << endl;
    return exprs[0];
  }
  
  BinopExpr* top = sc<BinopExpr>(exprs[0]);
  for (int i = 0; i < ((int) binops.size()); i++) {
    top = new BinopExpr(top, binops[i], exprs[i + 1]);
  }

  return top;
  
  // BinopExpr* last = sc<BinopExpr>(exprs[((int) binops.size()) - 1]);
  // for (int i = ((int) binops.size()) - 1; i >= 1; i--) {
  //   last = new BinopExpr(exprs[i - 1], binops[i], last);
  // }

  // cout << "Returning expression" << endl;
  // return last;

  // auto pExpr = parsePrimitiveExpressionMaybe(tokens);
  // if (!pExpr.has_value()) {
  //   return pExpr;
  // }

  // if (tokens.atEnd() || !isBinop(tokens.peekChar())) {
  //   return pExpr;
  // }

  // Token binop = tokens.parseChar();
  // auto rest = parseExpressionMaybe(tokens);
  
  //return new BinopExpr(pExpr.get_value(), binop, rest.get_value());

  // assert(false);
}

Expression* parseExpression(ParseState<Token>& tokens) {
  auto res = parseExpressionMaybe(tokens);
  if (res.has_value()) {
    return res.get_value();
  }

  assert(false);
}

maybe<SynthCppType*> parseBaseType(ParseState<Token>& tokens) {
  if (tokens.peekChar().isId()) {
    
    //cout << tokens.peekChar() << " is id" << endl;    

    Token tpName = tokens.parseChar();

    if (tokens.atEnd() || (tokens.peekChar() != Token("<"))) {
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
      sepBtwn<ArgumentDecl*, Token>(parseArgDecl, parseComma, tokens);

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

maybe<Statement*> parseStatementNoLabel(ParseState<Token>& tokens) {
  // Try to parse for loop
  auto forStmt = tryParse<Statement*>(parseForLoop, tokens);
  if (forStmt.has_value()) {
    return forStmt;
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


llvm::Type* llvmPointerFor(SynthCppType* const tp) {
  assert(SynthCppStructType::classof(tp));
  return structType(static_cast<SynthCppStructType* const>(tp)->getName())->getPointerTo();
}

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
    return llvmPointerFor(static_cast<SynthCppPointerType* const>(tp)->getElementType());
  } else if (VoidType::classof(tp)) {
    return voidType();
  } else {
    assert(SynthCppStructType::classof(tp));
    auto st = static_cast<SynthCppStructType* const>(tp);
    if (isPrimitiveStruct(st)) {
      int width = getWidth(st);
      return intType(width);
    } else {
      Type* argTp = structType(st->getName());
      return argTp;
    }
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

  std::string getName() { return name.getStr(); }
  
  SynthCppFunction* getMethod(const Token name) {
    cout << "Getting method for " << name << endl;
    return map_find(name.getStr(), methods);
  }
};

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
    if (SynthCppPointerType::classof(argDecl->tp)) {
      inputTypes.push_back(argTp);
    } else {
      inputTypes.push_back(argTp->getPointerTo());
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

  SynthCppType* getType(const std::string& str) {
    int depth = ((int) tableStack.size()) - 1;

    for (int i = depth; i >= 0; i--) {
      if (contains_key(str, *(tableStack.at(i)))) {
        return map_find(str, *(tableStack.at(i)));
      }
    }
    
    assert(false);
  }
  
};

class CodeGenState {
public:

  SynthCppClass* activeClass;
  SynthCppFunction* activeFunction;
  int globalNum;

  SymbolTable symtab;

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
  // Note: Maybe this should be in SynthCppFunction
  std::set<BasicBlock*> blocksToPipeline;

  CodeGenState cgs;
  SynthCppFunction* activeFunction;
  int globalNum;
  // std::map<std::string, SynthCppType*>* activeSymtab;

  std::string uniqueNumString() {
    auto s = std::to_string(globalNum);
    globalNum++;
    return s;
  }

  void genLLVMCopyTo(IRBuilder<>& b,
                     llvm::Value* receiver,
                     llvm::Value* source) {
    
    b.CreateCall(mkFunc({receiver->getType(), source->getType()}, voidType(), "copy_" + typeString(receiver->getType())), {receiver, source});
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
      if (!SynthCppPointerType::classof(argDecl->tp)) {
        auto val = b.CreateAlloca(llvmTypeFor(argDecl->tp));
        genLLVMCopyTo(b, val, getArg(f, argNum + argOffset));
        setValue(argDecl->name, val);
      } else {
        setValue(argDecl->name, getArg(f, argNum));
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
            vector<Type*> argTps =
              functionInputs(methodFuncDecl);
            vector<Type*> tps;
            if (!VoidType::classof(methodFuncDecl->returnType)) {
              tps.push_back(llvmTypeFor(methodFuncDecl->returnType));
            }

            tps.push_back(llvmTypeFor(new SynthCppPointerType(new SynthCppStructType(c->name))));
            for (auto a : argTps) {
              tps.push_back(a);
            }
            SynthCppFunction* sf = new SynthCppFunction();
            activeFunction = sf;
            sf->nameToken = methodFuncDecl->name;
            auto f = mkFunc(tps, voidType(), sf->getName());
            interfaces.addFunction(f);
            sf->func = f;
            sf->retType = methodFuncDecl->returnType;
            sf->constraints = &(interfaces.getConstraints(f));

            auto bb = mkBB("entry_block", f);
            IRBuilder<> b(bb);

            bool hasReturn = sf->hasReturnValue();
            setArgumentSymbols(b, sf->symtab, methodFuncDecl->args, f, 1 + (hasReturn ? 1 : 0));
            
            for (auto stmt : methodFuncDecl->body) {
              cout << "Statement" << endl;
              genLLVM(b, stmt);
            }
            
            b.CreateRet(nullptr);

            cout << "Just generated code for method " << endl;
            cout << valueString(sf->llvmFunction()) << endl;
            c->methods[sf->getName()] = sf;

            setAllAllocaMemTypes(hcs, f, registerSpec(32));
            
            activeFunction = nullptr;            
          } else {
            assert(false);
          }
        }
        classes.push_back(c);

        // TODO: Wrap this up in to a function
        // Add interface class module spec to hardware constraints
        ModuleSpec cSpec;
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
        llvm::Function* f = mkFunc(inputTypes, voidType(), sf->getName());

        // Add this function to the interface functions
        interfaces.addFunction(f);
        sf->constraints = &interfaces.getConstraints(f);

        auto bb = mkBB("entry_block", f);
        IRBuilder<> b(bb);

        bool hasReturn = sf->hasReturnValue();
        setArgumentSymbols(b, sf->symtab, fd->args, f, hasReturn ? 1 : 0);

        // Now need to iterate over all statements in the body creating labels
        // that map to starts and ends of statements
        // and also adding code for each statement to the resulting function, f.
        sf->func = f;        
        activeFunction = sf;
        cout << "# of statements = " << fd->body.size() << endl;
        for (auto stmt : fd->body) {
          cout << "Statement" << endl;
          genLLVM(b, stmt);
        }
        b.CreateRet(nullptr);

        // Set all calls to be sequential by default
        sequentialCalls(f, interfaces.getConstraints(f));

        functions.push_back(sf);
        activeFunction = nullptr;        

        setAllAllocaMemTypes(hcs, f, registerSpec(32));
        
        cgs.symtab.popTable();
      }
    }

    for (auto c : classes) {
      for (auto m : c->methods) {
        cout << "Adding interface method " << m.second->nameToken << endl;
        interfaces.addFunction(m.second->llvmFunction());
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
      if (name == "start") {
        return {ExecutionAction(arg0Name), false, 0};
      } else {
        assert(name == "end");
        return {ExecutionAction(arg0Name), true, 0};        
      }
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
  
  llvm::Value* genLLVM(IRBuilder<>& b, Expression* const e) {
    if (Identifier::classof(e)) {

      Identifier* id = static_cast<Identifier* const>(e);
      if (!hasValue(id->name)) {      
        auto val = b.CreateAlloca(intType(32));
        setValue(id->name, val);
        return val;        
      }

      return getValueFor(id->name);
    } else if (BinopExpr::classof(e)) {
      BinopExpr* be = static_cast<BinopExpr* const>(e);
      auto l = genLLVM(b, be->lhs);
      auto r = genLLVM(b, be->rhs);

      cout << "left     = " << valueString(l) << endl;
      cout << "left tp  = " << typeString(l->getType()) << endl;      
      auto fresh = b.CreateAlloca(getPointedToType(l->getType()));
      auto bCall = mkFunc({l->getType(), r->getType(), r->getType()}, voidType(), "binop");
      auto res = b.CreateCall(bCall, {fresh, l, r});

      return res->getOperand(0);

    } else if (FunctionCall::classof(e)) {
      auto called = sc<FunctionCall>(e);

      string name = called->funcName.getStr();
      if (name == "add_constraint") {
        // TODO: Add constraint to active execonstraints
        ExecutionConstraints& exe =
          getInterfaceFunctions().getConstraints(activeFunction->llvmFunction());

        ExecutionConstraint* c =
          parseConstraint(called->args[0]);
        exe.add(c);
        return nullptr;
      }

      if (name == "set_port") {
        // TODO: Generate the correct port setting function
        Expression* labelExpr = called->args[0];

        Identifier* labelId = extract<Identifier>(labelExpr);
        Expression* valueExpr = called->args[1];
        auto vExpr = genLLVM(b, valueExpr);
        // TODO: Get llvm type of containing class

        SynthCppClass* sExpr = cgs.getActiveClass();
        SynthCppType* classTp = new SynthCppStructType(sExpr->name);
        Type* structType = llvmTypeFor(classTp);
        auto f = writePort(labelId->name.getStr(), getValueBitWidth(vExpr), structType->getPointerTo());

        assert(activeFunction != nullptr);
        assert(activeFunction->llvmFunction() != nullptr);

        cout << "Active function = " << activeFunction->nameToken << endl;
        cout << valueString(activeFunction->llvmFunction()) << endl;

        int thisOffset = 0;
        if (activeFunction->hasReturnValue()) {
          thisOffset = 1;
        }
        return b.CreateCall(f, {getArg(activeFunction->llvmFunction(), thisOffset), vExpr});
      }
      
      SynthCppFunction* calledFunc = getFunction(called->funcName.getStr());

      // Generate llvm for each argument
      vector<Value*> args;

      Value* retVal = nullptr;
      // Add return value
      if (!VoidType::classof(calledFunc->returnType())) {
        retVal = b.CreateAlloca(llvmTypeFor(calledFunc->returnType()), nullptr, "ret_val_" + uniqueNumString());
        args.push_back(retVal);
      }

      for (auto arg : called->args) {
        args.push_back(genLLVM(b, arg));
      }

      b.CreateCall(calledFunc->llvmFunction(), args);
      
      return retVal;
      
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

      Value* retVal = nullptr;
      // Add return value
      if (!VoidType::classof(calledFunc->returnType())) {
        retVal = b.CreateAlloca(llvmTypeFor(calledFunc->returnType()), nullptr, "ret_val_" + uniqueNumString());
        args.push_back(retVal);
      }

      args.push_back(getValueFor(caller));
      for (auto arg : called->args) {
        args.push_back(genLLVM(b, arg));
      }

      b.CreateCall(calledFunc->llvmFunction(), args);
      
      return retVal;
    } else if (IntegerExpr::classof(e)) {
      IntegerExpr* i = static_cast<IntegerExpr* const>(e);
      string digits = i->digits;
      auto val = stoi(digits);
      auto constStorage = b.CreateAlloca(intType(32), nullptr, "const_val_" + uniqueNumString());
      vector<Type*> ins = {intType(32)->getPointerTo(), intType(32)};

      vector<Value*> args = {constStorage, mkInt(val, 32)};
      b.CreateCall(mkFunc(ins, voidType(), "set_const"), args);
      return constStorage;
      //return mkInt(val, 32);
    } else {
      cout << "Unsupported expression in LLVM codegen" << endl;
      assert(false);      
    }
  }

  SynthCppType* getTypeForId(const Token id) {
    return cgs.symtab.getType(id.getStr()); //map_find(id.getStr(), activeSymbolTable());
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

  void genLLVM(IRBuilder<>& b, ForStmt* const stmt) {
    auto loopInitTest = mkBB( "for_blk_init_test_" + uniqueNumString(), activeFunction->llvmFunction());
    b.CreateBr(loopInitTest);
    // Actually schedule loop
    IRBuilder<> loopBuilder(loopInitTest);
    loopBuilder.CreateRet(nullptr);
  }
  
  void genLLVM(IRBuilder<>& b, ArgumentDecl* const decl) {
    string valName = decl->name.getStr();
    Type* tp = llvmTypeFor(decl->tp);
    // TODO: add to name map?
    auto n = b.CreateAlloca(tp, nullptr, valName);
    setValue(decl->name, n);
  }

  void genLLVM(IRBuilder<>& b, AssignStmt* const stmt) {

    // Note: Should really be an expression
    Token t = stmt->var;
    Expression* newVal = stmt->expr;

    Value* v = genLLVM(b, newVal);
    Value* tV = getValueFor(t);

    genSetCode(b, tV, v);
  }

  void genSetCode(IRBuilder<>& b, Value* receiver, Value* value) {
    // Check types?
    
    Type* rType = receiver->getType();
    Type* vType = value->getType();

    cout << "receiver = " << valueString(receiver) << endl;
    cout << "value    = " << valueString(value) << endl;    
    cout << "rType = " << typeString(rType) << endl;
    cout << "vType = " << typeString(vType) << endl;

    assert(rType == vType);

    auto assignFunc =
      mkFunc({rType, vType}, voidType(), "assign_" + typeString(rType));
    b.CreateCall(assignFunc, {receiver, value});
  }
  
  void genLLVM(IRBuilder<>& b, Statement* const stmt) {
    if (ExpressionStmt::classof(stmt)) {
      auto es = static_cast<ExpressionStmt* const>(stmt);
      Expression* e = es->expr;
      genLLVM(b, e);
    } else if (ArgumentDecl::classof(stmt)) {
      auto decl = static_cast<ArgumentDecl* const>(stmt);
      genLLVM(b, decl);
    } else if (ForStmt::classof(stmt)) {
      auto loop = static_cast<ForStmt* const>(stmt);
      genLLVM(b, loop);
    } else if (AssignStmt::classof(stmt)) {
      auto asg = static_cast<AssignStmt* const>(stmt);
      genLLVM(b, asg);
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

    // TODO: Generalize to work for any width input
    if (name == "set_port") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo(), intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("set_port", inputs, new VoidType());
      return stb;
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
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("read_port", inputs, new SynthCppStructType(Token("bit_32")));
      return stb;
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

void compileIR(ParserModule& parseMod, llvm::Module* mod) {
  
}


void synthesizeVerilog(SynthCppModule& scppMod, const std::string& funcName) {
  SynthCppFunction* f = scppMod.getFunction(funcName);

  // Q: How do we pass the hardware constraints on f in to the synthesis flow?
  cout << "Scheduling function" << endl;
  cout << valueString(f->llvmFunction()) << endl;
  Schedule s = scheduleInterface(f->llvmFunction(), scppMod.getHardwareConstraints(), scppMod.getInterfaceFunctions(), scppMod.getBlocksToPipeline(), scppMod.getInterfaceFunctions().getConstraints(f->llvmFunction()));
  STG graph = buildSTG(s, f->llvmFunction());

  // TODO: Generate these automatically, or change generation code
  // to treat LLVM i<N> as builtin?
  setAllAllocaMemTypes(scppMod.getHardwareConstraints(), f->llvmFunction(), registerSpec(32));

  cout << "STG is" << endl;
  graph.print(cout);

  map<Value*, int> layout;  
  auto arch = buildMicroArchitecture(graph, layout, scppMod.getHardwareConstraints());

  VerilogDebugInfo info;
  emitVerilog(arch, info);
}

int main() {
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
  
  cout << "Done with statement tests" << endl;

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

    assert(parseMod.getStatements().size() == 2);

    SynthCppModule scppMod(parseMod);

    assert(scppMod.getClasses().size() == 1);
    assert(scppMod.getFunctions().size() == 1);

    synthesizeVerilog(scppMod, "filter_ram");
  }

  {
    ifstream t("./experiments/eth_axi_tx.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    // cout << "Tokens" << endl;
    // for (auto t : tokens) {
    //   cout << "\t" << t.getStr() << endl;
    // }

    ParserModule mod = parse(tokens);

    cout << mod << endl;

    assert(mod.getStatements().size() == 2);
  }

  // Q: What are the new issues?
  // A: How to generate code for interface methods, whether that code generation
  //    can be done efficiently.

  // Q: Now what needs to be done?
  // A: Need to separate constraint handling from llvm code generation and add
  //    code to push constraints to the correct ExecutionConstraints data structure.
  //    Also need to build stub for read_port and write_port that generates the
  //    correct builtin
  //    Remove duplication from mkFunc
  // Meta: I am really tired on this plane, what could I do to continue to work
  // that will not take a huge mental load?

  // Problem: Need to add labels and create a mapping from labels to the statements
  // that they reference

  // Problem: Constraints do not currently get translated in to anything. The code
  // generator needs an internal mapping from label names to generated code locations

}
