#include "algorithm.h"

#include <fstream>
#include <streambuf>
#include <sstream>

using namespace dbhc;
using namespace std;

enum TokenType {
  TOKEN_TYPE_ID,
  TOKEN_TYPE_NUM,
  TOKEN_TYPE_SYMBOL  
};

class Token {
  std::string str;
  TokenType tp;
  
public:

  Token(const std::string& str_) : str(str_), tp(TOKEN_TYPE_ID) {}

  TokenType type() const { return tp; }
  
  bool isId() const { return type() == TOKEN_TYPE_ID; }

  std::string getStr() const { return str; }
};

std::ostream& operator<<(std::ostream& out, const Token& t) {
  out << t.getStr();
  return out;
}

bool operator==(const Token& a, const Token& b) {
  return a.getStr() == b.getStr();
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

bool isWhitespace(const char c) {
  return isspace(c);
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

template<typename F>
Token consumeWhile(TokenState& state, F shouldContinue) {
  string tok = "";
  while (!state.atEnd() && shouldContinue(state.peekChar())) {
    tok += state.parseChar();
  }
  return tok;
}

bool oneCharToken(const char c) {
  vector<char> chars = {'{', '}', ';', ')', '(', ',', '[', ']', ':', '-', '*', '+', '=', '>', '<'};
  return elem(c, chars);
}

bool isUnderscore(const char c) { return c == '_'; }
bool isAlphaNum(const char c) { return isalnum(c); }

Token parse_token(TokenState& state) {
  if (isalnum(state.peekChar())) {
    return consumeWhile(state, [](const char c) { return isAlphaNum(c) || isUnderscore(c); });
  } else if (oneCharToken(state.peekChar())) {
    char res = state.parseChar();
    string r;
    r += res;
    return Token(r);
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

class Statement {
public:
  
};

class ParserModule {
  std::vector<Statement*> stmts;
  
public:

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

maybe<Type*> parseType(ParseState<Token>& tokens) {
  if (tokens.peekChar().isId()) {
    if (!tokens.peekChar(1).isId()) {
      tokens.parseChar();
      return new Type();
    }
  }
  return maybe<Type*>();
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

Statement* parseStatement(ParseState<Token>& tokens) {
  if (tokens.peekChar() == Token("class")) {
    tokens.parseChar();
    Token name = tokens.parseChar();

    assert(tokens.parseChar() == Token("{"));

    vector<Statement*> classStmts =
      sepBy<Statement*>(parseStatement, parseStmtEnd, tokens);

    assert(tokens.parseChar() == Token("}"));

    return new Statement();
  }

  maybe<Type*> tp = tryParse<Type*>(parseType, tokens);
  if (tp.has_value()) {
    Token name = tokens.parseChar();
    cout << "Name = " << name << endl;
    return new Statement();
  }

  cout << "Error: Could not parse statement: " << tokens.remainder() << endl;
  assert(false);
}

ParserModule parse(const std::vector<Token>& tokens) {
  ParseState<Token> pm(tokens);
  ParserModule m;
  vector<Statement*> stmts =
    sepBy<Statement*>(parseStatement, parseStmtEnd, pm);
  
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
  
}
