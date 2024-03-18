{ pkgs }: {
  enable = true;
  baseIndex = 1;
  clock24 = true;
  mouse = true;
  plugins = with pkgs; [
    {
      plugin = tmuxPlugins.catppuccin;
      extraConfig = '' 
        set -g @catppuccin_flavour 'mocha'
        set -g @catppuccin_window_tabs_enabled on
        set -g @catppuccin_date_time "%H:%M%S"
      '';
    }
  ];
  extraConfig = ''
  '';
}