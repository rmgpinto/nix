{ pkgs }: {
  enable = true;
  enableZshIntegration = true;
  settings = {
    format = ''
      $directory$git_branch$git_commit$git_state$git_metrics$git_status$nix_shell$cmd_duration$line_break$character
    '';
    nix_shell = {
      disabled = false;
      symbol = "❄️ ";
      impure_msg = "";
      pure_msg = "";
      unknown_msg = "";
      format = "via [$symbol$state]($style)";
    };
    palette = "catppuccin_mocha";
  } // builtins.fromTOML (builtins.readFile
    (pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "starship";
        rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
        sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
      } + /palettes/mocha.toml
    )
  );
}
