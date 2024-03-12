{ pkgs, os }: {
  alacritty = {
    enable = true;
  };

  jq = {
    enable = true;
  };

  vscode = import ./vscode_${os}.nix { inherit pkgs os; };
}