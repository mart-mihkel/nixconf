{pkgs, ...}: {
  imports = [
    ./kubujuss-headless.nix

    ./programs/waybar.nix
    ./programs/hypr.nix
    ./programs/rofi.nix
    ./programs/foot.nix
  ];

  home.pointerCursor = {
    enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 12;

    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };

  home.packages = with pkgs; [
    cloudflared
    pulseaudio
    pulsemixer
    playerctl
    chromium
    bluetui
    feh
    vlc

    nerd-fonts.jetbrains-mono
    noto-fonts
  ];
}
