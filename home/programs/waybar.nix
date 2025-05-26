{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        spacing = 8;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-right = ["tray" "network" "bluetooth" "pulseaudio" "backlight" "battery" "clock"];

        "hyprland/window" = {
          format = "{class}";
          rewrite = {
            "Chromium-browser" = "chromium  ";
            "obsidian" = "obsidian  ";
            "discord" = "discord  ";
            "Spotify" = "spotify 󰓇 ";
            "Slack" = "slack 󰒱 ";
            "foot" = "foot  ";
            "vlc" = "vlc 󰕼 ";
            "" = "󱄅 ";
          };
        };

        clock.format = "{:%a, %b-%d 󰃭 %H:%M 󰥔 }";

        tray = {
          icon-size = 12;
          spacing = 6;
        };

        network = {
          format-wifi = "{signalStrength}% {icon}";
          format-disconnected = "󰤮 ";
          format-icons = ["󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
        };

        bluetooth = {
          format = " ";
          format-connected = "󰂱 ";
          format-connected-battery = "{device_battery_percentage}% 󰂱 ";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-muted = "{volume}% 󰖁 {format_source}";
          format-source = "󰍬 ";
          format-source-muted = "󰍭 ";
          format-icons.default = ["󰕿" "󰖀" "󰕾"];
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["󰃞 " "󰃟 " "󰃠 "];
        };

        battery = {
          format = "{capacity}% {icon} ";
          format-plugged = "{capacity}% {icon}󱐋 ";
          format-charging = "{capacity}% {icon}󱐋 ";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
      };
    };

    style = ''
      * {
        all: unset;

        font-family: "JetbrainsMono Nerd Font";
        font-weight: bold;
        font-size: 12px;

        color: #eceff4;
      }

      #workspaces button {
        padding: 0 2px;
        opacity: 0.5;
      }

      #workspaces button.active {
        opacity: 1;
      }

      #tray menu {
        background-color: #2e3440;
        opacity: 0.9;
      }
    '';
  };
}
