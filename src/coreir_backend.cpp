#ifdef COREIR_BACKEND

#include "coreir_backend.h"

#include "coreir/libs/commonlib.h"

using namespace CoreIR;

namespace ahaHLS {

  CoreIR::Type* portType(const Port p, CoreIR::Context* c) {
    if (p.input()) {
      return c->BitIn()->Arr(p.width);
    } else {
      return c->Bit()->Arr(p.width);
    }
  }

  // CoreIR register? Use mantle register and use clr,
  // When I do addInstance I will set init?
  string unitCoreIRName(ModuleSpec& spec) {
    if (spec.name == "add") {
      return "coreir.add";
    } else if (spec.name == "mul") {
      return "coreir.mul";
    } else if (spec.name == "hls_wire") {
      return "ahaHLS.wire";
    } else if (spec.name == "eq") {
      return "ahaHLS.eq";
    } else if (spec.name == "orOp") {
      return "coreir.or";
    } else if (spec.name == "andOp") {
      return "coreir.and";
    } else if (spec.name == "coreir_reg") {
      return "ahaHLS.ahaReg";
    } else if (spec.name == "lshrOp") {
      return "coreir.lshr";
    } else if (spec.name == "notOp") {
      return "coreir.not";
    } else if (spec.name == "trunc") {
      return "coreir.slice";
    } else if (spec.name == "br_dummy") {
      return "ahaHLS.br_dummy";
    } else if (spec.name == "phi") {
      return "ahaHLS.phi";
    } else if (spec.name == "push_linebuf") {
      return "ahaHLS.push_linebuf";
    } else if (spec.name == "concat") {
      return "ahaHLS.concat";
    } else if (spec.name == "push_fifo") {
      return "ahaHLS.push_fifo";
    } else if (spec.name == "zext") {
      return "ahaHLS.zext";
    } else {
      cout << "Error: Unsupported modspec " << endl;
      cout << spec << endl;
      assert(false);
    }
  }

  map<string, CoreIR::Value*> coreIRParams(FunctionalUnit& unit,
                                           CoreIR::Context* c) {
    ModuleSpec& spec = unit.module;

    
    map<string, CoreIR::Value*> params;

    cout << "Getting params for " << spec.name << endl;
    
    if (spec.name == "push_linebuf") {

      if (!contains_key(string("IN_WIDTH"), spec.params)) {
        cout << "Params for " << spec << " do not contain IN_WIDTH!" << endl;
      }
      assert(contains_key(string("IN_WIDTH"), spec.params));
      
      params.insert({"in_width",
            CoreIR::Const::make(c, stoi(map_find(string("IN_WIDTH"), spec.params)))});

      params.insert({"out_width",
            CoreIR::Const::make(c, stoi(map_find(string("OUT_WIDTH"), spec.params)))});

      params.insert({"out_rows",
            CoreIR::Const::make(c, stoi(map_find(string("OUT_ROWS"), spec.params)))});

      params.insert({"out_cols",
            CoreIR::Const::make(c, stoi(map_find(string("OUT_COLS"), spec.params)))});
      
      return params;
    }
    
    if (spec.name == "br_dummy") {
      params.insert({"width", CoreIR::Const::make(c, 1)});
      return params;
    }
    
    if (spec.name == "trunc") {
      int inWidth = stoi(map_find(string("IN_WIDTH"), spec.params));
      int outWidth = stoi(map_find(string("OUT_WIDTH"), spec.params));

      int hi = outWidth;
      int lo = 0;
      int width = inWidth;
      params.insert({"hi", CoreIR::Const::make(c, hi)});
      params.insert({"lo", CoreIR::Const::make(c, lo)});
      params.insert({"width", CoreIR::Const::make(c, width)});

      return params;
    }

    if (spec.name == "concat") {
      int in0Width = stoi(map_find(string("IN0_WIDTH"), spec.params));
      int in1Width = stoi(map_find(string("IN1_WIDTH"), spec.params));

      params.insert({"in0_width", CoreIR::Const::make(c, in0Width)});
      params.insert({"in1_width", CoreIR::Const::make(c, in1Width)});

      return params;
    }

    if (spec.name == "phi") {
      int width = stoi(map_find(string("WIDTH"), spec.params));
      int nb_pair = stoi(map_find(string("NB_PAIR"), spec.params));

      params.insert({"nb_pair", CoreIR::Const::make(c, nb_pair)});
      params.insert({"width", CoreIR::Const::make(c, width)});

      return params;
    }

    if (spec.name == "zext") {
      int inWidth = stoi(map_find(string("IN_WIDTH"), spec.params));
      int outWidth = stoi(map_find(string("OUT_WIDTH"), spec.params));

      params.insert({"in_width", CoreIR::Const::make(c, inWidth)});
      params.insert({"out_width", CoreIR::Const::make(c, outWidth)});

      return params;
    }
    
    bool foundRst = false;
    for (auto p : spec.params) {
      if (p.first == "WIDTH") {
        params.insert({"width", CoreIR::Const::make(c, stoi(p.second))});
      } else if (p.first == "HAS_EN") {
        params.insert({"has_en", CoreIR::Const::make(c, stoi(p.second) == 1 ? true : false)});
      } else if (p.first == "RESET_VALUE") {
        //params.insert({"rst_value", CoreIR::Const::make(c, stoi(p.second) == 1 ? true : false)});
        params.insert({"rst_value", CoreIR::Const::make(c, stoi(p.second))});
        foundRst = true;
      } else {
        cout << "Error: Unsupported parameter = " << p.first << endl;
        assert(false);
      }
    }

    if (!foundRst) {
      cout << "no reset for module " << spec.name << endl;
    }
    if (!foundRst && (spec.name == "coreir_reg")) {
      params.insert({"has_clr", CoreIR::Const::make(c, 0)});
    }
    
    return params;
  }

  CoreIR::Values coreIRValues(FunctionalUnit& unit,
                              CoreIR::Context* def) {
    Values v;
    return v;
  }
  
  CoreIR::Instance* instanceForModule(FunctionalUnit& unit,
                                      CoreIR::ModuleDef* def) {
    auto inst =
      def->addInstance(unit.instName,
                       unitCoreIRName(unit.module),
                       coreIRParams(unit, def->getContext()),
                       coreIRValues(unit, def->getContext()));
    return inst;
  }
  
  map<string, CoreIR::Instance*>
  emitFunctionalUnits(MicroArchitecture& arch,
                      CoreIR::ModuleDef* def) {
    map<string, CoreIR::Instance*> instances;

    for (auto& unit : arch.functionalUnits) {
      if (unit.module.name == "push_linebuf") {
        assert(contains_key(string("IN_WIDTH"), unit.module.params));
      }
      
      if (contains_key(unit.instName, instances)) {
        continue;
      }

      if (unit.isExternal()) {
        continue;
      }

      CoreIR::Instance* inst = instanceForModule(unit, def);
      instances.insert({unit.instName, inst});
    }

    return instances;
  }

  CoreIR::Select* makeConstant(const std::string defaultValue,
                               const int dataWidth,
                               CoreIR::ModuleDef* def,
                               MicroArchitecture& arch) {

    cout << "default value is " << defaultValue << endl;
    Context* c = def->getContext();
    int value = stoi(defaultValue);

    //cout << "Building constant" << endl;
    
    CoreIR::Instance* v = def->addInstance(arch.uniqueName("const"), "coreir.const", {{"width", CoreIR::Const::make(c, dataWidth)}}, {{"value", CoreIR::Const::make(c, BitVector(dataWidth, value))}});

    //cout << "Built constant" << endl;
    return v->sel("out");
  }
  
  CoreIR::Select* findWireableFor(const std::string portName,
                                  map<string, CoreIR::Instance*>& functionalUnits,
                                  CoreIR::ModuleDef* def,
                                  MicroArchitecture& arch) {
    //cout << "Finding wireable for " << portName << endl;
    for (auto unit : arch.functionalUnits) {
      //cout << "Searching unit " << unit.instName << endl;
      for (auto pt : unit.portWires) {
        //cout << "pt = " << pt.second.name << endl;
        if ((pt.second.name == portName) ||
            (pt.second.name + "_reg"  == portName) ||
            (pt.second.name == portName + "_in_data")) {
          //cout << "Found port in unit " << unit << endl;
          //cout << "Port name is " << pt.first << endl;

          if (unit.isExternal()) {
            return def->sel("self")->sel(pt.second.name);
          } else {
            string instName = unit.instName;
            CoreIR::Instance* inst = dbhc::map_find(instName, functionalUnits);
            //cout << "Instance with port is " << *inst << endl;
            return inst->sel(pt.first);
          }
        }
      }

      for (auto pt : unit.outWires) {
        //cout << "pt = " << pt.second.name << endl;        

        if ((pt.second.name == portName) ||
            (pt.second.name + "_reg"  == portName) ||
            (pt.second.name == portName + "_out")) {

          if (unit.isExternal()) {
            return def->sel("self")->sel(pt.second.name);
          } else {
            string instName = unit.instName;
            CoreIR::Instance* inst = dbhc::map_find(instName, functionalUnits);
            //cout << "Instance with port is " << *inst << endl;
            return inst->sel(pt.first);
          }
        }
      }
    }

    cout << "Error: Could not find port for " << portName << endl;
    assert(false);
  }

  CoreIR::Select* findWireableFor(const Wire w,
                          map<string, CoreIR::Instance*>& functionalUnits,
                          CoreIR::ModuleDef* def,
                          MicroArchitecture& arch) {
    if (w.isConstant()) {
      return makeConstant(to_string(w.constVal), w.width, def, arch);
    }

    cout << w.valueString() << " is not constant, name = " << w.name << endl;
    return findWireableFor(w.valueString(), functionalUnits, def, arch);
  }

  CoreIR::Select* truncateOrExtendTo(int len,
                                     CoreIR::Select* data,
                                     CoreIR::ModuleDef* def,
                                     MicroArchitecture& arch) {
    Context* c = def->getContext();

    cout << "Data = " << *data << endl;
    int inLen = arrayLen(data);
    cout << "inLen = " << inLen << endl;
    cout << "len   = " << len << endl;

    if (len <= inLen) {
      auto trunc = def->addInstance(arch.uniqueName("trunc"),
                                    "coreir.slice",
                                    {{"width", CoreIR::Const::make(c, inLen)},
                                        {"lo", CoreIR::Const::make(c, 0)},
                                          {"hi", CoreIR::Const::make(c, len)}});

      def->connect(trunc->sel("in"), data);
      return trunc->sel("out");
    } else {
      auto ext =
        def->addInstance(arch.uniqueName("zext"),
                         "coreir.zext",
                         {{"width_in", CoreIR::Const::make(c, inLen)},
                             {"width_out", CoreIR::Const::make(c, len)}});

      def->connect(ext->sel("in"), data);
      return ext->sel("out");
    }
  }

  CoreIR::Select* buildController(int dataWidth,
                          PortValues& vals,
                          map<string, CoreIR::Instance*>& functionalUnits,
                          CoreIR::ModuleDef* def,
                          MicroArchitecture& arch) {

    // For every wire:
    //   1. Create mux, wire condition wire to mux select
    //   2. Wire value to mux 1
    //   3. Set next mux to be this mux

    //Select* result = nullptr;
    Wireable* lastMux = nullptr;
    //cout << "Building controller" << endl;

    Context* c = def->getContext();

    bool firstMux = true;
    for (auto v : vals.portVals) {
      CoreIR::Instance* mux =
        def->addInstance(arch.uniqueName("c_mux"),
                         "coreir.mux",
                         {{"width", CoreIR::Const::make(c, dataWidth)}});

      CoreIR::Select* wireCond =
        findWireableFor(v.first, functionalUnits, def, arch);

      CoreIR::Select* dataValue =
        findWireableFor(v.second, functionalUnits, def, arch);
      
      def->connect(mux->sel("sel"), wireCond->sel(0));

      if (arrayLen(dataValue) != arrayLen(mux->sel("in1"))) {
        def->connect(mux->sel("in1"), truncateOrExtendTo(arrayLen(mux->sel("in1")),
                                                         dataValue,
                                                         def,
                                                         arch));
      } else {
        def->connect(mux->sel("in1"), dataValue);
      }


      if (firstMux) {
        if (vals.defaultValue != "") {
          def->connect(mux->sel("in0"), makeConstant(vals.defaultValue, dataWidth, def, arch));
        } else {
          def->connect(mux->sel("in0"), makeConstant("0", dataWidth, def, arch));
        }
      }
      
      if (lastMux != nullptr) {
        def->connect(lastMux->sel("out"), mux->sel("in0"));
      }
      lastMux = mux;

      firstMux = false;
    }

    CoreIR::Select* ct = nullptr;
    if (vals.defaultValue != "") {
      ct = makeConstant(vals.defaultValue, dataWidth, def, arch);
    } else {
      ct = makeConstant("0", dataWidth, def, arch);
    }

    if (lastMux == nullptr) {
      return ct;
    }

    return lastMux->sel("out");
  }

  void addRegGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"width", c->Int()}, {"rst_value", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                         "ahaReg",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint width = genargs.at("width")->get<int>();
                          return c->Record({
                              {"in", c->BitIn()->Arr(width)},
                              {"en", c->BitIn()->Arr(1)},
                                {"rst", c->BitIn()->Arr(1)},
                                {"out",c->Bit()->Arr(width)}});
                        });
    ahaLib->newGeneratorDecl("ahaReg", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("ahaReg");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {
      uint width = args.at("width")->get<int>();
      int val = args.at("rst_value")->get<int>();

      def->addInstance("rstConst",
                       "coreir.const",
      {{"width", CoreIR::Const::make(c, width)}},
      {{"value", CoreIR::Const::make(c, BitVector(width, val))}});

      def->addInstance("innerReg",
                       "coreir.reg",
      {{"width",args["width"]}});

      def->addInstance("enMux", "coreir.mux", {{"width", args["width"]}});
      def->addInstance("rstMux", "coreir.mux", {{"width", args["width"]}});

      //, {"has_en", Const::make(c, true)}});
      //      {{"has_en",Const::make(c,true)}});
      
      // def->addInstance("innerReg",
      //                  "mantle.reg",
      // {{"width", CoreIR::Const::make(c, width)},
      //     {"has_en", CoreIR::Const::make(c, true)},
      //     {"has_clr", CoreIR::Const::make(c, true)}});

      //def->connect("self.in", "innerReg.in");

      def->connect("innerReg.in", "rstMux.out");

      def->connect("self.en.0", "enMux.sel");
      def->connect("self.rst.0", "rstMux.sel");

      def->connect("rstConst.out", "rstMux.in1");            
      def->connect("enMux.out", "rstMux.in0");

      def->connect("self.in", "enMux.in1");
      def->connect("innerReg.out", "enMux.in0");
      
      def->connect("innerReg.out", "self.out");
    };
    gen->setGeneratorDefFromFun(genFun);
    
  }

  void addBrGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"width", c->Int()}};    
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "br_dummy",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint width = genargs.at("width")->get<int>();                          
                          return c->Record({
                              {"in0", c->BitIn()->Arr(width)}
                            });
                        });
    ahaLib->newGeneratorDecl("br_dummy", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("br_dummy");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
                          [](Context* c, Values args, CoreIR::ModuleDef* def) {
    };
    gen->setGeneratorDefFromFun(genFun);

  }

  void addPushFifoGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"width", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "push_fifo",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint width = genargs.at("width")->get<int>();
                          return c->Record({
                              {"rst", c->BitIn()->Arr(1)},
                                {"in_data", c->BitIn()->Arr(width)},
                                  {"out_data", c->Bit()->Arr(width)},
                                    {"read_valid", c->Bit()->Arr(1)},
                                      {"write_valid", c->BitIn()->Arr(1)}});
                        });
    ahaLib->newGeneratorDecl("push_fifo", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("push_fifo");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {
      uint width = args.at("width")->get<int>();

      def->addInstance("data_reg",
                       "mantle.reg",
      {{"width", CoreIR::Const::make(c, width)}, {"has_en", CoreIR::Const::make(c, true)}});

      def->addInstance("valid_reg",
                       "mantle.reg",
      {{"width", CoreIR::Const::make(c, 1)}, {"has_en", CoreIR::Const::make(c, true)}});
      
      def->connect("self.in_data", "data_reg.in");
      def->connect("self.write_valid.0", "data_reg.en");
      def->connect("self.write_valid.0", "valid_reg.en");

      // def->connect("self.rst.0", "data_reg.en");
      // def->connect("self.write_valid.0", "valid_reg.en");
      
      def->connect("self.write_valid", "valid_reg.in");
      
      def->connect("data_reg.out", "self.out_data");
      def->connect("valid_reg.out", "self.read_valid");
    };
    gen->setGeneratorDefFromFun(genFun);
    
  }
  
  void addEqGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"width", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "eq",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint width = genargs.at("width")->get<int>();
                          return c->Record({
                              {"in0", c->BitIn()->Arr(width)},
                                {"in1", c->BitIn()->Arr(width)},
                                  {"out",c->Bit()->Arr(width)}});
                        });
    ahaLib->newGeneratorDecl("eq", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("eq");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {
      uint width = args.at("width")->get<int>();

      def->addInstance("innerReg",
                       "coreir.eq",
      {{"width", CoreIR::Const::make(c, width)}});

      def->connect("self.in0", "innerReg.in0");
      def->connect("self.in1", "innerReg.in1");      
      def->connect("innerReg.out", "self.out.0");
    };
    gen->setGeneratorDefFromFun(genFun);
    
  }

  void addConcatGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"in0_width", c->Int()}, {"in1_width", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "concat",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint in0W = genargs.at("in0_width")->get<int>();
                          uint in1W = genargs.at("in1_width")->get<int>();                          
                          return c->Record({
                              {"in0", c->BitIn()->Arr(in0W)},
                                {"in1", c->BitIn()->Arr(in1W)},
                                  {"out",c->Bit()->Arr(in0W + in1W)}});
                        });
    ahaLib->newGeneratorDecl("concat", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("concat");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {
      // uint width = args.at("width")->get<int>();

      // def->addInstance("innerReg",
      //                  "coreir.concat",
      // {{"width", CoreIR::Const::make(c, width)}});

      // def->connect("self.in0", "innerReg.in0");
      // def->connect("self.in1", "innerReg.in1");      
      // def->connect("innerReg.out", "self.out.0");
    };
    gen->setGeneratorDefFromFun(genFun);
    
  }

  void addZextGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"in_width", c->Int()}, {"out_width", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "zext",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint inWidth = genargs.at("in_width")->get<int>();
                          uint outWidth = genargs.at("out_width")->get<int>();
                          return c->Record({
                              {"in", c->BitIn()->Arr(inWidth)},
                                  {"out",c->Bit()->Arr(outWidth)}});
                        });
    ahaLib->newGeneratorDecl("zext", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("zext");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {
      uint inWidth = args.at("in_width")->get<int>();
      uint outWidth = args.at("out_width")->get<int>();
      
      def->addInstance("innerZ", "coreir.zext", {{"width_in", Const::make(c, inWidth)}, {"width_out", Const::make(c, outWidth)}});

      def->connect("innerZ.in", "self.in");      
      def->connect("innerZ.out", "self.out");
    };
    gen->setGeneratorDefFromFun(genFun);
    
  }
  
  void addPhiGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"width", c->Int()}, {"nb_pair", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "phi",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint width = genargs.at("width")->get<int>();
                          uint nb_pair = genargs.at("nb_pair")->get<int>();
                          
                          return c->Record({
                              {"last_block", c->BitIn()->Arr(32)},
                                {"s", c->BitIn()->Arr(32*nb_pair)},
                                  {"in", c->BitIn()->Arr(width*nb_pair)},
                                  {"out",c->Bit()->Arr(width)}});
                        });
    ahaLib->newGeneratorDecl("phi", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("phi");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {

      // uint width = args.at("width")->get<int>();
      // uint nb_pair = args.at("nb_pair")->get<int>();

      // // Create multiplexers to choose between each
      // Select* phiValue = makeConstant("123", width, def);
      // for (int i = 0; i < nb_pair; i++) {
      //   // Select* activeS = ;
      //   // phiValue = ite();
      // }

      // def->addInstance("innerReg",
      //                  "coreir.phi",
      // {{"width", CoreIR::Const::make(c, width)}});

      // def->connect("self.in0", "innerReg.in0");
      // def->connect("self.in1", "innerReg.in1");      
      // def->connect("innerReg.out", "self.out.0");
    };
    gen->setGeneratorDefFromFun(genFun);
    
  }

  void addPushLinebufGenerator(Namespace* ahaLib) {
    auto c = ahaLib->getContext();
    
    Params wireParams = {{"in_width", c->Int()}, {"out_width", c->Int()}, {"out_rows", c->Int()}, {"out_cols", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "push_linebuf",
                        wireParams,
                        [](Context* c, Values genargs) {
                          int in_width = genargs.at("in_width")->get<int>();
                          int out_width = genargs.at("out_width")->get<int>();                          

                          // int outRows = genargs.at("out_rows")->get<int>();
                          // int outCols = genargs.at("out_cols")->get<int>();

                          // int inDataWidth = genargs.at("in_width")->get<int>();
                          // int outDataWidth = out_width / (outRows * outCols);
                          
                          return c->Record({
                              {"wdata", c->BitIn()->Arr(in_width)},
                                {"rdata", c->Bit()->Arr(out_width)},
                                  {"wen", c->BitIn()->Arr(1)},
                                    {"valid", c->Bit()->Arr(1)},
                                      {"rst", c->BitIn()->Arr(1)}
                            });
                        });

    ahaLib->newGeneratorDecl("push_linebuf", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("push_linebuf");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {

      int nRows = 1;
      int nCols = 1;

      int outRows = args.at("out_rows")->get<int>();
      int outCols = args.at("out_cols")->get<int>();

      int inDataWidth = args.at("in_width")->get<int>();
      int outDataWidth = args.at("out_width")->get<int>() / (outRows * outCols);
      
      auto inType = c->BitIn()->Arr(inDataWidth)->Arr(nRows)->Arr(nCols);
      auto outType = c->Bit()->Arr(outDataWidth)->Arr(outCols)->Arr(outRows);
      auto imgType = c->Bit()->Arr(outDataWidth)->Arr(8)->Arr(8);

      Namespace* commonlib = CoreIRLoadLibrary_commonlib(c);      
      Generator* linebuffer = commonlib->getGenerator("linebuffer");
      
      auto innerLb = def->addInstance("inner_lb", linebuffer, {{"input_type", Const::make(c, inType)}, {"output_type", Const::make(c, outType)}, {"image_type", Const::make(c, imgType)}, {"has_valid", Const::make(c, true)}});

      def->connect("self.rst.0", "inner_lb.reset");
      def->connect("self.wen.0", "inner_lb.wen");
      def->connect("self.valid.0", "inner_lb.valid");
      // def->connect("self.clk", "inner_lb.clk");

      for (int i = 0; i < nRows; i++) {
        for (int j = 0; j < nCols; j++) {

          for (int z = 0; z < inDataWidth; z++) {
            Wireable* ijzInputBit = innerLb->sel("in")->sel(i)->sel(j)->sel(z);
            string offsetBit =
              to_string((i*nCols + j)*inDataWidth + z);
            Wireable* ijzInSelf = def->sel("self")->sel("wdata")->sel(offsetBit);

            def->connect(ijzInputBit, ijzInSelf);
          }
          
          // def->connect({"self", "wdata"},
          //              {"inner_lb", "in", to_string(i), to_string(j)});
        }
      }

      //Wireable* sel = nullptr; //def->sel("inner_lb.wdata.0.0");
      for (int i = 0; i < outRows; i++) {
        for (int j = 0; j < outCols; j++) {

          for (int z = 0; z < outDataWidth; z++) {
            Wireable* ijzOutputBit = innerLb->sel("out")->sel(i)->sel(j)->sel(z);
            string offsetBit =
              to_string((i*outCols + j)*outDataWidth + z);
            Wireable* ijzOutSelf = def->sel("self")->sel("rdata")->sel(offsetBit);

            def->connect(ijzOutputBit, ijzOutSelf);
          }
          
        }
      }

    };
    gen->setGeneratorDefFromFun(genFun);
    
  }
  
  void emitCoreIR(const std::string& name,
                  MicroArchitecture& arch,
                  CoreIR::Context* const c,
                  CoreIR::Namespace* const n) {

    auto ahaLib = c->newNamespace("ahaHLS");
    Params wireParams = {{"width", c->Int()}};
    TypeGen* wireTp =
      ahaLib->newTypeGen(
                        "wire",
                        wireParams,
                        [](Context* c, Values genargs) {
                          uint width = genargs.at("width")->get<int>();
                          return c->Record({
                              {"in_data", c->BitIn()->Arr(width)},
                                {"out_data",c->Bit()->Arr(width)}});
                        });
    ahaLib->newGeneratorDecl("wire", wireTp, wireParams);
    auto gen = ahaLib->getGenerator("wire");

    std::function<void (Context*, Values, CoreIR::ModuleDef*)> genFun =
      [](Context* c, Values args, CoreIR::ModuleDef* def) {
      uint width = args.at("width")->get<int>();

      def->addInstance("innerWire",
                       "coreir.wire",
      {{"width", CoreIR::Const::make(c, width)}});

      def->connect("self.in_data", "innerWire.in");
      def->connect("innerWire.out", "self.out_data");
    };
    gen->setGeneratorDefFromFun(genFun);

    addRegGenerator(ahaLib);
    addEqGenerator(ahaLib);
    addZextGenerator(ahaLib);        
    addBrGenerator(ahaLib);
    addPhiGenerator(ahaLib);
    addPushLinebufGenerator(ahaLib);
    addPushFifoGenerator(ahaLib);
    addConcatGenerator(ahaLib);    

    convertRegisterControllersToPortControllers(arch);
    
    vector<pair<string, CoreIR::Type*> > tps;
    for (auto port : getPorts(arch)) {
      string name = port.name;
      if (name == "clk") {
        tps.push_back({name, c->Named("coreir.clkIn")});
      } else {
        tps.push_back({name, portType(port, c)});
      }
    }
    
    CoreIR::Type* tp = c->Record(tps);

    CoreIR::Module* mod = n->newModuleDecl(name, tp);
    CoreIR::ModuleDef* def = mod->newModuleDef();

    for (auto& unit : arch.functionalUnits) {
      if (unit.module.name == "push_linebuf") {
        assert(contains_key(string("IN_WIDTH"), unit.module.params));
      }
    }
    
    map<string, CoreIR::Instance*> functionalUnits =
      emitFunctionalUnits(arch, def);

    // TODO: Need to wire up clocks?
    
    for (auto pc : arch.portControllers) {
      cout << "Controller for " << pc.first << endl;
      for (auto in : pc.second.inputControllers) {
        string portName = in.first;
        PortValues vals = in.second;

        CoreIR::Select* w =
          findWireableFor(portName, functionalUnits, def, arch);
        cout << tab(1) << "Wireable for port " << portName << " is " << *w << endl;

        int width = arrayLen(w); //10; // TODO: set by checking width
        CoreIR::Select* inputWire =
          buildController(width, vals, functionalUnits, def, arch);
        def->connect(w, inputWire);
      }
    }

    for (auto units : functionalUnits) {
      auto inst = units.second;
      string opName = inst->getModuleRef()->getNamespace()->getName() + "." + getOpName(*inst);
      cout << "Opname = " << opName << endl;
      
      if (opName == "ahaHLS.ahaReg") {
        cout << "Wiring up register reset" << endl;
        def->connect(def->sel("self.rst"), units.second->sel("rst"));
      } else if (opName == "ahaHLS.push_linebuf") {
        def->connect(def->sel("self.rst"), units.second->sel("rst"));
      } else if (opName == "ahaHLS.push_fifo") {
        def->connect(def->sel("self.rst"), units.second->sel("rst"));        
      }
    }

    mod->setDef(def);
  }

}

#endif
