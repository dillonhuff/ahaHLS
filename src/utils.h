#pragma once

#include "algorithm.h"

#include <cmath>
#include <vector>
#include <set>
#include <string>

#include <llvm/IR/Instructions.h>

namespace ahaHLS {

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
  }

  static inline
  std::string andStrings(const std::vector<std::string>& strings) {
    return separatedListString(strings, " && ");    
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

  template<typename T>
  static inline
  std::string commaListString(const std::set<T>& objs) {
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

  bool isBuiltinStallCall(llvm::Instruction* const instr);

  bool isBuiltinFifoWrite(llvm::Instruction* const instr);
  bool isBuiltinFifoRead(llvm::Instruction* const instr);

  static inline
  bool isBuiltinFifoCall(llvm::Instruction* const instr) {
    return isBuiltinFifoWrite(instr) || isBuiltinFifoRead(instr);
  }

  std::string getPortName(llvm::Instruction* const instr);

  bool isBuiltinPortWrite(llvm::Instruction* const instr);
  bool isBuiltinPortRead(llvm::Instruction* const instr);
  
  static inline
  bool isBuiltinPortCall(llvm::Instruction* const instr) {
    return isBuiltinPortWrite(instr) || isBuiltinPortRead(instr);
  }

  static inline
  std::string orStr(const std::string& left, const std::string& right) {
    return parens(left + " || " + right);
  }
  
  static inline
  std::string andStr(const std::string& left, const std::string& right) {
    return parens(left + " && " + right);
  }

  static inline
  std::string condStr(const std::string& cond, const std::string& left, const std::string& right) {
    return parens(cond + " ? " + left + " : " + right);
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

  int getTypeBitWidth(llvm::Type* const tp);

  std::string sanitizeFormatForVerilog(const std::string& str);
  
  static inline
  std::string sanitizeFormatForVerilogId(const std::string& str) {
    auto st = sanitizeFormatForVerilog(str);
    std::string res = "";
    for (auto c : st) {
      if (c == '@') {
        res += "_amp_";
      } else if (c == ',') {
        res += "_cm_";
      } else if (c == ' ') {
        res += "__";
      } else if (c == '$') {
        res += "_dlr_";
      } else if (c == '*') {
        res += "_ptr_";
      } else if (c == '=') {
        res += "_eq_";
      } else if (c == '(') {
        res += "_lp_";
      } else if (c == ')') {
        res += "_rp_";
      } else if (c == '.') {
        res += "_pr_";
      } else {
        res += c;
      }
    }
    return res;
  }

  std::string demangle(const std::string& mangled);
  bool canDemangle(const std::string& mangled);
  std::string demangledFuncName(const std::string& demangledName);
  std::string takeUntil(std::string pattern, const std::string& name);
  std::string drop(std::string pattern, const std::string& name);

  std::string ifStr(const std::string s);

  bool matchesCall(std::string str, llvm::Instruction* const iptr);

  llvm::Type* getPointedToType(llvm::Type* tp);

  llvm::Function*
  getFunctionByDemangledName(llvm::Module* mod, const std::string& name);

  llvm::Type* getTypePointedTo(llvm::Type* const tp);
  std::string implies(const std::string& a, const std::string& b);  

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
  dbhc::maybe<ResultType*> extractM(InputType* tp) {
    if (ResultType::classof(tp)) {
      return sc<ResultType>(tp);
    }

    return dbhc::maybe<ResultType*>();
  }

}
