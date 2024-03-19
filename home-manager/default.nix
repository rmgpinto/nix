{ pkgs, lib, username, homeDirectory, stateVersion, os, git, ... }:
let
  sharedDotfiles = import ./dotfiles.nix;
  osDotfiles = if (lib.pathExists ./dotfiles_${os}.nix) then import ./dotfiles_${os}.nix else { };
  sharedPrograms = import ./programs.nix { inherit pkgs git; };
  osPrograms = if (lib.pathExists ./programs_${os}.nix) then import ./programs_${os}.nix { inherit pkgs os; } else { };
  sharedPackages = import ./packages.nix { inherit pkgs; };
  osPackages = if (lib.pathExists ./packages_${os}.nix) then import ./packages_${os}.nix { inherit pkgs; } else [ ];
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, ... }: {
      home = {
        inherit username homeDirectory stateVersion;
        enableNixpkgsReleaseCheck = false;
        sessionVariables = import ./env.nix { inherit username; };
        shellAliases = (import ./aliases.nix).shell;
        file = lib.mkMerge [
          sharedDotfiles
          osDotfiles
        ];
        packages = lib.mkMerge [
          sharedPackages
          osPackages
        ];
      };
      programs = lib.mkMerge [
        sharedPrograms
        osPrograms
      ];
    };
  };
}
