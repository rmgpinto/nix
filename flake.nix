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
      darwinHomeDirectory = "/Users/${username}";
      darwinArch = "aarch64-darwin";
      darwinOS = "macos";
      hostname = "laptop";
      git = {
        name = "Ricardo Gândara Pinto";
        email = "hessian_loom_0u@icloud.com";
        signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6lAw1vXZ0L5LrPsHTNBijcD7szk0vucMyhhNPT6AhKjD53j1d0yrc0ScRxbLFEdnE7NLtyWIOXjAkbjsN6rMABHGuUFQpJ+skHY84vWvYkGAmxvElhibY34cZUMMykejz3q9gNMVa1pwN17WvIMkKgD8asyD4ScXC5IH+tmdUUaEb5SItU/Bo0KQc7FHmf6CVbGetOwv6h4Q7FrhhMo/LllBp/CwuupnoYr0SOgwuJDiQSFHEhGLXxZv5F3E1xgcv40jmYgX2qkjTviby039d8ry//NFT8PUu4qTL/Li72rmDJ5xL/NYnCUGZkV1uRsT285WgAH4QD7At74E+70AR1jzNUkAbO6yDVnrte63CoXsDY9v4Gb4Z1v1nMHumj/+VxFTEdUvAS96F900W0o+FLOB1dg/b7lSG+5cSHnQdKqAEVS97MFOJRCEY8MHT/ykY9YOnS0YhnyIgYfAtY0c8k1QlMZm0pGHuFDemjZKJJWR6CgjrrmRFDNWVBW+RphTZWy4rz0fzoWzk8dKgSXiEvCrMB1nsMpikbx1ctPadaWiwjQI6/vaArDjrIS5BAXzoQDsi23egRpwzaW+n2N4IaW/2L+UW7qdMfKEItlXCcVOOhMnBlIjP5VlNvzpXkyfPWliQOW7pnnp9T3WH11seF4J3GYRyBXnKgymYPE5uCQ==";
      };
      stateVersion = "23.11";
    in
    {
      darwinConfigurations.macos = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs username hostname git stateVersion;
          homeDirectory = darwinHomeDirectory;
          arch = darwinArch;
          os = darwinOS;
        };
        modules = [
          ./nix-darwin
          {
            users.users.${username}.home = darwinHomeDirectory;
          }
          home-manager.darwinModules.home-manager
          (import ./home-manager)
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.extraSpecialArgs = {
              homeDirectory = darwinHomeDirectory;
              os = darwinOS;
              git = git;
            };
          }
        ];
      };
    };
}
