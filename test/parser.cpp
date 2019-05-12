#include "catch.hpp"

#include "parser.h"

#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Scalar.h"
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>

//#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/LoopInfo.h>
//#include <llvm/Analysis/LoopAccessAnalysis.h>
//#include <llvm/Analysis/ScalarEvolution.h>

#include "test_utils.h"

#include <cassert>

namespace ahaHLS {

  TEST_CASE("Parser tests") {
    {
      string test = "class ip_header { };";
      vector<Token> tokens = tokenize(test);

      cout << "# of tokens " << tokens.size() << endl;

      REQUIRE(tokens.size() == 5);
    }

    {
      string test = "void write(bit32 data, bit5 addr) { set_port(wen, 1); set_port(wdata, data); set_port(waddr, addr); }";

      vector<Token> tokens = tokenize(test);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      REQUIRE(tokens[2].getStr() == "(");
      REQUIRE(tokens.back().getStr() == "}");    
    }

    {
      string test = "bits[5 : 0]";

      vector<Token> tokens = tokenize(test);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      REQUIRE(tokens.size() == 6);
      REQUIRE(tokens[0].getStr() == "bits");
      REQUIRE(tokens[3].getStr() == ":");
    }

    {
      string test = "x == 8";

      vector<Token> tokens = tokenize(test);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      REQUIRE(tokens.size() == 3);
      REQUIRE(tokens[1].getStr() == "==");
    }

    {
      string test = "x = 8 == 7";

      vector<Token> tokens = tokenize(test);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      REQUIRE(tokens.size() == 5);
      REQUIRE(tokens[1].getStr() == "=");
      REQUIRE(tokens[3].getStr() == "==");
    }
  
    {
      string test = "(8 - x) * 4 + 7";

      vector<Token> tokens = tokenize(test);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      REQUIRE(tokens.size() == 9);
      REQUIRE(tokens[1].getStr() == "8");
      REQUIRE(tokens[5].getStr() == "*");
    }

    {
      std::string str = "input_23";
      ParseState<Token> st(tokenize(str));
      auto tp = parseType(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "void";
      ParseState<Token> st(tokenize(str));
      auto tp = parseType(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();

      cout << "Passed parse void" << endl;
    }
  
    {
      std::string str = "void write(bit_5 addr, bit_32 data) {}";
      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);

      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "void write_packet(bit_5 addr, fifo& payload) {}";
      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);

      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    // {
    //   std::string str = "return readValue;";
    //   cout << "TEST CASE: " << str << endl;
    
    //   ParseState<Token> st(tokenize(str));
    //   auto tp = parseStatement(st);
    //   REQUIRE(tp.has_value());

    //   cout << "Statement = " << *(tp.get_value()) << endl;
    //   cout << "Remainder = " << st.remainder() << endl;
    //   REQUIRE(st.atEnd());

    //   auto rStmt = extractM<ReturnStmt>(tp.get_value());

    //   REQUIRE(rStmt.has_value());

    //   delete tp.get_value();
    // }
  
    {
      std::string str = "input_23 wdata;";
      cout << "TEST CASE: " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "input wdata[23]";
      ParseState<Token> st(tokenize(str));
      auto tp = parseArgDeclMaybe(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "// Hello this is a comment\ninput wdata[23]";
      //std::string str = "input wdata[23]";    
      ParseState<Token> st(tokenize(str));
      auto tp = parseArgDeclMaybe(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }
  
    {
      std::string str = "set_wdata: set_port(wen, 1);";
      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "read()";
      cout << "TEST CASE " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseExpressionMaybe(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      cout << "done with read" << endl;
    
      delete tp.get_value();
    }
  
    {
      std::string str = "start(set_wen)";
      cout << "TEST CASE " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseFunctionCall(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      cout << "done with " << str << endl;
      delete tp.get_value();
    }

    {
      std::string str = "start(set_wen) == start(set_wdata)";

      cout << "TEST CASE " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseExpressionMaybe(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      cout << "done with " << str << endl;

      delete tp.get_value();
    }
  
    {
      std::string str = "add_constraint(start(set_wen) == start(set_wdata));";
      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {

      std::string str = "start(set_wdata) + 3 == end(set_waddr)";
      cout << "TEST CASE " << str << endl;
      ParseState<Token> st(tokenize(str));
      auto tp = parseExpressionMaybe(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      auto be = extractM<BinopExpr>(tp.get_value());
      REQUIRE(be.has_value());
      cout << "be op = " << be.get_value()->op << endl;
    
      REQUIRE(be.get_value()->op == Token("=="));

      cout << "done with " << str << endl;
    
      delete tp.get_value();
    }

    {
      std::string str = "class ram {};";
      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "read_ready: is_ready = read_port(s_eth_hdr_ready);";

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }
  
    {
      std::string str = "transmitter->write_header(dest_mac, src_mac, type)";
      cout << "TEST CASE " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseExpressionMaybe(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "transmitter->write_byte(payload->read(), is_last)";
      cout << "TEST CASE " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseExpressionMaybe(st);
      REQUIRE(tp.has_value());

      cout << "Remaining state = " << st.remainder() << endl;
      REQUIRE(st.atEnd());

      delete tp.get_value();
    }


    {
      std::string str = "(i < 320*320)";
      cout << "TEST CASE " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseExpressionMaybe(st);
      REQUIRE(tp.has_value());

      cout << "Remaining state = " << st.remainder() << endl;
      REQUIRE(st.atEnd());

      delete tp.get_value();
    }
  
    {
      std::string str = "transmitter->write_header(dest_mac, src_mac, type);";

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {

      std::string str = "i = i + 1";
      cout << "TEST CASE << " << str << endl;
    
      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "for (i = 0; i < payload_size; i = i + 1) {}";

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }
  
    {
      std::string str = "for (i = 0; i < payload_size; i = i + 1) {"
        "bit_1 is_last;"
        "transmitter->write_byte(payload->read(), is_last);}";

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "for (i = 0; i < payload_size; i = i + 1) {"
        "is_last = i == (payload_size - 1);"
        "}";

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {

      std::string str = "do { i = i + 1; } while (i);";

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str = "do { i = i + 1; } while (i < 320*320);";

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }

    {
      std::string str =
        "in_word0.write_wire_32(read_port(word0));";

      cout << "TEST CASE: " << str << endl;

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      cout << "Result statement = " << *(tp.get_value()) << endl;
      REQUIRE(st.atEnd());

      delete tp.get_value();
    }
  
    {
      std::string str =
        "do {"
        "in_word0.write_wire_32(read_port(word0));"
        "i = i + 1;"
        "} while (i < 320*320);";

      cout << "TEST CASE: " << str << endl;

      ParseState<Token> st(tokenize(str));
      auto tp = parseStatement(st);
      REQUIRE(tp.has_value());

      REQUIRE(st.atEnd());

      delete tp.get_value();
    }
  
  }

  TEST_CASE("Code generation tests") {

    {
      ifstream t("./experiments/axi_iclass.cpp");
      std::string str((std::istreambuf_iterator<char>(t)),
                      std::istreambuf_iterator<char>());

      auto tokens = tokenize(str);
      ParserModule parseMod = parse(tokens);

      cout << parseMod << endl;

      {
        SynthCppModule scppMod(parseMod);
        auto arch = synthesizeVerilog(scppMod, "axi_read_burst_func");

        map<llvm::Value*, int> layout = {};
        TestBenchSpec tb;
        auto result =
          sc<Argument>(getArg(scppMod.getFunction("axi_read_burst_func")->llvmFunction(),
                              0));
        map<string, int> testLayout = {};
        tb.runCycles = 30;
        tb.maxCycles = 60; // No
        tb.name = "axi_read_burst_func";
        tb.useModSpecs = true;
        tb.settablePort(result, "read_valid");

        tb.setArgPort(result, "read_valid", 0, "0");
        map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
        map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));        
        map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

        tb.setArgPort(result, "read_valid", 20, "1");
        tb.setArgPort(result, "read_valid", 21, "0");

        map_insert(tb.actionsOnCycles, 21, assertString("arg_0_out_data === (34)"));

        emitVerilogTestBench(tb, arch, testLayout);

        REQUIRE(runIVerilogTest("axi_read_burst_func_tb.v", "axi_read_burst_func", " builtins.v axi_read_burst_func.v RAM.v delay.v ram_primitives.v axi_ram.v"));
      }
      //}
      {
        SynthCppModule scppMod(parseMod);
        auto arch = synthesizeVerilog(scppMod, "axi_burst_multi");

        map<llvm::Value*, int> layout = {};
        TestBenchSpec tb;
        auto result =
          sc<Argument>(getArg(scppMod.getFunction("axi_burst_multi")->llvmFunction(),
                              0));
        map<string, int> testLayout = {};
        tb.runCycles = 50;
        tb.maxCycles = 60; // No
        tb.name = "axi_burst_multi";
        tb.useModSpecs = true;
        tb.settablePort(result, "read_valid");

        tb.setArgPort(result, "read_valid", 0, "0");
        map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
        map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));        
        map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

        int checkStart = 40;
        tb.setArgPort(result, "read_valid", checkStart, "1");
        tb.setArgPort(result, "read_valid", checkStart + 1, "1");
        tb.setArgPort(result, "read_valid", checkStart + 2, "1");
        tb.setArgPort(result, "read_valid", checkStart + 3, "1");
        tb.setArgPort(result, "read_valid", checkStart + 4, "0");      

        map_insert(tb.actionsOnCycles, checkStart + 1, assertString("arg_0_out_data === (1)"));
        map_insert(tb.actionsOnCycles, checkStart + 2, assertString("arg_0_out_data === (2)"));
        map_insert(tb.actionsOnCycles, checkStart + 3, assertString("arg_0_out_data === (3)"));
        map_insert(tb.actionsOnCycles, checkStart + 4, assertString("arg_0_out_data === (4)")); 

        emitVerilogTestBench(tb, arch, testLayout);

        REQUIRE(runIVerilogTest("axi_burst_multi_tb.v", "axi_burst_multi", " builtins.v axi_burst_multi.v RAM.v delay.v ram_primitives.v axi_ram.v"));
      }

      {
        SynthCppModule scppMod(parseMod);
        auto arch = synthesizeVerilog(scppMod, "axi_write_burst");

        map<llvm::Value*, int> layout = {};
        TestBenchSpec tb;
        auto result =
          sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                              0));
        auto input =
          sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                              1));
        auto size =
          sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                              2));
        auto startLoc =
          sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                              3));
      
        map<string, int> testLayout = {};
        tb.runCycles = 100;
        tb.maxCycles = 150; // No
        tb.name = "axi_write_burst";
        tb.useModSpecs = true;
        tb.settablePort(input, "write_valid");
        tb.settablePort(input, "in_data");            
        tb.settablePort(result, "read_valid");

        tb.settablePort(size, "wen");
        tb.settablePort(size, "wdata");            

        tb.settablePort(startLoc, "wen");
        tb.settablePort(startLoc, "wdata");            

        tb.setArgPort(size, "wen", 4, "1");
        tb.setArgPort(size, "wdata", 4, "4");
        tb.setArgPort(size, "wen", 5, "0");      

        tb.setArgPort(startLoc, "wen", 4, "1");
        tb.setArgPort(startLoc, "wdata", 4, "10");      
        tb.setArgPort(startLoc, "wen", 5, "0");
      
        tb.setArgPort(result, "read_valid", 0, "0");
        map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
        map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
        map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

        map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

        int setStartCycle = 5;
        int burstSize = 5;
        for (int i = 0; i < burstSize; i++) {
          tb.setArgPort(input, "write_valid", setStartCycle + i, "1");
          tb.setArgPort(input, "in_data", setStartCycle + i, to_string(i + 1));
        }
        tb.setArgPort(input, "write_valid", setStartCycle + burstSize, "0");
      
        int checkStart = 90;
        tb.setArgPort(result, "read_valid", checkStart, "1");
        tb.setArgPort(result, "read_valid", checkStart + 1, "1");
        tb.setArgPort(result, "read_valid", checkStart + 2, "1");
        tb.setArgPort(result, "read_valid", checkStart + 3, "1");
        tb.setArgPort(result, "read_valid", checkStart + 4, "0");      

        map_insert(tb.actionsOnCycles, checkStart + 1, assertString("arg_0_out_data === (1)"));
        map_insert(tb.actionsOnCycles, checkStart + 2, assertString("arg_0_out_data === (2)"));
        map_insert(tb.actionsOnCycles, checkStart + 3, assertString("arg_0_out_data === (3)"));
        map_insert(tb.actionsOnCycles, checkStart + 4, assertString("arg_0_out_data === (4)")); 

        emitVerilogTestBench(tb, arch, testLayout);

        //REQUIRE(runIVerilogTest("axi_write_burst_tb.v", "axi_write_burst", " builtins.v axi_write_burst.v RAM.v delay.v ram_primitives.v axi_ram.v"));
      }

      {
        SynthCppModule scppMod(parseMod);
        auto arch = synthesizeVerilog(scppMod, "axi_wb");
      }    

      {
        SynthCppModule scppMod(parseMod);
        auto arch = synthesizeVerilog(scppMod, "axi_rb");
      }    

    }
      
    {
      ifstream t("./experiments/register_iclass.cpp");
      std::string str((std::istreambuf_iterator<char>(t)),
                      std::istreambuf_iterator<char>());

      auto tokens = tokenize(str);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      ParserModule parseMod = parse(tokens);

      cout << parseMod << endl;

      SynthCppModule scppMod(parseMod);

      cout << "Before synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
      for (auto func : scppMod.getInterfaceFunctions().constraints) {
        cout << tab(1) << "# of constraints on " <<
          string(func.first->getName()) << " = " <<
          func.second.constraints.size() << endl;
      }

      {
        auto arch = synthesizeVerilog(scppMod, "store_to_reg");

        map<llvm::Value*, int> layout = {};

        TestBenchSpec tb;
        map<string, int> testLayout = {};
        tb.memoryInit = {};
        tb.memoryExpected = {};
        tb.runCycles = 30;
        tb.maxCycles = 100;
        tb.name = "store_to_reg";
        tb.useModSpecs = true;
        map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
        map_insert(tb.actionsOnCycles, 19, assertString("arg_0_out === (15)"));
    
        emitVerilogTestBench(tb, arch, testLayout);

        REQUIRE(runIVerilogTest("store_to_reg_tb.v", "store_to_reg", " builtins.v store_to_reg.v RAM.v delay.v ram_primitives.v"));
      }

      {
        auto arch = synthesizeVerilog(scppMod, "instantiate_reg");
      }

    }
  
    {
      ifstream t("./experiments/ram_iclass.cpp");
      std::string str((std::istreambuf_iterator<char>(t)),
                      std::istreambuf_iterator<char>());

      auto tokens = tokenize(str);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      ParserModule parseMod = parse(tokens);

      cout << parseMod << endl;

      REQUIRE(parseMod.getStatements().size() >= 2);

      SynthCppModule scppMod(parseMod);

      REQUIRE(scppMod.getClasses().size() >= 1);
      REQUIRE(scppMod.getFunctions().size() >= 1);

      cout << "Before synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
      for (auto func : scppMod.getInterfaceFunctions().constraints) {
        cout << tab(1) << "# of constraints on " <<
          string(func.first->getName()) << " = " <<
          func.second.constraints.size() << endl;
      }
    
      auto arch = synthesizeVerilog(scppMod, "filter_ram");

      map<llvm::Value*, int> layout = {};

      auto in =
        sc<Argument>(getArg(scppMod.getFunction("filter_ram")->llvmFunction(), 0));
      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 70;
      tb.maxCycles = 100;
      tb.name = "filter_ram";
      tb.useModSpecs = true;
      tb.settablePort(in, "debug_addr");
      tb.settablePort(in, "debug_write_addr");
      tb.settablePort(in, "debug_write_data");
      tb.settablePort(in, "debug_write_en");            

      tb.setArgPort(in, "debug_write_addr", 1, "0");
      tb.setArgPort(in, "debug_write_data", 1, "6");
      tb.setArgPort(in, "debug_write_en", 1, "1");    

      tb.setArgPort(in, "debug_write_addr", 2, "1");
      tb.setArgPort(in, "debug_write_data", 2, "8");
      tb.setArgPort(in, "debug_write_en", 2, "1");    

      tb.setArgPort(in, "debug_write_en", 3, "0");
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
      tb.setArgPort(in, "debug_addr", 76, "10");
      map_insert(tb.actionsOnCycles, 76, assertString("arg_0_debug_data === (8 + 6)"));
    
      emitVerilogTestBench(tb, arch, testLayout);

      // Need to figure out how to inline register specifications
      REQUIRE(runIVerilogTest("filter_ram_tb.v", "filter_ram", " builtins.v filter_ram.v RAM.v delay.v ram_primitives.v"));
    }

    {
      ifstream t("./experiments/eth_axi_tx.cpp");
      std::string str((std::istreambuf_iterator<char>(t)),
                      std::istreambuf_iterator<char>());

      auto tokens = tokenize(str);
      ParserModule mod = parse(tokens);

      cout << "Ethernet mod" << endl;
      cout << mod << endl;

    
      REQUIRE(mod.getStatements().size() >= 1);

      {
        SynthCppModule scppMod(mod);    
        auto arch = synthesizeVerilog(scppMod, "write_header_func");
      }

      {
        SynthCppModule scppMod(mod);    
        auto arch = synthesizeVerilog(scppMod, "write_byte_func");
 
        llvm::legacy::PassManager pm;
        pm.add(new LoopInfoWrapperPass());
        pm.add(new AAResultsWrapperPass());
        pm.add(new TargetLibraryInfoWrapperPass());
        pm.add(createGVNPass());
        pm.add(createDeadStoreEliminationPass());
        cout << "Before GVN pass" << endl;
        cout << valueString(scppMod.getFunction("write_byte_func")->llvmFunction()) << endl;
      
        pm.run(*(scppMod.mod.get()));

        cout << "After GVN" << endl;
        cout << valueString(scppMod.getFunction("write_byte_func")->llvmFunction()) << endl;
      }

      {
        SynthCppModule scppMod(mod);    
        auto arch = synthesizeVerilog(scppMod, "write_one_byte_packet");
        map<llvm::Value*, int> layout = {};

        auto tx =
          sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 4));
        auto dest_mac =
          sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 0));
        auto src_mac =
          sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 1));
        auto type =
          sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 2));
        auto payload =
          sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 3));

        TestBenchSpec tb;
        map<string, int> testLayout = {};
        tb.memoryInit = {};
        tb.memoryExpected = {};
        tb.runCycles = 200;
        tb.maxCycles = 300;
        tb.name = "write_one_byte_packet";
        tb.useModSpecs = true;
        tb.settablePort(tx, "m_axis_tready");
        tb.settablePort(dest_mac, "wdata");
        tb.settablePort(src_mac, "wdata");
        tb.settablePort(type, "wdata");
        tb.settablePort(payload, "wdata");                  

        tb.settablePort(dest_mac, "wen");
        tb.settablePort(src_mac, "wen");
        tb.settablePort(type, "wen");
        tb.settablePort(payload, "wen");                  

        map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
        map_insert(tb.actionsInCycles, 1, string("arg_0_wdata <= 25;"));
        map_insert(tb.actionsInCycles, 1, string("arg_1_wdata <= 13;"));
        map_insert(tb.actionsInCycles, 1, string("arg_2_wdata <= 8;"));
        map_insert(tb.actionsInCycles, 1, string("arg_3_wdata <= 49;"));

        map_insert(tb.actionsInCycles, 1, string("arg_0_wen <= 1;"));
        map_insert(tb.actionsInCycles, 1, string("arg_1_wen <= 1;"));
        map_insert(tb.actionsInCycles, 1, string("arg_2_wen <= 1;"));
        map_insert(tb.actionsInCycles, 1, string("arg_3_wen <= 1;"));

        map_insert(tb.actionsInCycles, 2, string("arg_0_wen <= 0;"));
        map_insert(tb.actionsInCycles, 2, string("arg_1_wen <= 0;"));
        map_insert(tb.actionsInCycles, 2, string("arg_2_wen <= 0;"));
        map_insert(tb.actionsInCycles, 2, string("arg_3_wen <= 0;"));
      
        map_insert(tb.actionsInCycles, 0, string("arg_4_m_axis_tready = 1;"));
        map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
        emitVerilogTestBench(tb, arch, testLayout);

        // Need to figure out how to inline register specifications
        REQUIRE(runIVerilogTest("write_one_byte_packet_tb.v", "write_one_byte_packet", " builtins.v write_one_byte_packet.v RAM.v delay.v ram_primitives.v eth_axis_tx.v"));
      
      }

    }

    {
      ifstream t("./experiments/fadd.cpp");
      std::string str((std::istreambuf_iterator<char>(t)),
                      std::istreambuf_iterator<char>());

      auto tokens = tokenize(str);
      ParserModule mod = parse(tokens);
    
      SynthCppModule scppMod(mod);

      cout << "-- Float adder" << endl;
      SynthCppClass* c = scppMod.getClassByName(Token("adder"));
      cout << *c << endl;
      cout << "-- End of adder" << endl;

      auto arch = synthesizeVerilog(scppMod, "fadd_32");

      map<llvm::Value*, int> layout = {};

      auto in0 =
        sc<Argument>(getArg(scppMod.getFunction("fadd_32")->llvmFunction(), 0));
      auto in1 =
        sc<Argument>(getArg(scppMod.getFunction("fadd_32")->llvmFunction(), 1));
      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 200;
      tb.maxCycles = 300;
      tb.name = "fadd_32";
      tb.useModSpecs = true;
      tb.settablePort(in0, "in_data");
      tb.settablePort(in1, "in_data");
      
      map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
      emitVerilogTestBench(tb, arch, testLayout);
      //REQUIRE(runIVerilogTest("fadd_32_tb.v", "fadd_32", " builtins.v fadd_32.v"));
    }
    
  }

  TEST_CASE("RAM pipelining tests") {

      ifstream t("./experiments/ram_iclass.cpp");
      std::string str((std::istreambuf_iterator<char>(t)),
                      std::istreambuf_iterator<char>());

      auto tokens = tokenize(str);
      cout << "Tokens" << endl;
      for (auto t : tokens) {
        cout << "\t" << t.getStr() << endl;
      }

      ParserModule parseMod = parse(tokens);

      cout << parseMod << endl;

      REQUIRE(parseMod.getStatements().size() >= 2);

      SynthCppModule scppMod(parseMod);

      REQUIRE(scppMod.getClasses().size() >= 1);
      REQUIRE(scppMod.getFunctions().size() >= 1);

      cout << "Before synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
      for (auto func : scppMod.getInterfaceFunctions().constraints) {
        cout << tab(1) << "# of constraints on " <<
          string(func.first->getName()) << " = " <<
          func.second.constraints.size() << endl;
      }
    
      auto arch = synthesizeVerilog(scppMod, "independent_writes");

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      map<llvm::Value*, int> layout = {};

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.runCycles = 70;
      tb.maxCycles = 100;
      tb.name = "independent_writes";
      tb.useModSpecs = true;
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
      checkRAMContents(tb, 30, "arg_0", {0, 1, 2, 3, 4});
      emitVerilogTestBench(tb, arch, testLayout);

      // Need to figure out how to inline register specifications
      REQUIRE(runIVerilogTest("independent_writes_tb.v", "independent_writes", " builtins.v independent_writes.v RAM.v delay.v ram_primitives.v"));

  }

  TEST_CASE("Pipeline statement") {
    std::string str =
      "pipeline(4) {"
      "for (index = 0; index < 5; index = index + 1) {"
      "mem.write(index, index);"
      "}"
      "}";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    REQUIRE(tp.has_value());

    REQUIRE(st.atEnd());

    delete tp.get_value();
  }

  
}
