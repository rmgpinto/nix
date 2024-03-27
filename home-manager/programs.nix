{ pkgs, git }: {
  home-manager = {
    enable = true;
  };

  zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
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

  starship = import ./starship.nix { inherit pkgs; };

  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  git = import ./git.nix { inherit pkgs git; };

  lazygit = {
    enable = true;
    settings = {
      theme = {
        activeBorderColor = [ "#89b4fa" "bold" ];
        inactiveBorderColor = [ "#a6adc8" ];
        optionsTextColor = [ "#89b4fa" ];
        selectedLineBgColor = [ "#313244" ];
        cherryPickedCommitBgColor = [ "#45475a" ];
        cherryPickedCommitFgColor = [ "#89b4fa" ];
        unstagedChangesColor = [ "#f38ba8" ];
        defaultFgColor = [ "#cdd6f4" ];
        searchingActiveBorderColor = [ "#f9e2af" ];
      };
    };
  };

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

  tmux = import ./tmux.nix { inherit pkgs; };

  jq = {
    enable = true;
  };
}
