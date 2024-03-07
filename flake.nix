{
  description = "nix setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    username = "rmgpinto";
    homeDirectory = "/Users/${username}";
    arch = "aarch64-darwin";
    stateVersion = "23.11";
  in
  {
    darwinConfigurations.macos = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs username homeDirectory arch stateVersion; };
      modules = [
        ./nix-darwin {
          users.users.${username}.home = homeDirectory;
        }
        home-manager.darwinModules.home-manager (import ./home-manager)
      ];
    };
  };
}