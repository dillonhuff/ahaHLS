[![Build Status](https://travis-ci.org/dillonhuff/ahaHLS.svg?branch=master)](https://travis-ci.org/dillonhuff/ahaHLS)

# A Basic High Level Synthesis System Using LLVM

## Project Structure

- [src/](src/) - The source code for scheduling and verilog generation
- [test/scheduling.cpp](test/scheduling.cpp) - Unit tests of the HLS tool
- [test/ll_files/](test/ll_files/) - Example programs that are synthesized in unit tests

# Dependencies:

- LLVM and clang
- Z3 SMT solver
- Icarus Verilog (to run the unit tests of generated verilog)

# Build and Test Instructions

With the nix package manager you can open a shell with all the dependencies on the correct versions:

```bash
nix develop .
```

Once the dependencies are installed do:

```bash
cmake .
make -j
./all-tests
```
