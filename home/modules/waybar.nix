let
  cfg = ''
    {
      "spacing": 16,
      "height": 26,
      "modules-left": ["hyprland/workspaces", "tray"],
      "modules-center": ["clock"],
      "modules-right": ["network", "bluetooth", "wireplumber", "backlight", "battery"],
      "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
          "urgent": "",
          "focused": "",
          "default": ""
        }
      },
      "tray": {
        "icon-size": 10,
        "spacing": 8
      },
      "clock": {
        "format": "󰃰 {:%A, %B-%d %H:%M}"
      },
      "network": {
        "format-wifi": "{icon}{signalStrength}%",
        "format-disconnected": "󰤮 ",
        "format-icons": ["󰤯 ", "󰤟 ", "󰤢 ", "󰤥 ", "󰤨 "]
      },
      "bluetooth": {
        "format": "",
        "format-connected": "󰂱",
        "format-connected-battery": "󰂱 {device_battery_percentage}%"
      },
      "backlight": {
        "format": "{icon}{percent}%",
        "format-icons": ["󰃞 ", "󰃟 ", "󰃠 "]
      },
      "wireplumber": {
        "format": "{icon}{volume}%",
        "format-muted": "󰖁 {volume}%",
        "format-icons": {
          "default": ["󰕾 ", "󰖀 ", "󰕿 "]
        }
      },
      "battery": {
        "format": "{icon}{capacity}%",
        "format-charging": "󱐋{icon}{capacity}%",
        "format-icons": ["󰁺 ", "󰁻 ", "󰁼 ", "󰁽 ", "󰁾 ", "󰁿 ", "󰂀 ", "󰂁 ", "󰂂 ", "󰁹 "],
        "states": {
          "critical": 10,
          "warning": 20
        }
      }
    }
  '';

  css = ''
    * {
      all: unset;
    }

    window {
      font-family: "Jetbrains Mono Nerd Font";
      font-size: 12px;
      background: rgba(46, 52, 64, 0.8);
      color: #d8dee9;
    }

    #battery.warning {
      color: #ebcb8b;
    }

    #battery.critical {
      color: #bf616a;
    }

    #workspaces button {
      padding: 0 4px;
    }
  '';
in {
  programs.waybar.enable = true;
  home = {
    file = {
      ".config/waybar/config.jsonc".text = cfg;
      ".config/waybar/style.css".text = css;
    };

    packages = with pkgs; [ wireplumber ];
  };
}
