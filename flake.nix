{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    logitech-g110 = {
      type = "github";
      owner = "johanno";
#       repo = "Linux-G15-Daemon-Logitech-G110-";
      repo = "test";
    };
  };

  outputs = { self, nixpkgs, flake-utils, logitech-g110, ... }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "Logitech-G110";
         src =  logitech-g110;
          buildInputs = with nixpkgs; [
            autoPatchelfHook
            g15daemon
            gnumake42
            libusb1
            gcc
          ];
          installPhase = ''
            cd libg15-1.2.7-G110_Patch/
            ./configure
            make
            sudo make install
            cd ../g15macro-1.0.3
            ./configure
            make
            sudo make install
          '';
    };
#     flake-utils.lib.eachDefaultSystem (system:
#       let pkgs = nixpkgs.legacyPackages${system};
#       in {
#         devShell = pkgs.mkShell {
#           buildInputs = with pkgs; [
#             autoPatchelfHook
#             g15daemon
#             gnumake42
#             libusb1
#           ];
#         };
#
#     )
  };
}
