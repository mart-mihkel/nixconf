{pkgs, ...}: {
  imports = [
    ./kubujuss-headless.nix
    ./modules/alacritty.nix
    ./modules/waybar.nix
    ./modules/dunst.nix
    ./modules/picom.nix
    ./modules/kitty.nix
    ./modules/nvim.nix
    ./modules/hypr.nix
    ./modules/rofi.nix
    ./modules/foot.nix
    ./modules/i3.nix
  ];

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
