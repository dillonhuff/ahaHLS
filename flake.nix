{
  description = "Watch nix flakes in rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        name = "ahaHLS";
        packages.ahaHLS = import ./default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.default = packages.ahaHLS;
      }
    );
}
