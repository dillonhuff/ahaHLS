cmake_minimum_required(VERSION 2.6)

project(DHLS)

SET(LLVM_DIR /usr/local/opt/llvm/lib/cmake/llvm)
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

SET(EXTRA_CXX_COMPILE_FLAGS "-std=c++11 -I./src -I./test -I./benchmarks -I/opt/local/include -O2 -Werror -Wall -fPIC")
SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${EXTRA_CXX_COMPILE_FLAGS}")

SET(CXX_OCL_LINK_FLAGS "-L/Users/dillon/CppWorkspace/coreir/lib/ -Lrelease/lib")
#-L/usr/local/opt/llvm/lib")
SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${CXX_OCL_LINK_FLAGS}")

INCLUDE_DIRECTORIES(./src/)

SET(CPP_FILES ./src/scheduling.cpp)

llvm_map_components_to_libnames(llvm_libs support core irreader)

add_library(dhls ${CPP_FILES})
target_link_libraries(dhls ${llvm_libs})

# Test executables
SET(ALL_TEST_FILES ./test/scheduling.cpp)

add_executable(all-tests ${ALL_TEST_FILES})

target_link_libraries(all-tests dhls ${llvm_libs})
