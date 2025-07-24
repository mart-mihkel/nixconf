{pkgs, ...}: let
  cfg = ''
    configuration {
      font: "cozette Regular 10";
      terminal: "foot";
      modes: [drun];
    }

    @theme "~/.config/rofi/theme.rasi"
  '';

  theme = ''
    * {
      text-color: #d8dee9;
      background-color: transparent;
    }

    window {
      padding: 2;
      width: 100%;
      anchor: south;
      location: south;
      background-color: #2e3440;
      children: [ horibox ];
    }

    horibox {
      orientation: horizontal;
      children: [ prompt, entry, listview ];
    }

    listview {
      layout: horizontal;
    }

    entry {
      cursor-width: 8px;
      expand: false;
      width: 4em;
    }

    element-text {
      highlight: underline;
    }

    element {
      padding: 0 0.25em;
      margin: 0 0.25em;
    }

    element.selected {
      background-color: #4c566a;
    }
  '';
in {
  home = {
    file = {
      ".config/rofi/config.rasi".text = cfg;
      ".config/rofi/theme.rasi".text = theme;
    };

    packages = with pkgs; [
      (pkgs.rofi-wayland.override {plugins = with pkgs; [rofi-emoji];})
      cozette
    ];
  };
}
