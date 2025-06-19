{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    font = "cozette Regular 10";
    terminal = "foot";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        text-color = mkLiteral "#d8dee9";
        background-color = mkLiteral "transparent";
      };

      window = {
        border = 1;
        padding = 2;
        y-offset = 8;
        width = mkLiteral "10%";
        height = mkLiteral "30%";
        anchor = mkLiteral "center";
        location = mkLiteral "north";
        border-color = mkLiteral "#d8dee9";
        background-color = mkLiteral "#2e3440";
      };

      entry = {
        cursor-width = 8;
      };

      inputbar = {
        children = map mkLiteral ["entry"];
      };

      "element selected" = {
        background-color = mkLiteral "#4c566a";
      };
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
