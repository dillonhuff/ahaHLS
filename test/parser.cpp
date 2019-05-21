#include "catch.hpp"

#include "parser.h"

#include "llvm/Analysis/CallGraph.h"
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

  TEST_CASE("Parse struct statement") {
    std::string str =
      "struct Packet { bit_32 sport; bit_32 dport; bit_32 new_hop; bit_32 arrival; };";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    REQUIRE(tp.has_value());

    REQUIRE(st.atEnd());

    delete tp.get_value();    
  }

  TEST_CASE("Parse field access") {
    std::string str =
      "out.sport = in.dport;";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    REQUIRE(tp.has_value());

    REQUIRE(st.atEnd());

    delete tp.get_value();    
  }

  TEST_CASE("Block statement") {
    std::string str =
      "  {"
      "    val = a;"
      "  } ";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    REQUIRE(tp.has_value());

    REQUIRE(st.atEnd());

    delete tp.get_value();
    
  }

  TEST_CASE("If-Else statement") {
    std::string str =
      "  if (c) {"
      "    val = a;"
      "  } else {"
      "    val = b;"
      "  }";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    REQUIRE(tp.has_value());

    REQUIRE(st.atEnd());

    delete tp.get_value();
  }

  TEST_CASE("Array initializer") {
    std::string str =
      "bit_32[NUM_FLOWLETS] saved_hop = 0;";
    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    REQUIRE(tp.has_value());

    REQUIRE(st.atEnd());

    delete tp.get_value();
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

  TEST_CASE("Hazard statement") {
    std::string str =
      "hazard(write call0, read call1) {"
      "implies(call0.addr() == call1.addr(), add_hazard(start(call0) <= end(call1)));"
      "}";

    ParseState<Token> st(tokenize(str));
    auto tp = parseStatement(st);

    REQUIRE(tp.has_value());
    REQUIRE(tp.get_value()->getKind() == STATEMENT_KIND_HAZARD_DECL);
    REQUIRE(st.atEnd());

    delete tp.get_value();
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

  ParserModule parseSynthModule(const std::string filePath) {
    ifstream t(filePath);
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);

    ParserModule parseMod = parse(tokens);

    return parseMod;
  }

  TEST_CASE("Assigning primitives") {
    ParserModule parseM = parseSynthModule("./experiments/primitive_assign.cpp");
    cout << "# of statements in module = " << parseM.getStatements().size() << endl;

    SynthCppModule scppMod(parseM);

    REQUIRE(scppMod.getFunctions().size() == 1);

    auto arch = synthesizeVerilog(scppMod, "primitive_assign");

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.runCycles = 70;
    tb.maxCycles = 100;
    tb.name = "primitive_assign";
    tb.useModSpecs = true;
    tb.settableWires.insert("arg_0_wen");
    tb.settableWires.insert("arg_0_wdata");    
    map_insert(tb.actionsOnCycles, 2, string("arg_0_wdata <= 24;"));
    map_insert(tb.actionsOnCycles, 2, string("arg_0_wen <= 1;"));
    map_insert(tb.actionsOnCycles, 3, string("arg_0_wen <= 0;"));    

    map_insert(tb.actionsOnCycles, 6, assertString("arg_1_rdata === 24"));    
    emitVerilogTestBench(tb, arch, testLayout);

    // // Need to figure out how to inline register specifications
    // REQUIRE(runIVerilogTest("primitive_assign_tb.v", "packed_example", " builtins.v primitive_assign.v RAM.v delay.v ram_primitives.v"));
  }

  TEST_CASE("Using custom control") {
    ParserModule parseM = parseSynthModule("./experiments/custom_if.cpp");
    cout << "# of statements in module = " << parseM.getStatements().size() << endl;

    SynthCppModule scppMod(parseM);

    REQUIRE(scppMod.getFunctions().size() == 1);

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.runCycles = 70;
    tb.maxCycles = 100;
    tb.name = "custom_if";
    tb.useModSpecs = true;
    tb.settableWires.insert("arg_1_wen");
    tb.settableWires.insert("arg_1_wdata");
    tb.settableWires.insert("arg_2_wen");
    tb.settableWires.insert("arg_2_wdata");    
    tb.settableWires.insert("arg_3_wen");
    tb.settableWires.insert("arg_3_wdata");    

    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 4, string("rst_reg <= 0;"));        

    map_insert(tb.actionsOnCycles, 2, string("arg_1_wdata <= 1;"));
    map_insert(tb.actionsOnCycles, 2, string("arg_1_wen <= 1;"));
    map_insert(tb.actionsOnCycles, 3, string("arg_1_wen <= 0;"));    

    map_insert(tb.actionsOnCycles, 2, string("arg_2_wdata <= 13;"));
    map_insert(tb.actionsOnCycles, 2, string("arg_2_wen <= 1;"));
    map_insert(tb.actionsOnCycles, 3, string("arg_2_wen <= 0;"));    

    map_insert(tb.actionsOnCycles, 2, string("arg_3_wdata <= 19;"));
    map_insert(tb.actionsOnCycles, 2, string("arg_3_wen <= 1;"));
    map_insert(tb.actionsOnCycles, 3, string("arg_3_wen <= 0;"));
    
    map_insert(tb.actionsOnCycles, 10, assertString("arg_0_rdata === 13"));    
    
    SECTION("Baseline test with no custom control") {
      auto arch = synthesizeVerilog(scppMod, "custom_if");

      emitVerilogTestBench(tb, arch, testLayout);

      // // Need to figure out how to inline register specifications
      REQUIRE(runIVerilogTest("custom_if_tb.v", "custom_if", " builtins.v custom_if.v RAM.v delay.v ram_primitives.v"));
    }

    SECTION("With custom mux for if") {
      // Q: How do I specify custom controllers?
      // Intuitively the controller is a unit that implements a group
      // of instructions
      // Implemented by binding branch cond wires to inputs of module
      // then binding phi instruction value to output wire of mux

      // Q: How do I actually check that the substitution can be done?
      // A: No other phi can depend on the edges subsumed by the unit
      //    All of the blocks must be scheduled in the same cycle
      //    Restriction: Control binding must be doable *before* scheduling to allow
      //      user control
      //    Eventually: Must be able to describe index var computations?

      // Use control template to compute instruction mapping to FU?
      // Will custom loop patterns end up being useful? Again, is there enough
      // here to matter?
      // versatility to make a general purpose system useful?
    }
  }

  // Q: How do I want to deal with user-defined structures passed as arguments?
  // Requirements:
  //  1. Loads and stores need to be synthesized
  //  2. GEPs need to be synthesized
  //  3. Ideally: The argument would be passed to the module as multiple
  //     smaller bit-vector fields, but when reading to and from a FIFO
  //     or similar container the structure would be modeled as a single large
  //     bit vector (bulk copy operations)
  TEST_CASE("User defined structure") {
    ParserModule parseM = parseSynthModule("./experiments/packet_example.cpp");
    cout << "# of statements in module = " << parseM.getStatements().size() << endl;

    REQUIRE(parseM.getStatements().size() >= 2);

    cout << "Second statment kind = " << parseM.getStatements()[1]->getKind() << endl;
    
    SynthCppModule scppMod(parseM);

    REQUIRE(scppMod.getFunctions().size() >= 1);

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.runCycles = 70;
    tb.maxCycles = 100;
    tb.useModSpecs = true;
    tb.settableWires.insert("arg_0_wen");
    tb.settableWires.insert("arg_0_wdata");

    SECTION("sport -> sport") {
      tb.name = "packet_example";

      auto arch = synthesizeVerilog(scppMod, "packet_example");

      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 5, string("rst_reg <= 0;"));

      map_insert(tb.actionsOnCycles, 3, string("arg_0_wen <= 1;"));
      map_insert(tb.actionsOnCycles, 3, string("arg_0_wdata <= {160'd0, 32'd25};"));
      map_insert(tb.actionsOnCycles, 4, string("arg_0_wen <= 0;"));

      map_insert(tb.actionsOnCycles, 9, assertString("arg_1_rdata[31:0] === 32'd25"));
      map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
      emitVerilogTestBench(tb, arch, testLayout);
      REQUIRE(runIVerilogTest("packet_example_tb.v", "packet_example", " builtins.v packet_example.v RAM.v delay.v ram_primitives.v"));
    }

    SECTION("Mixed assign") {

      tb.name = "packet_mixed_assign";
      
      auto arch = synthesizeVerilog(scppMod, "packet_mixed_assign");

      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 5, string("rst_reg <= 0;"));

      map_insert(tb.actionsOnCycles, 3, string("arg_0_wen <= 1;"));
      map_insert(tb.actionsOnCycles, 3, string("arg_0_wdata <= {32'd0, 32'd97, 128'd0};"));
      map_insert(tb.actionsOnCycles, 4, string("arg_0_wen <= 0;"));

      map_insert(tb.actionsOnCycles, 9, assertString("arg_1_rdata[(64 + 31):64] === 32'd97"));
      map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
      emitVerilogTestBench(tb, arch, testLayout);
      REQUIRE(runIVerilogTest("packet_mixed_assign_tb.v", "packet_mixed_assign", " builtins.v packet_mixed_assign.v RAM.v delay.v ram_primitives.v"));
    }
    
  }

  TEST_CASE("Banzai flowlets") {
    ParserModule parseM = parseSynthModule("./experiments/flowlets.cpp");
    cout << "# of statements in module = " << parseM.getStatements().size() << endl;

    REQUIRE(parseM.getStatements().size() >= 2);

    SynthCppModule scppMod(parseM);

    REQUIRE(scppMod.getFunctions().size() >= 1);

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.runCycles = 70;
    tb.maxCycles = 100;
    tb.useModSpecs = true;
    tb.settableWires.insert("arg_0_wen");
    tb.settableWires.insert("arg_0_wdata");

    tb.name = "flowlets";

    auto arch = synthesizeVerilog(scppMod, "packet_example");

    // map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    // map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
    // map_insert(tb.actionsOnCycles, 5, string("rst_reg <= 0;"));

    // map_insert(tb.actionsOnCycles, 3, string("arg_0_wen <= 1;"));
    // map_insert(tb.actionsOnCycles, 3, string("arg_0_wdata <= {160'd0, 32'd25};"));
    // map_insert(tb.actionsOnCycles, 4, string("arg_0_wen <= 0;"));

    // map_insert(tb.actionsOnCycles, 9, assertString("arg_1_rdata[31:0] === 32'd25"));
    // map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
    emitVerilogTestBench(tb, arch, testLayout);
    REQUIRE(runIVerilogTest("packet_example_tb.v", "packet_example", " builtins.v packet_example.v RAM.v delay.v ram_primitives.v"));
  }
  
  TEST_CASE("RAM pipelining tests") {

    SECTION("No pipeline sanity check") {
      ParserModule parseM = parseSynthModule("./experiments/ram_iclass.cpp");
      SynthCppModule scppMod(parseM);

      auto arch = synthesizeVerilog(scppMod, "independent_writes");

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

    SECTION("Pipelined with II == 1") {
      ParserModule parseM = parseSynthModule("./experiments/ram_iclass.cpp");
      SynthCppModule scppMod(parseM);

      auto arch = synthesizeVerilog(scppMod, "pipelined_independent_writes");
      REQUIRE(arch.stg.pipelines.size() == 1);
      REQUIRE(arch.stg.pipelines[0].II() == 1);

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.runCycles = 70;
      tb.maxCycles = 100;
      tb.name = "pipelined_independent_writes";
      tb.useModSpecs = true;
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
      checkRAMContents(tb, 30, "arg_0", {0, 1, 2, 3, 4});
      emitVerilogTestBench(tb, arch, testLayout);

      // Need to figure out how to inline register specifications
      REQUIRE(runIVerilogTest("pipelined_independent_writes_tb.v", "pipelined_independent_writes", " builtins.v pipelined_independent_writes.v RAM.v delay.v ram_primitives.v"));

    }

    SECTION("Pipelined with II == 2 due to structural hazard") {
      ParserModule parseM = parseSynthModule("./experiments/ram_iclass.cpp");
      SynthCppModule scppMod(parseM);

      auto arch = synthesizeVerilog(scppMod, "pipelined_structural_hazard");
      REQUIRE(arch.stg.pipelines.size() == 1);
      REQUIRE(arch.stg.pipelines[0].II() == 2);

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.runCycles = 70;
      tb.maxCycles = 100;
      tb.name = "pipelined_structural_hazard";
      tb.useModSpecs = true;
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      // TODO: Reintroduce after figuring out cross-call constraints
      // map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
      checkRAMContents(tb, 30, "arg_0", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9});
      emitVerilogTestBench(tb, arch, testLayout);

      // Need to figure out how to inline register specifications
      REQUIRE(runIVerilogTest("pipelined_structural_hazard_tb.v", "pipelined_structural_hazard", " builtins.v pipelined_structural_hazard.v RAM.v delay.v ram_primitives.v"));
    }

    SECTION("Pipelined with longer II due to RAW memory hazard") {
      ParserModule parseM = parseSynthModule("./experiments/ram_iclass.cpp");
      SynthCppModule scppMod(parseM);

      auto arch = synthesizeVerilog(scppMod, "pipelined_memory_hazard");
      REQUIRE(arch.stg.pipelines.size() == 1);
      REQUIRE(arch.stg.pipelines[0].II() > 2);

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.runCycles = 70;
      tb.maxCycles = 100;
      tb.name = "pipelined_memory_hazard";
      tb.useModSpecs = true;
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      // TODO: Reintroduce after figuring out cross-call constraints
      // map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
      setRAMContents(tb, 0, "arg_0", {0});

      checkRAMContents(tb, 50, "arg_0", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9});
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTest("pipelined_memory_hazard_tb.v", "pipelined_memory_hazard", " builtins.v pipelined_memory_hazard.v RAM.v delay.v ram_primitives.v"));
    }

  }

  TEST_CASE("Matchlib crossbar") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "dh_crossbar");
    setGlobalLLVMModule(Mod.get());
    
    //std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "./experiments/dh_crossbar");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "dh_crossbar");

    CallGraph cg(*(Mod.get()));
    CallGraphNode* fNode = cg[f];
    for (auto calledN : *fNode) {
      CallGraphNode* called = calledN.second;

      auto calledF = called->getFunction();
      cout << tab(1) << "Called function = " << string(calledF->getName()) << endl;
      if (canDemangle(string(calledF->getName()))) {
        cout << tab(1) << "Demangled name = " << demangle(string(calledF->getName())) << endl;
      }

      deleteLLVMLifetimeCalls(calledF);

      cout << "llvm function after lifetime deletes" << endl;
      cout << valueString(calledF) << endl;

      for (auto calledByCross : *called) {
        Function* usedByCross = calledByCross.second->getFunction();
        string name = usedByCross->getName();
        if (canDemangle(name)) {
          cout << tab(2) << "Demangled name of called func = " << demangle(name) << endl;
        }

      }

      // Maybe there needs to be a value mapping that tells the compiler what
      // each value represents in hardware?

      // Values can be:
      //  * On wires
      //  * In registers
      //  * In memory
      
      // A constant is:
      //  * Data on a wire

      // Value with a primitive or struct type can be:
      //  * A piece of data (bit32)
      //  * A

      // The GetElementPtr value with constant bounds operating on a
      // struct such as sc_uint can be interpreted in hardware as the
      // wire that is coming out of the storage that is represented
      // by the pointer to source_tmp

      // The GetElementPtr value with variable bounds operating on pointers
      // can be interpreted as reading a value out of an array

      // Questions about named types in LLVM?
      // Are they modules or are they data?
      // If they are modules, pointers to them represent the collection of fields
      // on the module, and no operations (except builtin ops) can be performed
      // on them

      // If they are data then pointers to them represent storage of instances
      // of data. The pointer can be an array (of fixed length), or it can be
      // a single instance

      // Arrays can be mapped to different kinds of storage, an array can
      // be stored in RAM, stored at a given offset in a RAM, stored in a
      // bank of registers, or carried on wires.

      // If an array is carried on wires as an input to a function then
      // it must either be only read (an input), or only written (an output)

      // Build a binding from all pointers that are returned from functions
      // to values in the source code?

      // Q: What are the hardware mappings for GEP instructions that operate on
      // fields of data? The GEP itself represents the wire coming off of the module
      // that is built by the alloca instruction, but if the GEP is used in multiple
      // places the values read out of the fields may be different?

      // A: I guess a pointer to a type that can be interpreted as data (i8) represents
      // the bundle of fields on a module that stores that data

      // The fields of an LLVM struct that defines a piece of data each correspond
      // to pairs of (in / out) ports on the module that will store that data (storeMod(data)).

      // The fields of an LLVM struct compiled from a software IMPL class should also be ignored?
      // Or for sc_uint they should be allowed to be interpreted if they can be 

      // The fields of an LLVM struct that defines a module are ignored (the type is opaque)

      cout << "All gep instrs" << endl;
      for (auto& bb : calledF->getBasicBlockList()) {
        for (auto& instr : bb) {
          if (GetElementPtrInst::classof(&instr)) {
            cout << tab(2) << valueString(&instr) << endl;
            cout << tab(3) << "Result type = " << typeString(instr.getType()) << endl;
          }
        }
      }
      
      
    }

    // cout << "llvm function" << endl;
    // cout << valueString(f) << endl;

    // deleteLLVMLifetimeCalls(f);

    // cout << "llvm function after lifetime deletes" << endl;
    // cout << valueString(f) << endl;
    
  }

  
}
