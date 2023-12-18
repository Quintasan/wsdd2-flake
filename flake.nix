{
  description = "A flake to build wsdd2";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.11";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = import nixpkgs { inherit system; };
	packageName = "wsdd2";
      in {
        packages.${packageName} = pkgs.stdenv.mkDerivation {
            name = "wsdd2";
            src = pkgs.fetchFromGitHub {
              owner = "Netgear";
              repo = "wsdd2";
              rev = "master";
              hash = "sha256-K0pGqcWzTgJGdQOIvrkXUPosgaOSL1lm81MEevK8YXk=";
            };
          
            CFLAGS = "-O2";
            installFlags = [ "PREFIX=${placeholder "out"}" ];
          };
      });
}
