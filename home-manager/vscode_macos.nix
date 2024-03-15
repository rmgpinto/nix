{ pkgs, os }: {
  enable = true;
  enableExtensionUpdateCheck = true;
  mutableExtensionsDir = true;
  extensions = (with pkgs.vscode-extensions; [
    hashicorp.terraform
    b4dm4n.vscode-nixpkgs-fmt
  ]);
  userSettings = import ./vscode_settings_${os}.nix;
}