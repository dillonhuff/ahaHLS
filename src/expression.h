#pragma once

namespace ahaHLS {

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

  

}
