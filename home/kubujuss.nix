{pkgs, ...}: {
  imports = [
    ./kubujuss-headless.nix
  ];

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = ["--enable-features=TouchpadOverscrollHistoryNavigation"];
    };

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland.override {
        plugins = with pkgs; [
          rofi-emoji
          wl-clipboard
          wtype
        ];
      };
    };

    alacritty = {
      enable = true;
      settings = {
        env = {TERM = "xterm-256color";};
        window = {dynamic_padding = true;};

        font = {
          size = 13;
          normal = {
            family = "Jetbrains Mono Nerd Font";
            style = "Regular";
          };
        };

        colors = {
          primary = {
            foreground = "#D8DEE9";
            background = "#2E3440";
          };

          cursor = {
            text = "#282828";
            cursor = "#ECEFF4";
          };

          selection = {
            text = "#4C566A";
            background = "#ECEFF4";
          };

          normal = {
            black = "#3B4252";
            red = "#BF616A";
            green = "#A3BE8C";
            yellow = "#EBCB8B";
            blue = "#81A1C1";
            magenta = "#B48EAD";
            cyan = "#88C0D0";
            white = "#E5E9F0";
          };

          bright = {
            black = "#4C566A";
            red = "#BF616A";
            green = "#A3BE8C";
            yellow = "#EBCB8B";
            blue = "#81A1C1";
            magenta = "#B48EAD";
            cyan = "#8FBCBB";
            white = "#ECEFF4";
          };
        };
      };
    };
  };

  home = {
    pointerCursor = {
      enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    file.".config/dunst".source = ../conf/dunst;
    file.".config/hypr".source = ../conf/hypr;
    file.".config/rofi".source = ../conf/rofi;
    file.".config/eww".source = ../conf/eww;

    packages = with pkgs; [
      wayland-pipewire-idle-inhibit
      wl-clipboard
      hyprcursor
      hyprpaper
      hyprland
      hyprlock
      hypridle
      wtype
      slurp
      grim
      eww

      networkmanager
      brightnessctl
      cloudflared
      pulseaudio
      pulsemixer
      playerctl
      gammastep
      bluetui
      socat
      dunst
      unzip
      zip

      eduvpn-client
      qbittorrent
      qdigidoc
      discord
      spotify
      zoom-us
      slack
      vlc

      nerd-fonts.jetbrains-mono
      noto-fonts
    ];
  };
}
