{
  programs.waybar = {
    enable = true;
    settings.bar = {
      spacing = 6;
      modules-left = ["hyprland/workspaces" "hyprland/window" "tray"];
      modules-center = ["clock"];
      modules-right = ["network" "bluetooth" "pulseaudio" "battery"];
      "hyprland/window" = {
        format = "{class}";
        tooltip-format = "{title}";
        rewrite = {
          "Brave-browser" = " brave";
          "foot" = " foot";
          "" = " nixos";
        };
      };
      tray = {
        icon-size = 10;
        spacing = 4;
      };
      clock = {
        format = "󰃰 {:%A, %B %d %H:%M}";
        tooltip-format = "{calendar}";
        calendar = {
          format = {
            today = "<span color='#a3be8c'>{}</span>";
          };
        };
      };
      network = {
        format-wifi = "直 {signalStrength}%";
        format-disconnected = "睊";
        tooltip-format = "{essid}";
      };
      bluetooth = {
        format = "";
        format-connected = "";
        format-connected-battery = " {device_battery_percentage}%";
      };
      pulseaudio = {
        format = "{icon}{volume}%";
        format-muted = "婢 {volume}%";
        format-icons.default = ["奄 " "奔 " "墳 "];
      };
      battery = {
        format = "{icon}{capacity}%";
        format-icons = [" " " " " " " " " "];
        states = {
          warning = 20;
          critical = 10;
        };
      };
    };

    style =
      # css
      ''
        * {
          all: unset;
          font-size: 12px;
          font-family: "cozette";
        }

        tooltip,
        #tray menu,
        window#waybar {
          background-color: #2e3440;
          padding: 2px 6px;
        }

        tooltip,
        #tray menu {
          border: 1px solid #eceff4;
        }

        #workspaces,
        #window,
        #tray,
        #mpris,
        #clock,
        #network,
        #bluetooth,
        #pulseaudio.source-muted,
        #backlight,
        #battery {
          color: #d8dee9;
          padding: 2px 6px;
        }

        #battery.warning {
          color: #ebcb8b;
          padding: 2px 6px;
        }

        #pulseaudio,
        #battery.critical {
          color: #bf616a;
          padding: 2px 6px;
        }

        #workspaces button {
          padding: 0 2px;
        }

        #workspaces button.active {
          color: #a3be8c;
        }

        #workspaces button.urgent {
          color: #bf616a;
        }
      '';
  };
}
