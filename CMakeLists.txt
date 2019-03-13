cmake_minimum_required(VERSION 2.6)

project(DHLS)

SET(LLVM_DIR /usr/local/opt/llvm/lib/cmake/llvm)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

SET(EXTRA_CXX_COMPILE_FLAGS "-std=c++11 -I./src -I./test -I./benchmarks -I/opt/local/include -I/usr/include -I/usr/local/include/ -I/usr/lib -O2 -Wall -fPIC -I./z3-4.8.4.d6df51951f4c-x64-ubuntu-16.04/include -L./z3-4.8.4.d6df51951f4c-x64-ubuntu-16.04/bin -fno-rtti")
SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${EXTRA_CXX_COMPILE_FLAGS}")

INCLUDE_DIRECTORIES(./src/)

SET(CPP_FILES ./src/scheduling.cpp
              ./src/verilog_backend.cpp
              ./src/llvm_codegen.cpp
              ./src/utils.cpp)

llvm_map_components_to_libnames(llvm_libs support core irreader passes)

add_library(dhls ${CPP_FILES})
target_link_libraries(dhls ${llvm_libs} z3)

# Test executables
SET(ALL_TEST_FILES ./test/scheduling.cpp
                   ./test/dependence.cpp
                   ./test/test_utils.cpp)

add_executable(all-tests ${ALL_TEST_FILES})
target_link_libraries(all-tests dhls ${llvm_libs})

SET(ALL_BINDING_FILES experiments/generate_bindings.cpp)
add_executable(make-bindings ${ALL_BINDING_FILES})
target_link_libraries(make-bindings dhls ${llvm_libs})

SET(ALL_REDUCE_4_FILES experiments/synthesize_reduce_4.cpp)
add_executable(synthesize-reduce-4 ${ALL_REDUCE_4_FILES})
target_link_libraries(synthesize-reduce-4 dhls ${llvm_libs})

SET(ALL_INTERFACE_FUNCTION_FILES experiments/synthesize_interface_functions.cpp)
add_executable(synthesize-interface-functions ${ALL_INTERFACE_FUNCTION_FILES})
target_link_libraries(synthesize-interface-functions dhls ${llvm_libs})

SET(ALL_PARSER_FILES experiments/parser.cpp)
add_executable(parser ${ALL_PARSER_FILES})
target_link_libraries(parser dhls ${llvm_libs})
