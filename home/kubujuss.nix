{pkgs, ...}: {
  imports = [
    ./kubujuss-headless.nix

    ./services/polybar.nix
    ./services/picom.nix
    ./services/dunst.nix

    ./programs/alacritty.nix
    ./programs/waybar.nix
    ./programs/hypr.nix
    ./programs/rofi.nix
    ./programs/i3.nix
  ];

  home = {
    pointerCursor = {
      enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    packages = with pkgs; [
      networkmanager
      cloudflared
      pulseaudio
      pulsemixer
      playerctl
      bluetui
      feh

      obsidian
      chromium
      spotify
      vlc

      nerd-fonts.jetbrains-mono
      noto-fonts
    ];
  };
}
