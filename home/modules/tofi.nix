{pkgs, ...}: let
  cfg = ''
    font             = Jetbrains Mono Nerd Font
    font-size        = 10
    fuzzy-match      = true
    drun-launch      = true
    terminal         = foot
    result-spacing   = 25
    num-results      = 5
    width            = 100%
    height           = 100%
    padding-left     = 45%
    padding-top      = 35%
    outline-width    = 0
    border-width     = 0
    text-color       = #d8dee9
    selection-color  = #88c0d0
    background-color = #2e3440cc
  '';
in {
  programs.tofi.enable = true;
  home = {
    file.".config/waybar/config.jsonc".text = cfg;
    packages = with pkgs; [nerd-fonts.jetbrains-mono];
  };
}
