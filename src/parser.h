#pragma once

#include "algorithm.h"

#include <fstream>
#include <streambuf>
#include <sstream>

using namespace dbhc;
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


