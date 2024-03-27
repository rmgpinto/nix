{ pkgs, os }: {
  enable = true;
  enableExtensionUpdateCheck = true;
  mutableExtensionsDir = true;
  # Sometimes the extensions get corrupted, to fix: rm ~/.vscode/extensions
  extensions = [
    # New extensions can be added using the following template:
    #   name = "<extension-name>";
    #   publisher = "<publisher-name>";
    #   version = "<extension-version>";
    #   sha256 = "";
    # nix will complain about the sha256 being empty, but it will be available in the output.
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      publisher = "catppuccin";
      name = "catppuccin-vsc";
      version = "3.13.0";
      sha256 = "sha256-z6sQhC0V6j2ws9AyQE6eaTehj+2PpDjDOplB99aTPY8=";
    })
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      publisher = "catppuccin";
      name = "catppuccin-vsc-icons";
      version = "1.10.0";
      sha256 = "sha256-6klrnMHAIr+loz7jf7l5EZPLBhgkJODFHL9fzl1MqFI=";
    })
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      publisher = "ms-azuretools";
      name = "vscode-docker";
      version = "1.29.0";
      sha256 = "sha256-mVRsVsolXj31WhbWnt3Xml+NnIq7Q2uHhUUd1zgW42c=";
    })
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      publisher = "hashicorp";
      name = "terraform";
      version = "2.30.2024022914";
      sha256 = "sha256-HkLMSpI/xgcHTJyZrOPzuTyFwaDXi7f4xKYnI7f/WGU=";
    })
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      publisher = "jnoortheen";
      name = "nix-ide";
      version = "0.3.1";
      sha256 = "sha256-05oMDHvFM/dTXB6T3rcDK3EiNG2T0tBN9Au9b+Bk7rI=";
    })
    (pkgs.vscode-utils.extensionFromVscodeMarketplace {
      publisher = "redhat";
      name = "vscode-yaml";
      version = "1.14.0";
      sha256 = "sha256-hCRyDA6oZF7hJv0YmbNG3S2XPtNbyxX1j3qL1ixOnF8=";
    })
  ];
  userSettings = import ./vscode_settings_${os}.nix;
}
