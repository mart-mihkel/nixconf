{
  programs.git = {
    enable = true;
    userName = "mart-mihkel";
    userEmail = "mart.mihkel.aun@gmail.com";

    aliases = {
      st = "status";
      sw = "switch";
      sc = "switch -c";
      ci = "commit";
      ca = "commit -a";
      ri = "rebase -i";
    };

    extraConfig = {
      core.editor = "nvim";
      pull.rebase = true;
    };
  };
}
