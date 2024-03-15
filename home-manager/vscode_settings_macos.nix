let
  colorTheme = "Default Dark Modern";
  font = "FiraCode Nerd Font";
in
{
  # General
  "workbench.colorTheme" = colorTheme;
  "editor.fontFamily" = font;
  "editor.fontLigatures" = true;
  "editor.renderWhitespace" = "all";
  "editor.formatOnSave" = true;
  "editor.tabSize" = 2;
  "editor.suggest.preview" = true;
  "terminal.integrated.fontFamily" = font;
  "terminal.integrated.scrollback" = 10000;
  "search.exclude" = {
    "**/.git" = true;
    "**/node_modules" = true;
    "*.lock" = true;
    "dist" = true;
    "tmp" = true;
  };

  # Terraform
  "terraform.experimentalFeatures.prefillRequiredFields" = true;
  "terraform.codelens.referenceCount" = true;
  "terraform.languageServer.enable" = true;

  # File associations
  "[terraform]" = {
      "editor.defaultFormatter" = "hashicorp.terraform";
      "editor.formatOnSave" = true;
      "editor.formatOnSaveMode" = "file";
  };
  "[terraform-vars]" = {
    "editor.defaultFormatter" = "hashicorp.terraform";
    "editor.formatOnSave" = true;
    "editor.formatOnSaveMode" = "file";
  };
  "[nix]" = {
    "editor.defaultFormatter" = "B4dM4n.nixpkgs-fmt";
    "editor.formatOnSave" = true;
  };

}