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

    map<string, Instance*> functionalUnits;
    map<string, FunctionalUnit> wireSourceControllers;
    map<string, RegController> wireSourceRegisters;

    mod->setDef(def);
  }

}

#endif
