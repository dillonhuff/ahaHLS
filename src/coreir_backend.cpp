#ifdef COREIR_BACKEND

#include "coreir_backend.h"

using namespace CoreIR;

namespace ahaHLS {

  CoreIR::Type* portType(const Port p, CoreIR::Context* c) {
    if (p.input()) {
      return c->Bit()->Arr(p.width);
    } else {
      return c->BitIn()->Arr(p.width);
    }
  }

  string unitCoreIRName(ModuleSpec& spec) {
    if (spec.name == "add") {
      return "coreir.add";
    } else if (spec.name == "hls_wire") {
      return "ahaHLS.wire";
    } else if (spec.name == "eq") {
      return "coreir.eq";
    } else if (spec.name == "andOp") {
      return "coreir.and";
    } else if (spec.name == "coreir_reg") {
      return "mantle.reg";
    } else {
      cout << "Error: Unsupported modspec " << endl;
      cout << spec << endl;
      assert(false);
    }
  }

  map<string, CoreIR::Value*> coreIRParams(ModuleSpec& spec,
                                           CoreIR::Context* c) {
    map<string, CoreIR::Value*> params;
    for (auto p : spec.params) {
      if (p.first == "WIDTH") {
        params.insert({"width", Const::make(c, stoi(p.second))});
      } else if (p.first == "HAS_EN") {
        params.insert({"has_en", Const::make(c, stoi(p.second) == 1 ? true : false)});
      } else {
        cout << "Error: Unsupported parameter = " << p.first << endl;
        assert(false);
      }
    }
    return params;
  }
  
  Instance* instanceForModule(FunctionalUnit& unit,
                              ModuleDef* def) {
    auto inst =
      def->addInstance(unit.instName,
                       unitCoreIRName(unit.module),
                       coreIRParams(unit.module, def->getContext()));
    return inst;
  }
  
  map<string, Instance*>
  emitFunctionalUnits(MicroArchitecture& arch,
                      ModuleDef* def) {
    map<string, Instance*> instances;

    for (auto unit : arch.functionalUnits) {
      if (contains_key(unit.instName, instances)) {
        continue;
      }

      if (unit.isExternal()) {
        continue;
      }

      Instance* inst = instanceForModule(unit, def);
      instances.insert({unit.instName, inst});
    }

    return instances;
  }

  // Lowers all register controllers in to functional units for each
  // register along with a 
  void convertRegisterControllersToPortControllers(MicroArchitecture& arch) {
    for (auto rc : arch.regControllers) {
      RegController c = rc.second;
      Wire reg = c.reg;
      ModuleSpec regSpec;
      regSpec.params.insert({"HAS_EN", "1"});
      regSpec.params.insert({"WIDTH", to_string(reg.width)});
      regSpec.name = "coreir_reg";
      arch.functionalUnits.push_back(functionalUnitForSpec(rc.first, regSpec));
    }
  }

  Wireable* findWireableFor(const std::string portName,
                            map<string, Instance*>& functionalUnits,
                            ModuleDef* def,
                            MicroArchitecture& arch) {
    cout << "Finding wireable for " << portName << endl;
    for (auto unit : arch.functionalUnits) {
      for (auto pt : unit.portWires) {
        if ((pt.second.name == portName) ||
            (pt.second.name + "_reg"  == portName)) {
          cout << "Found port in unit " << unit << endl;
          cout << "Port name is " << pt.first << endl;

          if (unit.isExternal()) {
            return def->sel("self")->sel(pt.second.name);
          } else {
            string instName = unit.instName;
            Instance* inst = map_find(instName, functionalUnits);
            cout << "Instance with port is " << *inst << endl;
            return inst->sel(pt.first);
          }
        }
      }

      for (auto pt : unit.outWires) {
        if ((pt.second.name == portName) ||
            (pt.second.name + "_reg"  == portName)) {

          if (unit.isExternal()) {
            return def->sel("self")->sel(pt.second.name);
          } else {
            string instName = unit.instName;
            Instance* inst = map_find(instName, functionalUnits);
            cout << "Instance with port is " << *inst << endl;
            return inst->sel(pt.first);
          }
        }
      }
    }

    cout << "Error: Could not find port for " << portName << endl;
    assert(false);
  }

  Wireable* makeConstant(const std::string defaultValue,
                         const int dataWidth,
                         ModuleDef* def) {

    cout << "default value is " << defaultValue << endl;
    Context* c = def->getContext();
    int value = stoi(defaultValue);

    cout << "Building constant" << endl;
    
    Instance* v = def->addInstance("myconst", "coreir.const", {{"width", Const::make(c, dataWidth)}}, {{"value", Const::make(c, BitVector(dataWidth, value))}});

    cout << "Built constant" << endl;
    return v->sel("out");
  }
  
  Wireable* buildController(int dataWidth,
                            PortValues& vals,
                            map<string, Instance*>& functionalUnits,
                            ModuleDef* def,
                            MicroArchitecture& arch) {

    // For every wire:
    //   1. Create mux, wire condition wire to mux select
    //   2. Wire value to mux 1
    //   3. Set next mux to be this mux

    Wireable* result = nullptr;
    Wireable* nextMux = nullptr;
    cout << "Building controller" << endl;
    
    if (nextMux == nullptr) {
      assert(result == nullptr);
      if (vals.defaultValue != "") {
        return makeConstant(vals.defaultValue, dataWidth, def);
      } else {
        return makeConstant("0", dataWidth, def);
      }
    }
    return result;
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

    std::function<void (Context*, Values, ModuleDef*)> genFun =
      [](Context* c, Values args, ModuleDef* def) {
      uint width = args.at("width")->get<int>();

      def->addInstance("innerWire",
                       "coreir.wire",
      {{"width", Const::make(c, width)}});

      def->connect("self.in_data", "innerWire.in");
      def->connect("innerWire.out", "self.out_data");
    };
    gen->setGeneratorDefFromFun(genFun);
    
    
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

    map<string, Instance*> functionalUnits =
      emitFunctionalUnits(arch, def);

    for (auto pc : arch.portControllers) {
      cout << "Controller for " << pc.first << endl;
      for (auto in : pc.second.inputControllers) {
        string portName = in.first;
        PortValues vals = in.second;
        Wireable* w = findWireableFor(portName, functionalUnits, def, arch);
        cout << tab(1) << "Wireable for port " << portName << " is " << *w << endl;

        int width = 10; // TODO: set by checking width
        Wireable* inputWire = buildController(width, vals, functionalUnits, def, arch);
        def->connect(w, inputWire);
      }
    }

    // Then what?
    // Iterate over controllers wiring up each controller
    // output to the instances of the register? Note:
    // I may also need to create a map from wire names to
    // the functional units or registers that define them?

    mod->setDef(def);
  }

}

#endif
