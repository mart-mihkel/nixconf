{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    font = "JetbrainsMono Nerd Font Bold 10";
    terminal = "alacritty";
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
        location = mkLiteral "north";
        y-offset = 16;

        background-color = mkLiteral "#2e3440";
        border-color = mkLiteral "#4c566a";
        border = 2;
      };

      entry.cursor-width = 8;
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
}
