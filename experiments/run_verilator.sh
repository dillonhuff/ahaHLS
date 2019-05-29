# verilator --cc -Wno-fatal --top-module adder adder.v also an option?

verilator --cc adder.v --exe use_fpu.cpp -Wno-lint
make -j -C obj_dir -f Vadder.mk Vadder

clang++ use_fpu.cpp ./obj_dir/verilated.o ./obj_dir/Vadder__ALL.a    -o Vadder_my -lm -lstdc++ -I/usr/local/Cellar/verilator/3.920/share/verilator/include
