#pragma once

#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>

#include <llvm/IR/Module.h>

namespace ahaHLS {

  int createLLFile(const std::string& moduleName);

  std::unique_ptr<llvm::Module> loadLLFile(llvm::LLVMContext& Context,
                                           llvm::SMDiagnostic& Err,
                                           const std::string& name);

  std::unique_ptr<llvm::Module> loadCppMod(llvm::LLVMContext& Context,
                                           llvm::SMDiagnostic& Err,
                                           const std::string& path);
  
  std::unique_ptr<llvm::Module> loadModule(llvm::LLVMContext& Context,
                                           llvm::SMDiagnostic& Err,
                                           const std::string& name);

  std::unique_ptr<llvm::Module> loadCppModule(llvm::LLVMContext& Context,
                                              llvm::SMDiagnostic& Err,
                                              const std::string& name);
  
  bool runCmd(const std::string& cmd);

  bool runIVerilogTB(const std::string& moduleName);

  bool runIVerilogTest(const std::string& mainName,
                       const std::string& exeName);

  bool runIVerilogTest(const std::string& mainName,
                       const std::string& exeName,
                       const std::string& otherFiles);

  template<typename T>
  class Image {
    int nRows;
    int nCols;
    std::vector<T> pixels;
  public:
    Image(const int nRows_, const int nCols_, const std::vector<T>& pixels_) : nRows(nRows_), nCols(nCols_), pixels(pixels_) {
      assert(pixels.size() == nRows*nCols);
    }

    Image(const int nRows_, const int nCols_) : nRows(nRows_), nCols(nCols_) {
      pixels.resize(nRows*nCols);
    }

    int numRows() const { return nRows; }
    int numCols() const { return nCols; }

    void set(const int r, const int c, const T val) {
      pixels[r*numCols() + c] = val;
    }

    T get(const int r, const int c) const {
      return pixels[r*numCols() + c];
    }
    
    std::vector<T> getPixels() const { return pixels; }
    
  };

  template<typename T>
  Image<T> conv(const Image<T>& kernel, const Image<T>& input) {

    Image<T> imgRes(input.numRows() - (kernel.numRows() - 1),
                    input.numCols() - (kernel.numCols() - 1));
    
    for (int i = 0; i < imgRes.numRows(); i++) {
      for (int j = 0; j < imgRes.numCols(); j++) {

        T res = 0;
        for (int ic = 0; ic < kernel.numRows(); ic++) {
          for (int jc = 0; jc < kernel.numCols(); jc++) {
            T kern = kernel.get(ic, jc); //kernel[(ic)*kernel.numCols() + jc];
            T val = input.get(i + ic, j + jc); //((i + ic)*input.numCols() + j + jc);
            res += kern*val;
          }
        }

        imgRes.set(i, j, res);
      }

      
    }

    return imgRes;
  }
  
  std::vector<int> convValues(const std::vector<int>& kernel);  
}
