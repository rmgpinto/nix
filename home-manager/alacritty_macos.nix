{ pkgs }: {
  enable = true;
  settings = {
    font = {
      normal = {
        family = "FiraCode Nerd Font";
      };
    };
    colors = (builtins.fromTOML (builtins.readFile ./alacritty_colors.toml));
  };
}