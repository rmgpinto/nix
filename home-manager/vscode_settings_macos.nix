{ pkgs }:
let
  colorTheme = "Default Dark Modern";
  font = "Fira Code";
in
{
  "workbench.colorTheme" = colorTheme;
  "editor.renderWhitespace" = "all";
  "editor.fontLigatures" = true;
  "editor.formatOnSave" = true;
  "editor.tabSize" = 2;
  "terminal.integrated.fontFamily" = font;
  "terminal.integrated.scrollback" = 10000;
  "[terraform]" = {
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "hashicorp.terraform";
  };
  "[terraform-vars]" = {
    "editor.formatOnSave" = true;
  };
  "[nix]" = {
    "editor.defaultFormatter" = "B4dM4n.nixpkgs-fmt";
    "editor.formatOnSave" = true;
  };
  "search.exclude" = {
    "**/.git" = true;
    "**/node_modules" = true;
    "*.lock" = true;
    "dist" = true;
    "tmp" = true;
  };
}