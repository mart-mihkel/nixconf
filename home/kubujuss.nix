{pkgs, ...}: {
  imports = [
    ./kubujuss-headless.nix
    ./services/dunst.nix
    ./programs/waybar.nix
    ./programs/hypr.nix
    ./programs/foot.nix
    ./programs/rofi.nix
  ];

  home = {
    pointerCursor = {
      enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    packages = with pkgs; [
      networkmanager
      brightnessctl
      cloudflared
      pulseaudio
      pulsemixer
      playerctl
      bluetui
      feh

      eduvpn-client
      qbittorrent
      obsidian
      chromium
      qdigidoc
      discord
      spotify
      zoom-us
      slack
      vlc
    ];
  };
}
