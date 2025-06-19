{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo.type = "small";
      display.separator = "> ";
      modules = [
        "break"
        {
          type = "os";
          key = "OS  ";
        }
        {
          type = "kernel";
          key = "KER ";
        }
        {
          type = "packages";
          key = "PKG ";
        }
        {
          type = "shell";
          key = "SH  ";
        }
        {
          type = "terminal";
          key = "TER ";
        }
        {
          type = "wm";
          key = "WM  ";
        }
        "break"
      ];
    };
  };
}
