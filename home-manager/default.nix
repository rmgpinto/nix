{ pkgs, ... }: {
  # The state version is required and should stay at the version you originally installed.
  home.stateVersion = "23.11";

  # Get this list in a separate file!!!!
  home.packages = with pkgs; [
    # ripgrep
    # fd
    # curl
    # less
  ];
  home.sessionVariables = {
    # PAGER = "less";
    # CLICLOLOR = 1;
    # EDITOR = "nvim";
  };
  # programs.bat.enable = true;
  # programs.bat.config.theme = "TwoDark";
  # programs.fzf.enable = true;
  # programs.fzf.enableZshIntegration = true;
  # programs.exa.enable = true;
  # programs.git.enable = true;
  # programs.zsh.enable = true;
  # programs.zsh.enableCompletion = true;
  # programs.zsh.enableAutosuggestions = true;
  # programs.zsh.enableSyntaxHighlighting = true;
  # programs.zsh.shellAliases = {
  #   ls = "ls --color=auto -F";
  #   nixswitch = "darwin-rebuild switch --flake ~/src/system-config/.#";
  #   nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
  # };
  # programs.starship.enable = true;
  # programs.starship.enableZshIntegration = true;
  # programs.alacritty = {
  #   enable = true;
  #   settings.font.normal.family = "MesloLGS Nerd Font Mono";
  #   settings.font.size = 16;
  # };
  home.file.".hushlogin".source = ./dotfiles/hushlogin;
}