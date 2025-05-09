{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {TERM = "xterm-256color";};
      window = {
        opacity = 0.9;
        dynamic_padding = true;
      };

      font = {
        size = 13;
        normal.family = "Jetbrains Mono Nerd Font";
      };

      colors = {
        primary = {
          foreground = "#d8dee9";
          background = "#2e3440";
        };

        cursor = {
          text = "#282828";
          cursor = "#eceff4";
        };

        selection = {
          text = "#4c566a";
          background = "#eceff4";
        };

        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };

        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
      };
    };
  };
}
