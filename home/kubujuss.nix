{pkgs, ...}: {
  imports = [
    ./kubujuss-headless.nix
    ./services/dunst.nix
    ./services/picom.nix
    ./programs/alacritty.nix
    ./programs/waybar.nix
    ./programs/nvim.nix
    ./programs/hypr.nix
    ./programs/rofi.nix
    ./programs/foot.nix
    ./programs/i3.nix
  ];

  home.pointerCursor = {
    enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };

  home.packages = with pkgs; [
    pulseaudio
    pulsemixer
    playerctl
    bluetui
    feh

    nerd-fonts.jetbrains-mono
    noto-fonts
    cozette
  ];
}
