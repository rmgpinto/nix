{ pkgs, os }: {
  alacritty = import ./alacritty_${os}.nix { inherit pkgs; };

  vscode = import ./vscode_${os}.nix { inherit pkgs os; };
}
