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
        inherit (nixpkgs) lib;
	pkgs = nixpkgs.legacyPackages.${system};
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
        
          meta = with pkgs.lib; {
            description = "WSD/LLMNR Discovery/Name Service Daemon";
            longDescription = ''
            	The primary purpose of this project is to enable WSD on Samba servers so that network shares hosted on a Unix box can appear in Windows File Explorer / Network.
            '';
            homepage = "https://github.com/Netgear/wsdd2";
            license = licenses.gpl3Plus;
            mainprogram = "wsdd2";
            platforms = platforms.linux;
          };
        };

        defaultPackage = self.packages.${system}.${packageName};
      }
    );
}
