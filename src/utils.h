#pragma once

#include <cmath>
#include <vector>
#include <string>

namespace DHLS {

  static inline
  std::string commaListString(const std::vector<std::string>& strings) {
    std::string res = "";
    for (int i = 0; i < (int) strings.size(); i++) {
      res += strings[i];
      if (i < strings.size() - 1) {
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


}
