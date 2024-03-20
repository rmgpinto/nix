{ inputs, pkgs, lib, arch, hostname, homeDirectory, ... }: {
  nixpkgs.hostPlatform = arch;
  nix = {
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      interval = {
        Hour = 12;
        Minute = 0;
      };
    };
  };
  services.nix-daemon.enable = true;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Activation scripts
  system.activationScripts.extraActivation.text = ''
    echo "Disabling Hotkeys..."
    /usr/libexec/PlistBuddy ${homeDirectory}/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:64' || true
    /usr/libexec/PlistBuddy ${homeDirectory}/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:64:enabled bool false' || true
    /usr/libexec/PlistBuddy ${homeDirectory}/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:65' || true
    /usr/libexec/PlistBuddy ${homeDirectory}/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:65:enabled bool false' || true
  
    echo "Creating Screenshots directory..."
    mkdir -p ${homeDirectory}/Screenshots

    echo "Changing Raycast hotkey..."
    defaults write com.raycast.macos raycastGlobalHotkey -string "Command-49";

    echo "Activating Settings..."
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

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
    CustomUserPreferences.NSGlobalDomain."com.apple.sound.uiaudio.enabled" = false;
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
    CustomUserPreferences."com.apple.TextInputMenu" = {
      visible = false;
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
        "/Applications/Notion.app"
        "${pkgs.vscode}/Applications/Visual\ Studio\ Code.app"
        "${pkgs.alacritty}/Applications/Alacritty.app"
        "/Applications/Slack.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/System\ Settings.app"
      ];
    };
    # Screen saver
    # Start after 5 minutes
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.screensaver".idleTime = 300;
    # Ask for password immediately after sleep
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.screensaver".askForPassword = true;
    CustomUserPreferences."~/Library/Preferences/ByHost/com.apple.screensaver".askForPasswordDelay = 0;
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
    CustomUserPreferences."com.apple.finder" = {
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
      IncludeDevelopMenu = true;
      WebKitDeveloperExtrasEnabledPreferenceKey = true;
      AlwaysRestoreSessionAtLaunch = true;
      AlwaysShowTabBar = true;
      SearchProviderShortName = "DuckDuckGo";
      "ShowFavoritesBar-v2" = true;
    };
    CustomUserPreferences."com.apple.Safari.SandboxBroker" = {
      ShowDevelopMenu = true;
    };
  };

  # Disable startup sound
  system.startup.chime = false;

  # Touch ID & Password
  security.pam.enableSudoTouchIdAuth = true;

  # Hostname
  networking.hostName = hostname;
  networking.computerName = hostname;

  environment = {
    pathsToLink = [
      "/share/zsh"
    ];
    # Required for TouchID to work in tmux
    etc."pam.d/sudo_local".text = ''
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';
  };

  # Fonts
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      fira-code-nerdfont
    ];
  };

  # Homebrew
  homebrew = {
    enable = true;
    brews = import ./brew-apps.nix;
    casks = import ./brew-cask-apps.nix;
    masApps = import ./brew-mas-apps.nix;
  };
}
