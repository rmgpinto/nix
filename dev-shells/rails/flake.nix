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
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            ruby
            libyaml
            rubyPackages.rails
          ];
          # rails complains about error_highlight version
          shellHook = ''
            export GEM_HOME=${pkgs.ruby}/gems
            sudo mkdir -p ''${GEM_HOME}
            sudo chown -R ''$(whoami):staff ''${GEM_HOME}
            gem install error_highlight -v 0.6.0
          '';
        };
      }
    );
}
