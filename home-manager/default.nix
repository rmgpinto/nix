{ pkgs, lib, username, homeDirectory, stateVersion, os, ... }:
  let
    sharedFiles = import ./dotfiles { inherit pkgs; };
    osFiles = import ./dotfiles/${os}.nix { inherit pkgs; };
  in
  {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, ... }: {
      home = {
        inherit username homeDirectory stateVersion;
        enableNixpkgsReleaseCheck = false;
        # packages = import ./packages.nix { inherit pkgs; };
        # sessionVariables = import ./env.nix { inherit pkgs username; };
        shellAliases = (import ./aliases.nix { inherit pkgs; }).shell;
        file = lib.mkMerge [
          sharedFiles
          osFiles
        ];
      };
      # programs = import ./programs.nix { inherit pkgs; };
    };
  };
}