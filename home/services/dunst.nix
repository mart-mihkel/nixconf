{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";

        width = "(16, 512)";
        height = "(16, 256)";
        offset = "(12, 12)";
        origin = "top-right";

        font = "JetbrainsMono Nerd Font 10";
        alignment = "right";
        markup = "full";

        icon_position = "right";
        min_icon_size = 64;
        max_icon_size = 64;

        horizontal_padding = 6;
        padding = 6;

        separator_height = 2;
        corner_radius = 0;
        frame_width = 2;

        idle_threshold = 300;
      };

      urgency_low = {
        frame_color = "#eceff4";
        foreground = "#d8dee9";
        background = "#2e3440";
        timeout = 4;
      };

      urgency_normal = {
        frame_color = "#ebcb8b";
        foreground = "#d8dee9";
        background = "#2e3440";
        timeout = 8;
      };

      urgency_critical = {
        frame_color = "#bf616a";
        foreground = "#d8dee9";
        background = "#2e3440";
        timeout = 16;
      };
    };
  };
}
