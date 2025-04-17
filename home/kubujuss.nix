{
  pkgs,
  config,
  ...
}: {
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
      font = "JetbrainsMono Nerd Font Bold 10";
      terminal = "foot";
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          spacing = 0;
          padding = 0;
          margin = 0;
          border = 0;

          background-color = mkLiteral "transparent";
          border-color = mkLiteral "transparent";
          text-color = mkLiteral "#d8dee9";
        };

        window = {
          width = mkLiteral "10%";
          height = mkLiteral "40%";

          anchor = mkLiteral "center";
          location = mkLiteral "center";

          background-color = mkLiteral "#2e3440";
          border-color = mkLiteral "#4c566a";
          border = 2;
        };

        entry = {
          cursor-width = 8;
          width = mkLiteral "100%";
        };

        element.padding = 1;
        "element selected".background-color = mkLiteral "#4c566a";
      };

      package = pkgs.rofi-wayland.override {
        plugins = with pkgs; [
          wl-clipboard
          rofi-emoji
          wtype
        ];
      };
    };

    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "Jetbrains Mono Nerd Font:size=13";
        };

        cursor.color = "282828 eceff4";
        colors = {
          foreground = "d8dee9";
          background = "2e3440";

          selection-foreground = "4c566a";
          selection-background = "eceff4";

          regular0 = "3b4252";
          regular1 = "bf616a";
          regular2 = "a3be8c";
          regular3 = "ebcb8b";
          regular4 = "81a1c1";
          regular5 = "b48ead";
          regular6 = "88c0d0";
          regular7 = "e5e9f0";

          bright0 = "4c566a";
          bright1 = "bf616a";
          bright2 = "a3be8c";
          bright3 = "ebcb8b";
          bright4 = "81a1c1";
          bright5 = "b48ead";
          bright6 = "8fbcbb";
          bright7 = "eceff4";
        };
      };
    };
  };

  services = {
    dunst = {
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
  };

  home = {
    pointerCursor = {
      enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    file = {
      ".config/hypr".source = ./hypr;
      ".config/eww".source = ./eww;
    };

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
      feh
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
