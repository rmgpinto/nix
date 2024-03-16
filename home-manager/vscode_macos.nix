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
      name = "terraform";
      publisher = "hashicorp";
      version = "2.30.2024022914";
      sha256 = "sha256-HkLMSpI/xgcHTJyZrOPzuTyFwaDXi7f4xKYnI7f/WGU=";
    })
  ];
  userSettings = import ./vscode_settings_${os}.nix;
}