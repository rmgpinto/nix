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
    initExtra = (import ./aliases.nix { inherit pkgs; }).functions;
  };

  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # git = import ./git.nix { inherit pkgs; };

  # gpg.enable = true;
}