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
        plugins = with pkgs; [rofi-emoji];
      };
    };
  };

  home = {
    pointerCursor = {
      enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    file.".config/alacritty".source = ../conf/alacritty;
    file.".config/dunst".source = ../conf/dunst;
    file.".config/hypr".source = ../conf/hypr;
    file.".config/rofi".source = ../conf/rofi;
    file.".config/eww".source = ../conf/eww;

    file.".config/picom".source = ../conf/picom;
    file.".config/i3".source = ../conf/i3;
    file.".xinitrc".text = ''
      xset r rate 256 32
      exec i3
    '';

    packages = with pkgs; [
      wayland-pipewire-idle-inhibit
      wl-clipboard
      hyprpaper
      hyprland
      hyprlock
      hypridle
      wtype
      slurp
      grim
      eww

      autotiling
      xorg.xinit
      xlockmore
      xdotool
      xclip
      picom
      maim
      feh
      i3

      networkmanager
      brightnessctl
      pulseaudio
      pulsemixer
      playerctl
      alacritty
      gammastep
      bluetui
      socat
      dunst

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
