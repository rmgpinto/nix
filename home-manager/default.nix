{ pkgs, lib, username, homeDirectory, stateVersion, os, ... }:
  let
    sharedDotfiles = import ./dotfiles.nix { inherit pkgs; };
    osDotfiles = if (lib.pathExists ./dotfiles_${os}.nix) then import ./dotfiles_${os}.nix { inherit pkgs; } else {};
    # osDotfiles = import ./dotfiles__${os}.nix { inherit pkgs; };
    # sharedPrograms = import ./programs { inherit pkgs; };
    # osPrograms = import ./programs/${os}.nix { inherit pkgs; };
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
          sharedDotfiles
          osDotfiles
        ];
      };
      # programs = lib.mkMerge [
      #   sharedPrograms
      #   osPrograms
      # ];
    };
  };
}