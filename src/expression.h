#pragma once

#include "algorithm.h"

using namespace std;

namespace ahaHLS {

    enum TokenType {
    TOKEN_TYPE_ID,
    TOKEN_TYPE_NUM,
    TOKEN_TYPE_SYMBOL,
    TOKEN_TYPE_KEYWORD,  
  };


  static inline
  bool oneCharToken(const char c) {
    vector<char> chars = {'{', '}', ';', ')', '(', ',', '[', ']', ':', '-', '&', '+', '=', '>', '<', '*', '.'};
    return dbhc::elem(c, chars);
  }

  static inline
  bool isKeyword(const std::string& str) {
    vector<string> keywords{"void", "for", "return", "do", "while"};
    return dbhc::elem(str, keywords);
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

  static inline
  bool operator<(const Token l, const Token r) {
    return l.getStr() < r.getStr();
  }

  static inline
  bool isComparator(Token op) {
    vector<string> comps = {"==", ">", "<", "*", ">=", "<="};
    return dbhc::elem(op.getStr(), comps);
  }

  static inline
  std::ostream& operator<<(std::ostream& out, const Token& t) {
    out << t.getStr();
    return out;
  }

  static inline
  bool operator==(const Token& a, const Token& b) {
    return a.getStr() == b.getStr();
  }

  static inline
  bool operator!=(const Token& a, const Token& b) {
    return !(a == b);
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

  static inline
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


}
