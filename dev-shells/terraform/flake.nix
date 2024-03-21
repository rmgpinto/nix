{
  description = "terraform devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
  };

  outputs = { self, nixpkgs, flake-utils, nixpkgs-terraform }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        terraform = nixpkgs-terraform.packages.${system}."1.6.4";
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            terraform
          ];
        };
      });
}
