#pragma once

#include <cmath>
#include <vector>
#include <string>

#include <llvm/IR/Instructions.h>

namespace DHLS {

  static inline
  llvm::Value* getArg(llvm::Function* f, const int argNum) {
    assert(argNum < (int) f->arg_size());
    return llvm::dyn_cast<llvm::Value>(f->arg_begin() + argNum);
  }

  static inline
  std::string commaListString(const std::vector<std::string>& strings) {
    std::string res = "";
    for (int i = 0; i < (int) strings.size(); i++) {
      res += strings[i];
      if (i < (((int) strings.size()) - 1)) {
        res += ", ";
      }
    }
    return res;
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
}
