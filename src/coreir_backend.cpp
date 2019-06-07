#ifdef COREIR_BACKEND

#include "coreir_backend.h"

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

    if (spec.name == "phi") {
      int width = stoi(map_find(string("WIDTH"), spec.params));
      int nb_pair = stoi(map_find(string("NB_PAIR"), spec.params));

      params.insert({"nb_pair", CoreIR::Const::make(c, nb_pair)});
      params.insert({"width", CoreIR::Const::make(c, width)});

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
  
  CoreIR::Instance* instanceForModule(FunctionalUnit& unit,
                              CoreIR::ModuleDef* def) {
    auto inst =
      def->addInstance(unit.instName,
                       unitCoreIRName(unit.module),
                       coreIRParams(unit, def->getContext()));
    return inst;
  }
  
  map<string, CoreIR::Instance*>
  emitFunctionalUnits(MicroArchitecture& arch,
                      CoreIR::ModuleDef* def) {
    map<string, CoreIR::Instance*> instances;

    for (auto unit : arch.functionalUnits) {
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

  CoreIR::Select* truncateTo(int len,
                     CoreIR::Select* data,
                     CoreIR::ModuleDef* def,
                     MicroArchitecture& arch) {
    Context* c = def->getContext();

    cout << "Data = " << *data << endl;
    int inLen = arrayLen(data);
    auto trunc = def->addInstance(arch.uniqueName("trunc"),
                                  "coreir.slice",
                                  {{"width", CoreIR::Const::make(c, inLen)},
                                      {"lo", CoreIR::Const::make(c, 0)},
                                        {"hi", CoreIR::Const::make(c, len)}});

    def->connect(trunc->sel("in"), data);
    return trunc->sel("out");
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
        def->connect(mux->sel("in1"), truncateTo(arrayLen(mux->sel("in1")),
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

      // def->addInstance("innerReg",
      //                  "coreir.phi",
      // {{"width", CoreIR::Const::make(c, width)}});

      // def->connect("self.in0", "innerReg.in0");
      // def->connect("self.in1", "innerReg.in1");      
      // def->connect("innerReg.out", "self.out.0");
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
    addBrGenerator(ahaLib);        

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
        CoreIR::Select* inputWire = buildController(width, vals, functionalUnits, def, arch);
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
      }
    }

    mod->setDef(def);
  }

}

#endif
