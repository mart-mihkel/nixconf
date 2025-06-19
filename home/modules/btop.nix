{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      graph_symbol = "tty";
      shown_boxes = "proc cpu";

      theme_background = false;
      rounded_corners = false;
      mem_graphs = false;
      vim_keys = true;
    };
  };
}
