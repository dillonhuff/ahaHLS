#include "algorithm.h"

#include <fstream>
#include <streambuf>
#include <sstream>
#include <functional>

#include "llvm_codegen.h"
#include "verilog_backend.h"

using namespace dbhc;
using namespace DHLS;
using namespace std;

enum TokenType {
  TOKEN_TYPE_ID,
  TOKEN_TYPE_NUM,
  TOKEN_TYPE_SYMBOL,
  TOKEN_TYPE_KEYWORD,  
};


bool oneCharToken(const char c) {
  vector<char> chars = {'{', '}', ';', ')', '(', ',', '[', ']', ':', '-', '*', '+', '=', '>', '<'};
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
  vector<string> binopStrings{"=", "==", "+", "*", "-", "/", "^", "%", "&&", "||", "<=", ">=", "<", ">"};
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

class SynthCppType {
};

class Expression {
  
};

class FunctionCall : public Expression {
public:
  Token funcName;
  std::vector<Expression*> args;

  FunctionCall(const Token funcName_,
               const std::vector<Expression*>& args_) :
    funcName(funcName_), args(args_) {}

};

class MethodCall : public Expression {

public:
  
  Token callerName;
  FunctionCall* called;

  MethodCall(const Token callerName_,
             FunctionCall* called_) :
    callerName(callerName_), called(called_) {}

};

class Identifier : public Expression {
public:

  Token name;
  
  Identifier(const Token name_) : name(name_) {}
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
};

class VoidType : public SynthCppType {
};

class BinopExpr : public Expression {
public:
  Expression* lhs;
  Token op;
  Expression* rhs;
  
  BinopExpr(Expression* lhs_, Token op_, Expression* rhs_) :
    lhs(lhs_), op(op_), rhs(rhs_) {}
};

class IntegerExpr : public Expression {
  std::string digits;
  
public:
  IntegerExpr(const std::string& digits_) : digits(digits_) {}
};

enum StatementKind {
  STATEMENT_KIND_CLASS_DECL,
  STATEMENT_KIND_FUNCTION_DECL,
  STATEMENT_KIND_ASSIGN,
  STATEMENT_KIND_FOR
};

class Statement {
public:
  Token label;

  void setLabel(const Token l) {
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
  
};

class ExpressionStmt : public Statement {
public:
  Expression* expr;

  ExpressionStmt(Expression* expr_) : expr(expr_) {}
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

  Token paren = tokens.parseChar();
  if ((paren != Token("->")) &&
      (paren != Token("."))) {
    return maybe<Expression*>();
  }

  cout << "-- In method call, parsing function call " << tokens.remainder() << endl;
  maybe<FunctionCall*> fCall = parseFunctionCall(tokens);
  if (fCall.has_value()) {
    return new MethodCall(paren, fCall.get_value());
  }

  return maybe<Expression*>();
}

Expression* parseExpression(ParseState<Token>& tokens);
maybe<Expression*> parseExpressionMaybe(ParseState<Token>& tokens);

maybe<Expression*> parsePrimitiveExpressionMaybe(ParseState<Token>& tokens) {
  //cout << "-- Parsing primitive expression " << tokens.remainder() << endl;

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
  //cout << "-- Parsing expression " << tokens.remainder() << endl;
  
  auto pExpr = parsePrimitiveExpressionMaybe(tokens);
  if (!pExpr.has_value()) {
    return pExpr;
  }

  if (tokens.atEnd() || !isBinop(tokens.peekChar())) {
    return pExpr;
  }

  Token binop = tokens.parseChar();
  auto rest = parseExpressionMaybe(tokens);

  return new BinopExpr(pExpr.get_value(), binop, rest.get_value());
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
  if (!tokens.atEnd() && (tokens.peekChar() == Token("*"))) {
    tokens.parseChar();
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

  //cout << "Remaining after expr is " << tokens.remainder() << endl;
  // Token delim = tokens.parseChar();
  // assert((delim == Token(";")) || (delim == Token("")));

  return new AssignStmt(id, r.get_value());
  //return new Statement();
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
    //return new Statement();
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
  //cout << "Statement after label " << tokens.remainder() << endl;
  
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


class SynthCppFunction {
public:
  Token nameToken;
  llvm::Function* func;
  llvm::Function* llvmFunction() { return func; }

  std::string getName() const {
    return nameToken.getStr();
  }
};

class SynthCppClass {
};

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

  
  SynthCppModule(ParserModule& parseRes) {
    hcs = standardConstraints();
    mod = llvm::make_unique<Module>("synth_cpp", context);
    setGlobalLLVMContext(&context);
    setGlobalLLVMModule(mod.get());

    // Also need: storage for clases and functions,
    // storage for module specifications and hardware
    // constraints.

    for (auto stmt : parseRes.getStatements()) {
      // Note: Part of the virtue of <classname>::classof(obj) instead of obj->type() == CLASS_ENUM
      // is that it does not force the user to remember names of enums! Name reduction strikes again

      // TODO: Actually add parsing
      if (ClassDecl::classof(stmt)) {
        classes.push_back(new SynthCppClass());
      } else if (FunctionDecl::classof(stmt)) {
        auto fd = static_cast<FunctionDecl*>(stmt);
        vector<Type*> inputTypes;

        auto sf = new SynthCppFunction();
        sf->nameToken = fd->name;
        llvm::Function* f = mkFunc(inputTypes, voidType(), sf->getName());
        auto bb = mkBB("entry_block", f);
        IRBuilder<> b(bb);
        b.CreateRet(nullptr);
        
        sf->func = f;

        functions.push_back(sf);
      }
    }
  }

  SynthCppFunction* getFunction(const std::string& name) {
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
  Schedule s = scheduleInterface(f->llvmFunction(), scppMod.getHardwareConstraints(), scppMod.getInterfaceFunctions(), scppMod.getBlocksToPipeline());
  STG graph = buildSTG(s, f->llvmFunction());

  cout << "STG is" << endl;
  graph.print(cout);
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
    std::string str = "void write_packet(bit_5 addr, fifo* payload) {}";
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

    delete tp.get_value();
  }
  
  {
    std::string str = "start(set_wen)";
    ParseState<Token> st(tokenize(str));
    auto tp = parseFunctionCall(st);
    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "start(set_wen) == start(set_wdata)";
    ParseState<Token> st(tokenize(str));
    auto tp = parseExpressionMaybe(st);
    assert(tp.has_value());

    assert(st.atEnd());

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

}
