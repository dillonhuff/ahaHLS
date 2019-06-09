cmake_minimum_required(VERSION 2.6)

project(AHAHLS)

SET(LLVM_DIR /usr/local/opt/llvm/lib/cmake/llvm)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

if (COREIR_BACKEND)
MESSAGE(STATUS "Including CoreIR backend")
add_definitions(-DCOREIR_BACKEND=1)
endif()

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

SET(EXTRA_CXX_COMPILE_FLAGS "-std=c++11 -I./src -I./test -I./benchmarks -I/opt/local/include -I/usr/include -I/usr/local/include/ -I/usr/lib -O2 -Wall -fPIC -I./z3-4.8.4.d6df51951f4c-x64-ubuntu-16.04/include -L./z3-4.8.4.d6df51951f4c-x64-ubuntu-16.04/bin -fno-rtti")
SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${EXTRA_CXX_COMPILE_FLAGS}")

INCLUDE_DIRECTORIES(./src/)

SET(CPP_FILES ./src/scheduling.cpp
              ./src/halide_arch.cpp
              ./src/parser.cpp
              ./src/expression.cpp
              ./src/verilog_backend.cpp
              ./src/llvm_codegen.cpp
              ./src/microarchitecture.cpp
              ./src/coreir_backend.cpp
              ./src/utils.cpp
              ./src/test_utils.cpp)              

llvm_map_components_to_libnames(llvm_libs support core irreader passes)

add_library(ahahls ${CPP_FILES})
target_link_libraries(ahahls ${llvm_libs} z3)
if (COREIR_BACKEND)
target_link_libraries(ahahls coreirsim coreir coreir-commonlib)
endif()


# Test executables
SET(ALL_TEST_FILES ./test/scheduling.cpp
                   ./test/coreir_backend_tests.cpp
                   ./test/parser.cpp
                   ./test/halide_stencils.cpp
                   ./test/dependence.cpp)


add_executable(all-tests ${ALL_TEST_FILES})
target_link_libraries(all-tests ahahls ${llvm_libs})
if (COREIR_BACKEND)
target_link_libraries(ahahls coreirsim coreir)
endif()

SET(ALL_BINDING_FILES experiments/generate_bindings.cpp)
add_executable(make-bindings ${ALL_BINDING_FILES})
target_link_libraries(make-bindings ahahls ${llvm_libs})

SET(ALL_REDUCE_4_FILES experiments/synthesize_reduce_4.cpp)
add_executable(synthesize-reduce-4 ${ALL_REDUCE_4_FILES})
target_link_libraries(synthesize-reduce-4 ahahls ${llvm_libs})

SET(ALL_INTERFACE_FUNCTION_FILES experiments/synthesize_interface_functions.cpp)
add_executable(synthesize-interface-functions ${ALL_INTERFACE_FUNCTION_FILES})
target_link_libraries(synthesize-interface-functions ahahls ${llvm_libs})

SET(ALL_PARSER_FILES experiments/parser.cpp)
add_executable(parser ${ALL_PARSER_FILES})
target_link_libraries(parser ahahls ${llvm_libs})
