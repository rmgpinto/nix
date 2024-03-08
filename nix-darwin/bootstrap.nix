{ lib, ... }: {
  enable = true;
  text = let
    hotkeys = [
      64
      65
    ];
    disableHotKeyCommands = map (key: "/usr/libexec/PlistBuddy $HOME/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:${toString key}:enabled bool false") hotkeys;
    in ''
      echo "Disabling hotkeys..."
      ${lib.concatStringsSep "\n" disableHotKeyCommands}
    '';
}