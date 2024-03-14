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
        "docker"

        # Work
        "kubectl"
        "kubectx"
        "helm"
      ];
    };
    syntaxHighlighting.enable = true;
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

  ssh = {
    enable = true;
    extraConfig = ''
    Host *
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}