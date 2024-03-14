{ pkgs, os }: {
  alacritty = import ./alacritty_${os}.nix { inherit pkgs; };

  jq = {
    enable = true;
  };

  vscode = import ./vscode_${os}.nix { inherit pkgs os; };
}