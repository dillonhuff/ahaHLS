{ pkgs ? import <nixpkgs> { } }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "ahahls";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    cmake

    # clang++ binary is needed at runtime for tests
    llvmPackages_7.clang
    # iverilog binary is needed at runtime for tests
    verilog
  ];

  buildInputs = [
    z3
    # Only works with llvm 7
    llvmPackages_7.llvm
    # llvmPackages_7.llvm.lib
    # llvmPackages_7.llvm.dev
  ];

  meta = with stdenv.lib; {
    description = "A Basic High Level Synthesis System Using LLVM";
  };
}
