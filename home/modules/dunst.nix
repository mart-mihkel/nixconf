{pkgs, ...}: let
  dunstrc = ''
    [global]
    font          = Jetbrains Mono Nerd Font 10
    format        = "%s\n%b"
    markup        = full
    alignment     = right
    icon_position = right
    width         = (16, 512)
    height        = (16, 256)
    offset        = (16, 16)
    min_icon_size = 64
    max_icon_size = 64
    frame_width   = 2
    foreground    = "#d8dee9"
    background    = "#2e3440"

    [urgency_low]
    frame_color   = "#eceff4"
    timeout       = 4

    [urgency_normal]
    frame_color   = "#ebcb8b"
    timeout       = 8

    [urgency_critical]
    frame_color   = "#bf616a"
    timeout       = 16
  '';
in {
  home = {
    file.".config/dunst/dunstrc".text = dunstrc;
    packages = with pkgs; [nerd-fonts.jetbrains-mono dunst];
  };
}
