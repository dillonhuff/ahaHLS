#include "algorithm.h"

// #include <cassert>
// #include <vector>
// #include <string>
// #include <iostream>

using namespace dbhc;
using namespace std;

class Token {
  std::string str;
  
public:

  Token(const std::string& str_) : str(str_) {}

  std::string getStr() { return str; }
};

class TokenState {
  std::string ts;
  int pos;
public:

  TokenState(const std::string& str) : ts(str), pos(0) {}

  char peekChar() const { return ts[pos]; }

  char parseChar() {
    char next = ts[pos];
    pos++;
    return next;
  }

  bool atEnd() const {
    return pos == ((int) ts.size());
  }
  
};

bool isWhitespace(const char c) {
  return isspace(c);
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
  vector<char> chars = {'{', '}', ';'};
  return elem(c, chars);
}

Token parse_token(TokenState& state) {
  if (isalnum(state.peekChar())) {
    return consumeWhile(state, [](const char c) { return !isWhitespace(c); });
  } else if (oneCharToken(state.peekChar())) {
    char res = state.parseChar();
    string r;
    r += res;
    return Token(r);
  } else {
    assert(false);
  }
  // string tok = "";
  
  // while (!state.atEnd() && !isWhitespace(state.peekChar())) {
  //   tok += state.parseChar();
  // }

  // cout << "tok = " << tok << endl;
  // return tok;
}

Token consumeWhitespace(TokenState& state) {
  return consumeWhile(state, isWhitespace);
}

std::vector<Token> tokenize(const std::string& classCode) {
  TokenState state(classCode);
  vector<Token> tokens;
  
  while (!state.atEnd()) {
    cout << "Next char = " << state.peekChar() << endl;
    consumeWhitespace(state);

    if (state.atEnd()) {
      break;
    }

    Token t = parse_token(state);
    cout << "Next char after token = " << state.peekChar() << endl;    
    tokens.push_back(t);
  }

  return tokens;
}

int main() {
  string test = "class ip_header { };";
  vector<Token> tokens = tokenize(test);

  cout << "# of tokens " << tokens.size() << endl;

  assert(tokens.size() == 5);
}
