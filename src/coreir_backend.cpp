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
      return "coreir.wire";
    } else if (spec.name == "eq") {
      return "coreir.eq";
    } else if (spec.name == "andOp") {
      return "coreir.and";
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
  
  void emitCoreIR(const std::string& name,
                  MicroArchitecture& arch,
                  CoreIR::Context* const c,
                  CoreIR::Namespace* const n) {

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
    
    map<string, FunctionalUnit> wireSourceControllers;
    map<string, RegController> wireSourceRegisters;

    mod->setDef(def);
  }

}

#endif
