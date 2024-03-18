{ pkgs, os }: {
  enable = true;
  enableExtensionUpdateCheck = true;
  mutableExtensionsDir = true;
  extensions = [
    # New extensions can be added using the following template:
    #   name = "<extension-name>";
    #   publisher = "<publisher-name>";
    #   version = "<extension-version>";
    #   sha256 = "";
    # nix will complain about the sha256 being empty, but it will be available in the output.
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "catppuccin-vsc";
      publisher = "catppuccin";
      version = "3.13.0";
      sha256 = "sha256-z6sQhC0V6j2ws9AyQE6eaTehj+2PpDjDOplB99aTPY8=";
    })
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "catppuccin-vsc-icons";
      publisher = "catppuccin";
      version = "1.10.0";
      sha256 = "sha256-6klrnMHAIr+loz7jf7l5EZPLBhgkJODFHL9fzl1MqFI=";
    })
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "terraform";
      publisher = "hashicorp";
      version = "2.30.2024022914";
      sha256 = "sha256-HkLMSpI/xgcHTJyZrOPzuTyFwaDXi7f4xKYnI7f/WGU=";
    })
  ];
  userSettings = import ./vscode_settings_${os}.nix;
}