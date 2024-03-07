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
      inputs.username = "rmgpinto";
    in
    {
      darwinConfigurations.macos = nix-darwin.lib.darwinSystem {
        inherit inputs;
        modules = [
          ./nix-darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${inputs.username}.imports = [ ./home-manager ];
            };
          }
        ];
      };
    };
}