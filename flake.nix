{
  description = "A flake to build wsdd2";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
    	with import nixpkgs { system = "x86_64-linux"; };
        stdenv.mkDerivation {
          name = "wsdd2";
          src = fetchFromGitHub {
            owner = "Netgear";
            repo = "wsdd2";
            rev = "master";
            hash = "sha256-K0pGqcWzTgJGdQOIvrkXUPosgaOSL1lm81MEevK8YXk=";
          };
        
          CFLAGS = "-O2";
          installFlags = [ "PREFIX=${placeholder "out"}" ];
        
          meta = with lib; {
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
  };
}
