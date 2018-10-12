#include "scheduling.h"

#include "algorithm.h"
#include "z3++.h"

using namespace dbhc;
using namespace llvm;
using namespace std;
using namespace z3;

namespace DHLS {

  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc) {
    // Now need to: Create a Z3 context that can take in scheduling variables
    // and compute values for them

    map<Instruction*, vector<expr> > schedVars;
    map<BasicBlock*, vector<expr> > blockSinks;

    context c;
    solver s(c);

    auto satRes = s.check();

    if (satRes == unsat) {
      cout << "NO VIABLE SCHEDULE" << endl;
      assert(false);
    }
    
    model m = s.get_model();

    Schedule sched;
    return sched;
  }
}
