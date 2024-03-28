{
  description = "terraform devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            tenv
          ];
          shellHook = ''
            export TENV_ROOT=${pkgs.tenv}/bin/versions
            sudo mkdir -p ''${TENV_ROOT}/Terraform
            sudo chown -R ''$(whoami):staff ''${TENV_ROOT}
          '';
        };
      }
    );
}
