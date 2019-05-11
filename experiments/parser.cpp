#include <iostream>
#include <vector>
#include <cassert>

using namespace std;

int main() {
  cout << "Done with statement tests" << endl;

  class Img {
    vector<int> values;
    int nRows, nCols;

  public:

    Img(const int nRows_, const int nCols_) : nRows(nRows_), nCols(nCols_) {
      values.resize(nRows*nCols);
    }

    int get(const int i, const int j) {
      assert(i < nRows);
      assert(j < nCols);
      
      return values[i*nCols + j];
    }

    void set(const int i, const int j, const int val) {
      values[i*nCols + j] = val;
    }

  };

  // {
  //   ifstream t("./experiments/median_filter.cpp");
  //   std::string str((std::istreambuf_iterator<char>(t)),
  //                   std::istreambuf_iterator<char>());

  //   auto tokens = tokenize(str);
  //   ParserModule mod = parse(tokens);
    
  //   SynthCppModule scppMod(mod);

  //   auto arch = synthesizeVerilog(scppMod, "run_median_func");

  //   {
  //     int imgWidth = 5;
  //     Img image(imgWidth, imgWidth);
  //     for (int i = 0; i < imgWidth; i++) {
  //       for (int j = 0; j < imgWidth; j++) {
  //         image.set(i, j, i*imgWidth + j);
  //       }
  //     }

  //     auto word0 =
  //       sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 1));
  //     auto word1 =
  //       sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 2));
  //     auto word2 =
  //       sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 3));

  //     TestBenchSpec tb;
  //     map<string, int> testLayout = {};
  //     tb.memoryInit = {};
  //     tb.memoryExpected = {};
  //     tb.runCycles = 30;
  //     tb.maxCycles = 50;
  //     tb.name = "run_median_func";
  //     tb.useModSpecs = true;

  //     map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
  //     map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
  //     map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
    
  //     tb.actionOnCondition("1", "$display(\"pixel1 = %d, pixel2 = %d, pixel3 = %d, pixel4 = %d\", arg_4_in_wire, arg_5_in_wire, arg_6_in_wire, arg_7_in_wire);");

  //     int loadWidth = 4;
  //     int startLoadCycle = 3;
  //     int stencilWidth = 3;

  //     int activeCycle = startLoadCycle;
  //     vector<Argument*> rows{word0, word1, word2};

  //     //for (int i = 0; i < imgWidth - (stencilWidth - 1); i++) {
  //     for (int i = 0; i < imgWidth - 1; i++) {

  //       // Clear row
  //       for (int k = 0; k < 3; k++) {
  //         setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
  //         activeCycle++;
  //       }
        
  //       for (int j = 0; j < imgWidth - (loadWidth - 1); j += loadWidth) {
  //       //for (int j = 0; j < imgWidth; j += loadWidth) {
  //         // Assemble values;
  //         for (int row = 0; row < stencilWidth; row++) {
  //           auto word = rows[row];
  //           string values = "";
  //           for (int col = 0; col < loadWidth; col++) {
  //             if ((i + row) < imgWidth) {
  //               values += "8'd" + to_string(image.get(i + row, j + col));
  //             } else {
  //               values += "8'hff";
  //             }

  //             if (col != (loadWidth - 1)) {
  //               values += ",";
  //             }
  //           }
  //           tb.setArgPort(word, "in_wire", activeCycle,
  //                         //startLoadCycle + i + (j / loadWidth),
  //                         "{" + values + "}");
  //         }
  //         activeCycle++;            
          

  //       }

  //       // setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
  //       // activeCycle++;
  //     }

  //     // for (int k = 0; k < 3; k++) {
  //     //   setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
  //     //   activeCycle++;
  //     // }
      
  //     tb.settablePort(word0, "in_wire");
  //     tb.settablePort(word1, "in_wire");
  //     tb.settablePort(word2, "in_wire");    

  //     //map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
  //     emitVerilogTestBench(tb, arch, testLayout);
  //     assert(runIVerilogTest("run_median_func_tb.v", "run_median_func", " builtins.v run_median_func.v RAM.v delay.v ram_primitives.v eth_axis_tx.v median_wires.v median.v state_machine.v node.v common_network.v dff_3_pipe.v pixel_network.v"));
  //   }
  // }
  
}
