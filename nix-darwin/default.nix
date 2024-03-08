{ inputs, pkgs, lib, homeDirectory, arch, ... }: {
  nixpkgs.hostPlatform = arch;
  nix.settings.experimental-features = "nix-command flakes";
  services.nix-daemon.enable = true;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Activation scripts
  system.activationScripts.bootstrap = import ./bootstrap.nix { inherit lib; };

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
    # Language & Region
    # First day of Week
    CustomUserPreferences.".GlobalPreferences".AppleFirstWeekday = {
      gregorian = 2;
    };
    # Number format
    CustomUserPreferences.".GlobalPreferences".AppleICUNumberSymbols = {
      "0" = ".";
      "1" = ",";
      "10" = ".";
      "17" = ",";
    };
    # Control Center
    # Menu Bar icons
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.controlcenter.plist" = {
      "Bluetooth" = 18;
      "Sound" = 16;
      "BatteryShowPercentage" = 1;
    };
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.Spotlight.plist" = {
      "MenuItemHidden" = 1;
    };
    # Clock
    menuExtraClock.ShowSeconds = true;
    menuExtraClock.Show24Hour = true;
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
      persistent-apps = [
        "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
        "/System/Applications/Mail.app"
        "${homeDirectory}/Applications/Home\ Manager\ Apps/Notion.app"
        "${homeDirectory}/Applications/Home\ Manager\ Apps/Visual\ Studio\ Code.app"
        "${homeDirectory}/Applications/Home\ Manager\ Apps/Alacritty.app"
        "${homeDirectory}/Applications/Home\ Manager\ Apps/Slack.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/System\ Settings.app"
      ];
    };
    # Screen saver
    # Start after 5 minutes
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.screensaver".idleTime = 300;
    # Ask for password immediately after sleep
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.screensaver".askForPassword = true; # tbd
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.screensaver".askForPasswordDelay = 0; # tbd
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
    # Disable icons on Desktop
    finder.CreateDesktop = false;
    # Show Path bar
    finder.ShowPathbar = true;
    # Show Status bar
    finder.ShowStatusBar = true;
    # Custom settings
    CustomUserPreferences."com.apple.finder"  = {
      FXPreferredGroupBy = "Kind";
      FXArrangeGroupViewBy = "Name";
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
      ShowRecentTags = false;
      QLEnableTextSelection = true;
      NewWindowTargetPath = "file://${homeDirectory}";
    };
    CustomUserPreferences."com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };

    # Activity Monitor
    # Show all processes in Activity Monitor
    ActivityMonitor.ShowCategory = 100;
    # Sort Activity Monitor results by CPU usage
    ActivityMonitor.SortColumn = "CPUUsage";
    ActivityMonitor.SortDirection = 0;

    # Screenshots
    screencapture.location = "~/Screenshots";

    # Safari
    CustomUserPreferences."com.apple.Safari" = {
      IncludeDevelopMenu = true; # tbd
      WebKitDeveloperExtrasEnabledPreferenceKey = true; # tbd
      AlwaysRestoreSessionAtLaunch = true;
      AlwaysShowTabBar = true;
      SearchProviderShortName = "DuckDuckGo";
      "ShowFavoritesBar-v2" = true;
    };
  };

  # Disable startup sound
  system.startup.chime = false;

  # Touch ID & Password
  security.pam.enableSudoTouchIdAuth = true;
}