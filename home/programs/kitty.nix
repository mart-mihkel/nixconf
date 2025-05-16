{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetbrainsMono Nerd Font";
      size = 13;
    };

    settings = {
      editor = "nvim";

      confirm_os_window_close = 0;
      disable_ligatures = "always";
      enable_audio_bell = "no";
      copy_on_select = "yes";

      cursor = "#eceff4";
      cursor_text_color = "#282828";

      foreground = "#d8dee9";
      background = "#2e3440";

      selection_foreground = "#4c566a";
      selection_background = "#eceff4";

      color0 = "#3b4252";
      color8 = "#4c566a";

      color1 = "#bf616a";
      color9 = "#bf616a";

      color2 = "#a3be8c";
      color10 = "#a3be8c";

      color3 = "#ebcb8b";
      color11 = "#ebcb8b";

      color4 = "#81a1c1";
      color12 = "#81a1c1";

      color5 = "#b48ead";
      color13 = "#b48ead";

      color6 = "#88c0d0";
      color14 = "#8fbcbb";

      color7 = "#e5e9f0";
      color15 = "#eceff4";
    };
  };
}
