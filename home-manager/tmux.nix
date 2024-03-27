{ pkgs }: {
  enable = true;
  prefix = "C-a";
  terminal = "screen-256color";
  baseIndex = 1;
  clock24 = true;
  mouse = true;
  keyMode = "vi";
  aggressiveResize = true;
  tmuxinator = {
    enable = true;
  };
  plugins = with pkgs; [
    {
      plugin = tmuxPlugins.catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavour 'mocha'
        set -g @catppuccin_window_tabs_enabled on
        set -g @catppuccin_date_time "%H:%M:%S"
      '';
    }
  ];
  extraConfig = ''
    set -g renumber-windows on
    set -g status-position 'top'
  '';
}
