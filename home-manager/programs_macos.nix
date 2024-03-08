{ pkgs }: {
  alacritty = {
    enable = true;
  };

  jq = {
    enable = true;
  };

  # vscode = import ./vscode.nix { inherit pkgs; };
}