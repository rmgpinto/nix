{ pkgs }:

{
  home-manager = {
    enable = true;
  };

  zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.size = 32768;
    oh-my-zsh = {
      enable = true;
      plugins = [
        # Personal
        "git"

        # Work
        "kubectl"
        "helm"
        "direnv"
      ];
      theme = "robbyrussell";
    };
  };

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