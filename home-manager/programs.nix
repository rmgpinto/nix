{ pkgs, git }: {
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
        "direnv"

        # Work
        "kubectl"
        "helm"
      ];
      theme = "robbyrussell";
    };
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      '' + (import ./aliases.nix).functions;
  };

  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  git = import ./git.nix { inherit pkgs git; };

  gpg = {
    enable = true;
  };

  gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}