{ inputs, pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";
  services.nix-daemon.enable = true;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # System Preferences
  system.defaults = {
    # Network
    alf = {
      # Firewall
      globalstate = 1;
      allowsignedenabled = 1;
      allowdownloadsignedenabled = 1;
    };
    # Sound
    NSGlobalDomain."com.apple.sound.beep.volume" = 0.606531;
    # Appearance
    # Dark Mode
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
    # Control Center
    menuExtraClock.ShowSeconds = true;
    # Desktop & Dock
    dock = {
      # Icon size of Dock: 48 pixels
      tilesize = 48;
      # Don't show recent applications in Dock
      show-recents = false;
      # Disable Hot Corners
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      # Dock apps
      persistent-apps = []; # tbd
    };
    # Screen Saver
    CustomUserPreferences = {
      "com.apple.screensaver" = {
        idleTime = 300; # tbd
      };
    };
    # Keyboard
    # Key repeat rate
    NSGlobalDomain.KeyRepeat = 1;
    # Delay until repeat
    NSGlobalDomain.InitialKeyRepeat = 14;
    # Disable spell check
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    # Enable long press
    NSGlobalDomain.ApplePressAndHoldEnabled = true;
    # Trackpad
    # Tracking speed
    ".GlobalPreferences"."com.apple.mouse.scaling" = 2.5;
    NSGlobalDomain."com.apple.trackpad.scaling" = 2.5;
    # Tap to click
    trackpad.Clicking = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    # Scroll direction: Un Natural
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
    # Disable swipe between pages
    NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = false;

    # Finder
    # Show all filename extensions
    NSGlobalDomain.AppleShowAllExtensions = true;
    # Display full POSIX path as Finder window title
    finder._FXShowPosixPathInTitle = true;
    # When performing a search, search the current folder by default
    finder.FXDefaultSearchScope = "SCcf";
    # Disable the warning when changing a file extension
    finder.FXEnableExtensionChangeWarning = false;
    # Use icon view in all Finder windows by default
    finder.FXPreferredViewStyle = "icnv";

    # Activity Monitor
    # Show all processes in Activity Monitor
    system.defaults.ActivityMonitor.ShowCategory = 100;
    # Sort Activity Monitor results by CPU usage
    system.defaults.ActivityMonitor.SortColumn = "CPUUsage";
    system.defaults.ActivityMonitor.SortDirection = 0;
  };

  # Disable startup sound
  system.startup.chime = false;

  # Touch ID & Password
  security.pam.enableSudoTouchIdAuth = true;

  # fonts.fontDir.enable = true; # DANGER
  # fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
}