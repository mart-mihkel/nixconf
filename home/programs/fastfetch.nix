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
        "packages"
        "shell"
        {
          type = "colors";
          block.range = [1 6];
        }
      ];
    };
  };
}
