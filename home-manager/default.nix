{ pkgs, lib, username, homeDirectory, stateVersion, os, git, ... }:
  let
    sharedDotfiles = import ./dotfiles.nix { inherit pkgs; };
    osDotfiles = if (lib.pathExists ./dotfiles_${os}.nix) then import ./dotfiles_${os}.nix { inherit pkgs; } else {};
    sharedPrograms = import ./programs.nix { inherit pkgs git; };
    osPrograms = if (lib.pathExists ./programs_${os}.nix) then import ./programs_${os}.nix { inherit pkgs os; } else {};
    osPackages = if (lib.pathExists ./packages_${os}.nix) then import ./packages_${os}.nix { inherit pkgs; } else [];
  in
  {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = { pkgs, ... }: {
      home = {
        inherit username homeDirectory stateVersion;
        enableNixpkgsReleaseCheck = false;
        sessionVariables = import ./env.nix { inherit pkgs username; };
        shellAliases = (import ./aliases.nix { inherit pkgs; }).shell;
        file = lib.mkMerge [
          sharedDotfiles
          osDotfiles
        ];
        packages = osPackages;
      };
      programs = lib.mkMerge [
        sharedPrograms
        osPrograms
      ];
    };
  };
}