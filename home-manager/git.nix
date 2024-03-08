{ pkgs, git }: {
  enable = true;
  userName = git.name;
  userEmail = git.email;
  package = pkgs.gitAndTools.gitFull;
  delta = { enable = true; };
  lfs = { enable = true; };
  ignores = [
    ".cache/"
    ".DS_Store"
    ".direnv/"
    ".vscode/"
  ];
  aliases = (import ./aliases.nix { inherit pkgs; }).git;
  extraConfig = {
    user = {
      signingkey = git.signingkey;
    };
    core = {
      editor = "code --wait";
      hooksPath = "hooks/";
    };
    commit = {
      gpgsign = "true";
    };
    gpg = {
      program = "gpg2";
    };
    push = {
      autoSetupRemote = true;
    };
    init = {
      defaultBranch = "main";
    };
    advice = {
      addIgnoredFile = false;
    };
  };
}