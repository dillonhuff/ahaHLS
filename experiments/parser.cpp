#include "algorithm.h"

#include <fstream>
#include <streambuf>
#include <sstream>
#include <functional>

using namespace dbhc;
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
  vector<string> keywords{"void"};
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

  T peekChar(const int offset) const { return ts[pos + offset]; }  
  T peekChar() const { return peekChar(0); }

  T parseChar() {
    T next = ts[pos];
    pos++;
    return next;
  }

  bool atEnd() const {
    return pos == ((int) ts.size());
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
  vector<string> binopStrings{"=", "==", "+", "*", "-", "/", "^", "%", "&&", "||", "<=", ">="};
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
  maybe<OutType> val = p(tokens);
  if (val.has_value()) {
    return val;
  }

  tokens.setPos(lastPos);

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

class Type {
};

class Expression {
  
};

class Identifier : public Expression {
public:
  
};

class TemplateType : public Type {
public:
  std::vector<Expression*> exprs;

  TemplateType(const std::vector<Expression*>& exprs_) : exprs(exprs_) {}

  ~TemplateType() {
    for (auto e : exprs) {
      delete e;
    }
  }
};

class StructType : public Type {
};

class VoidType : public Type {
};

class IntegerExpr : public Expression {
  std::string digits;
  
public:
  IntegerExpr(const std::string& digits_) : digits(digits_) {}
};

class Statement {
public:
  
};

maybe<Statement*> parseStatement(ParseState<Token>& tokens);

class ArgumentDecl {
public:
  
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
  cout << "Statement end token == " << tokens.peekChar() << endl;
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
    return new Identifier();
  }

  return maybe<Identifier*>();
}

maybe<Expression*> parseFunctionCall(ParseState<Token>& tokens);

maybe<Expression*> parsePrimitiveExpressionMaybe(ParseState<Token>& tokens) {
  cout << "-- Parsing primitive expression " << tokens.remainder() << endl;

  auto fCall = tryParse<Expression*>(parseFunctionCall, tokens);
  if (fCall.has_value()) {
    return fCall;
  }

  // Try parsing a function call
  // If that does not work try to parse an identifier
  // If that does not work try parsing a parenthesis
  auto id = tryParse<Identifier*>(parseId, tokens);
  if (id.has_value()) {
    return id.get_value();
  }

  cout << "Expressions = " << tokens.remainder() << endl;
  assert(tokens.peekChar().isNum());
  return new IntegerExpr(tokens.parseChar().getStr());
}

Expression* parseExpression(ParseState<Token>& tokens);

maybe<Expression*> parseFunctionCall(ParseState<Token>& tokens) {
  Token t = tokens.parseChar();
  if (!t.isId()) {
    return maybe<Expression*>();
  }

  Token paren = tokens.parseChar();
  if (paren != Token("(")) {
    return maybe<Expression*>();
  }

  cout << "parsing funcall " << tokens.remainder() << endl;
  vector<Expression*> callArgs =
    sepBtwn<Expression*, Token>(parseExpression, parseComma, tokens);

  paren = tokens.parseChar();
  if (paren != Token(")")) {
    return maybe<Expression*>();
  }

  return new Expression();
}

maybe<Expression*> parseExpressionMaybe(ParseState<Token>& tokens) {
  cout << "-- Parsing expression " << tokens.remainder() << endl;
  
  auto pExpr = parsePrimitiveExpressionMaybe(tokens);
  if (!pExpr.has_value()) {
    return pExpr;
  }

  if (!isBinop(tokens.peekChar())) {
    return pExpr;
  }

  Token binop = tokens.parseChar();
  auto rest = parseExpressionMaybe(tokens);

  return rest;
}

Expression* parseExpression(ParseState<Token>& tokens) {
  auto res = parseExpressionMaybe(tokens);
  if (res.has_value()) {
    return res.get_value();
  }

  assert(false);
}

maybe<Type*> parseType(ParseState<Token>& tokens) {
  if (tokens.peekChar().isId()) {
    
    cout << tokens.peekChar() << " is id" << endl;    

    Token tpName = tokens.parseChar();

    cout << tokens.peekChar() << " is id ? " << tokens.peekChar().isId() << endl;
    if (tokens.peekChar().isId()) {
      tokens.parseChar();
      return new StructType();
    }

    if (tokens.peekChar() == Token("<")) {
      tokens.parseChar();
      vector<Expression*> exprs =
        sepBtwn<Expression*, Token>(parseExpression, parseComma, tokens);

      cout << "remainder after getting expressions = " << tokens.remainder() << endl;
      assert(tokens.peekChar() == Token(">"));
      tokens.parseChar();

      return new TemplateType(exprs);
    }
  }

  if (tokens.peekChar() == Token("void")) {
    tokens.parseChar();
    return new VoidType();
  }

  return maybe<Type*>();
}

maybe<ArgumentDecl*> parseArgDeclMaybe(ParseState<Token>& tokens) {
  cout << "Parsing arg declaration = " << tokens.remainder() << endl;
  maybe<Type*> tp = parseType(tokens);

  if (!tp.has_value()) {
    return maybe<ArgumentDecl*>();
  }
  //assert(tp.has_value());

  Token argName = tokens.parseChar();

  if (!argName.isId()) {
    return maybe<ArgumentDecl*>();
  }
  //assert(argName.isId());

  return new ArgumentDecl();
}

ArgumentDecl* parseArgDecl(ParseState<Token>& tokens) {
  cout << "Parsing arg declaration = " << tokens.remainder() << endl;
  maybe<Type*> tp = parseType(tokens);
  assert(tp.has_value());
  Token argName = tokens.parseChar();

  assert(argName.isId());

  return new ArgumentDecl();
}

maybe<Statement*> parseFuncDecl(ParseState<Token>& tokens) {
  maybe<Type*> tp = tryParse<Type*>(parseType, tokens);
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
    
    return new Statement();
  }

  return maybe<Statement*>();

}

maybe<Token> parseLabel(ParseState<Token>& tokens) {
  Token t = tokens.parseChar();
  if (!t.isId()) {
    return maybe<Token>();
  }

  Token semi = tokens.parseChar();
  if (semi != Token(":")) {
    return maybe<Token>();
  }

  return t;
}

maybe<Statement*> parseFunctionCallStmt(ParseState<Token>& tokens) {
  maybe<Expression*> p = parseFunctionCall(tokens);
  if (!p.has_value()) {
    return maybe<Statement*>();
  }

  Token semi = tokens.parseChar();
  if (semi != Token(";")) {
    return maybe<Statement*>();
  }

  return new Statement();
}

maybe<Statement*> parseStatement(ParseState<Token>& tokens) {

  // Try to parse a label?
  auto label = tryParse<Token>(parseLabel, tokens);

  cout << "Parsing statement " << tokens.remainder() << endl;
  if (tokens.peekChar() == Token("class")) {
    tokens.parseChar();
    Token name = tokens.parseChar();

    assert(tokens.parseChar() == Token("{"));

    vector<Statement*> classStmts =
      many<Statement*>(parseStatement, tokens);

    assert(tokens.parseChar() == Token("}"));
    assert(tokens.parseChar() == Token(";"));
    
    return new Statement();
  }

  maybe<Statement*> funcDecl =
    tryParse<Statement*>(parseFuncDecl, tokens);

  if (funcDecl.has_value()) {
    return funcDecl;
  }

  // Should do: tryParse function declaration
  // Then: tryParse member declaration
  auto decl = tryParse<ArgumentDecl*>(parseArgDeclMaybe, tokens);
  if (decl.has_value()) {
    if (tokens.peekChar() == Token(";")) {
      tokens.parseChar();
      return new Statement();
    }
  }

  // Try to parse function declaration
  auto call = tryParse<Statement*>(parseFunctionCallStmt, tokens);

  if (call.has_value()) {
    return call;
  }

  cout << "Cannot parse statement " << tokens.remainder() << endl;

  return maybe<Statement*>();
}

ParserModule parse(const std::vector<Token>& tokens) {
  ParseState<Token> pm(tokens);
  vector<Statement*> stmts =
    many<Statement*>(parseStatement, pm);

  ParserModule m(stmts);
  
  return m;
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
    std::string str = "input<23>";
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
    std::string str = "void write(bit<5> addr, bit<32> data) {}";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    assert(tp.has_value());

    assert(st.atEnd());

    delete tp.get_value();
  }

  {
    std::string str = "input<23> wdata;";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);
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

    ParserModule mod = parse(tokens);

    cout << mod << endl;

    assert(mod.getStatements().size() == 1);
  }

  // {
  //   ifstream t("./experiments/eth_axi_tx.cpp");
  //   std::string str((std::istreambuf_iterator<char>(t)),
  //                   std::istreambuf_iterator<char>());

  //   auto tokens = tokenize(str);
  //   cout << "Tokens" << endl;
  //   for (auto t : tokens) {
  //     cout << "\t" << t.getStr() << endl;
  //   }

  //   ParserModule mod = parse(tokens);

  //   cout << mod << endl;

  //   assert(mod.getStatements().size() == 1);
  // }
  
}
