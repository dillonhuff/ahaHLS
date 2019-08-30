#include "rams.h"
#include "llvm_codegen.h"

namespace ahaHLS {

  void implementRAMWrite0(Function* ramWrite0, const int latency, ExecutionConstraints& exec) {
    int addrWidth = getValueBitWidth(getArg(ramWrite0, 1));
    int width = getValueBitWidth(getArg(ramWrite0, 2));
    auto sramTp = ramWrite0->getReturnType();

    //ExecutionConstraints& exec = interfaces.getConstraints(ramWrite0);
    auto waddr0F = writePort("waddr_0", addrWidth, sramTp);
    auto wdata0F = writePort("wdata_0", width, sramTp);
    auto wen0F = writePort("wen_0", 1, sramTp);

    auto sram = getArg(ramWrite0, 0);
    auto addr = getArg(ramWrite0, 1);
    auto data = getArg(ramWrite0, 2);

    auto bb = mkBB("entry_block", ramWrite0);
    IRBuilder<> eb(bb);
    auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
    auto setData = eb.CreateCall(wdata0F, {sram, data});
    auto setEn1 = eb.CreateCall(wen0F, {sram, mkInt(1, 1)});
    // auto setEn0 = eb.CreateCall(wen0F, {sram, mkInt(0, 1)});
    auto ret = eb.CreateRet(nullptr);

    exec.add(instrStart(setAddr) == instrStart(setData));
    exec.add(instrStart(setAddr) == instrStart(setEn1));

    // TODO: Replace start(ret) with end(inlineMarker)?
    exec.add(instrStart(setAddr) + latency == instrStart(ret));

    addDataConstraints(ramWrite0, exec);

  }
}
