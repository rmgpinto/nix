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
  aliases = (import ./aliases.nix).git;
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
      format = "ssh";
    };
    "gpg \"ssh\"" = {
      program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
