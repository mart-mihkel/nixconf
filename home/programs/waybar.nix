{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        spacing = 12;
        modules-left = ["custom/icon" "hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["tray" "network" "bluetooth" "pulseaudio" "backlight" "battery"];

        "custom/icon".format = " 󱄅";

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
        padding: 0 2;
        opacity: 0.5;
      }

      #workspaces button.active {
        opacity: 1;
      }
    '';
  };
}
