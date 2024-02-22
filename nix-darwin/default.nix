{ inputs, pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";
  services.nix-daemon.enable = true;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  programs.zsh.enable = true;
  environment = {
    # shells = with pkgs; [ bash zsh ];
    # loginShell = pkgs.zsh;
    # systemPackages = [ pkgs.coreutils ];
    # systemPath = [ "/opt/homebrew/bin" ];
    # pathsToLink = [ "/Applications" ];
  };

  system.defaults = {
    NSGlobalDomain = {
      # Appearance - Dark Mode
      AppleInterfaceStyle = "Dark";
    };
    # Desktop & Dock
    dock = {
      # Icon size of Dock: 48 pixels
      tilesize = 48;
      # Don't show recent applications in Dock
      show-recents = false;
    };
  };

  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  # fonts.fontDir.enable = true; # DANGER
  # fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  # services.nix-daemon.enable = true;
  # system.defaults = {
    # finder.AppleShowAllExtensions = true;
    # finder._FXShowPosixPathInTitle = true;
    # dock.autohide = false;
    # NSGlobalDomain.AppleShowAllExtensions = true;
    # NSGlobalDomain.InitialKeyRepeat = 14;
    # NSGlobalDomain.KeyRepeat = 1;
  # };
}