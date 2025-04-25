{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        spacing = 16;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["tray" "network" "bluetooth" "pulseaudio" "backlight" "battery"];
        tray = {
          icon-size = 14;
          spacing = 6;
        };
        clock.format = "󰃰 {:%A %B %d %H:%M}";
        network = {
          format-wifi = "{essid} {signalStrength}% {icon}";
          format-disconnected = "󰤮 ";
          format-icons = ["󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
        };
        bluetooth = {
          format = " ";
          format-connected = "{device_alias} 󰂱 ";
          format-connected-battery = "{device_alias} {device_battery_percentage}% 󰂱 ";
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
        font-size: 14px;

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
