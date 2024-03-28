{
  description = "rails devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        gemHome = "$HOME/.gem/ruby/${builtins.baseNameOf pkgs.ruby_3_2}";
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            ruby
            rubyPackages.rails
          ];
        };
      }
    );
}
