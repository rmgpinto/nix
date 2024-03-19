{ pkgs }: {
  enable = true;
  settings = {
    font = {
      normal = {
        family = "FiraCode Nerd Font";
      };
    };
  } // builtins.fromTOML (builtins.readFile
    (pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "alacritty";
        rev = "071d73effddac392d5b9b8cd5b4b527a6cf289f9";
        sha256 = "sha256-HiIYxTlif5Lbl9BAvPsnXp8WAexL8YuohMDd/eCJVQ8=";
      } + /catppuccin-mocha.toml
    )
  );
}
