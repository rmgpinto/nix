let
  colorTheme = "Default Dark Modern";
  font = "FiraCode Nerd Font";
in
{
  "workbench.colorTheme" = colorTheme;
  "editor.fontFamily" = font;
  "editor.fontLigatures" = true;
  "editor.renderWhitespace" = "all";
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