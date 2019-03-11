[![Build Status](https://travis-ci.org/dillonhuff/ahaHLS.svg?branch=master)](https://travis-ci.org/dillonhuff/ahaHLS)

# A Basic High Level Synthesis System Using LLVM

## Project Structure

* [src/](src/) - The source code for scheduling and verilog generation
* [test/scheduling.cpp](test/scheduling.cpp) - Unit tests of the HLS tool
* [test/ll_files/](test/ll_files/) - Example programs that are synthesized in unit tests

# Dependencies:

* LLVM and clang
* Z3 SMT solver
* Icarus Verilog (to run the unit tests of generated verilog)

# Build and Test Instructions

Once the dependencies are installed do:

```bash
cmake .
make -j
./all-tests 
```

# Source Code Video Tour!

[Click here and I'll give you a casual video walkthrough of the repository.](https://www.youtube.com/watch?v=1DOvSIA8jyM)