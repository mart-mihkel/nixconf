{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo.type = "small";
      display = {
        separator = "  ";
        key.type = "icon";
      };
      modules = [
        "title"
        "os"
        "kernel"
        "wm"
        "packages"
        "shell"
      ];
    };
  };
}
