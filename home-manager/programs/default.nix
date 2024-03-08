{ pkgs }:

{
  home-manager = {
    enable = true;
  };

  # zsh = import ./zsh.nix {
  #   inherit pkgs;
  # };

  # direnv = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   nix-direnv.enable = true;
  # };

  # git = import ./git.nix { inherit pkgs; };

  # gpg.enable = true;

  # jq.enable = true;

  # vscode = import ./vscode.nix { inherit pkgs; }; # extract to os.nix
}