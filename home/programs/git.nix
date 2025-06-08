{
  programs.git = {
    enable = true;
    userName = "mart-mihkel";
    userEmail = "mart.mihkel.aun@gmail.com";
    extraConfig = {
      pull.rebase = true;
      core.editor = "vim";
      init.defaultBranch = "main";
    };
  };
}
