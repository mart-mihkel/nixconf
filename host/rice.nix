# https://github.com/mart-mihkel/moomin.git
{pkgs, ...}: {
  programs.hyprland.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    material-symbols
  ];

  environment.systemPackages = with pkgs; [
    wayland-pipewire-idle-inhibit
    adwaita-icon-theme
    brightnessctl
    wl-clipboard
    imagemagick
    pulsemixer
    wl-mirror
    playerctl
    gammastep
    fastfetch
    grimblast
    alacritty
    hyprland
    hypridle
    hyprlock
    ghostty
    hellwal
    bluetui
    cmatrix
    ffmpeg
    waybar
    impala
    wtype
    dunst
    rofi
    swww
    cava
    tofi
    foot
    feh
  ];
}
