{ pkgs, os }: {
  enable = true;
  enableExtensionUpdateCheck = true;
  extensions = (with pkgs.vscode-extensions; [
    hashicorp.terraform
    b4dm4n.vscode-nixpkgs-fmt
  ]);
  globalSnippets = { };
  keybindings = [ ];
  mutableExtensionsDir = false;
  userSettings = import ./vscode_settings_${os}.nix { inherit pkgs; };
}