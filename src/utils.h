#pragma once

#include <cmath>
#include <vector>
#include <string>

#include <llvm/IR/Instructions.h>

namespace DHLS {

  std::string typeString(llvm::Type* const tptr);
  std::string instructionString(llvm::Instruction* const iptr);
  std::string valueString(llvm::Value* const iptr);

  static inline
  std::string valueString(llvm::Value& iptr) {
    return valueString(&iptr);
  }

  static inline
  llvm::Value* getArg(llvm::Function* f, const int argNum) {
    assert(argNum < (int) f->arg_size());
    return llvm::dyn_cast<llvm::Value>(f->arg_begin() + argNum);
  }

  static inline
  std::string separatedListString(const std::vector<std::string>& strings,
                                  const std::string separator) {
    std::string res = "";
    for (int i = 0; i < (int) strings.size(); i++) {
      res += strings[i];
      if (i < (((int) strings.size()) - 1)) {
        res += separator;
      }
    }
    return res;
  }
  
  static inline
  std::string commaListString(const std::vector<std::string>& strings) {
    return separatedListString(strings, ", ");
    // std::string res = "";
    // for (int i = 0; i < (int) strings.size(); i++) {
    //   res += strings[i];
    //   if (i < (((int) strings.size()) - 1)) {
    //     res += ", ";
    //   }
    // }
    // return res;
  }

  static inline
  std::string andStrings(const std::vector<std::string>& strings) {
    return separatedListString(strings, " && ");    
    // std::string res = "";
    // for (int i = 0; i < (int) strings.size(); i++) {
    //   res += strings[i];
    //   if (i < (((int) strings.size()) - 1)) {
    //     res += " && ";
    //   }
    // }
    // return res;
  }

  template<typename T>
  static inline
  std::string commaListString(const std::vector<T>& objs) {
    std::vector<std::string> strs;
    for (auto str : objs) {
      strs.push_back(std::to_string(str));
    }
    return commaListString(strs);
  }
  
  static inline
  int clog2(const int val) {
    return ceil(log2(val));
  }

  static inline
  std::string indent(int tabs) {
    std::string ind = "";
    for (int i = 0; i < tabs; i++) {
      ind += "\t";
    }
    return ind;
  }

  static inline
  std::string tab(int nTabs) {
    std::string s = "";
    for (int i = 0; i < nTabs; i++) {
      s += '\t';
    }
    return s;
  }

  static inline
  std::string parens(const std::string& s) {
    return "(" + s + ")";
  }

  int getValueBitWidth(llvm::Value* const instr);

  static inline
  bool hasPrefix(const std::string str, const std::string prefix) {
    auto res = std::mismatch(prefix.begin(), prefix.end(), str.begin());

    if (res.first == prefix.end()) {
      // foo is a prefix of foobar.
      return true;
    }

    return false;
  }

  bool isBuiltinFifoWrite(llvm::Instruction* const instr);
  bool isBuiltinFifoRead(llvm::Instruction* const instr);

  static inline
  bool isBuiltinFifoCall(llvm::Instruction* const instr) {
    return isBuiltinFifoWrite(instr) || isBuiltinFifoRead(instr);
  }

  static inline
  std::string andStr(const std::string& left, const std::string& right) {
    return parens(left + " && " + right);
  }

  static inline
  std::string notStr(const std::string& a) {
    return "!" + parens(a);
  }

  static inline
  std::string zeroExtend(const std::string val, const int width) {
    assert(((int) val.size()) < width);
    std::string res;
    for (int i = 0; i < width - ((int) val.size()); i++) {
      res += "0";
    }
    res += val;

    assert(((int) res.size()) == width);

    return res;
  }

}
