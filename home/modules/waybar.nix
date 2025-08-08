{pkgs, ...}: let
  cfg = ''
    {
      "spacing": 24,
      "modules-left": [
        "sway/workspaces",
        "tray"
      ],
      "modules-right": [
        "network",
        "bluetooth",
        "wireplumber",
        "backlight",
        "battery",
        "clock"
      ],
      "tray": {
        "icon-size": 12
      },
      "network": {
        "format-wifi": "net: {signalStrength}%",
        "format-ethernet": "net: eth",
        "format-disconnected": "net: off"
      },
      "bluetooth": {
        "format": "blu: off",
        "format-connected": "blu: con",
        "format-connected-battery": "blu: {device_battery_percentage}%"
      },
      "wireplumber": {
        "format": "vol: {volume}%",
        "format-muted": "vol: off"
      },
      "backlight": {
        "format": "bkl: {percent}%"
      },
      "battery": {
        "format": "bat: {capacity}%"
      }
    }
  '';

  css = ''
    * {
      all: unset;
      font-family: "Jetbrains Mono Nerd Font";
      font-weight: bold;
      font-size: 12px;
      color: #d8dee9;
    }

    #workspaces button {
      padding: 0 2px;
    }
  '';
in {
  programs.waybar.enable = true;
  home = {
    file = {
      ".config/waybar/config.jsonc".text = cfg;
      ".config/waybar/style.css".text = css;
    };

    packages = with pkgs; [nerd-fonts.jetbrains-mono wireplumber];
  };
}
