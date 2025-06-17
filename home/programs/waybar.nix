{
  programs.waybar = {
    enable = true;
    settings.bar = {
      spacing = 8;
      margin = "4";

      modules-left = ["hyprland/workspaces" "hyprland/window" "mpris" "tray"];
      modules-center = ["clock"];
      modules-right = ["cpu" "memory" "network" "bluetooth" "pulseaudio" "backlight" "battery"];

      "hyprland/window".format = "{class}";
      "hyprland/window".rewrite."Brave-browser" = " brave";
      "hyprland/window".rewrite."Alacritty" = " alacritty";
      "hyprland/window".rewrite."foot" = " foot";
      "hyprland/window".rewrite."" = " nixos";

      mpris.format = "{player_icon}{status_icon}{title}";
      mpris.title-len = 32;
      mpris.player-icons.default = " ";
      mpris.status-icons.playing = " ";
      mpris.status-icons.paused = " ";

      tray.icon-size = 10;
      tray.spacing = 4;

      clock.format = "󰃰 {:%A, %B %d %H:%M}";

      cpu.format = " {usage}%";
      cpu.states.warning = 80;
      cpu.states.critical = 90;

      memory.format = " {percentage}%";
      memory.states.warning = 80;
      memory.states.critical = 90;

      network.format-wifi = "直 {signalStrength}%";
      network.format-disconnected = "睊";

      bluetooth.format = "";
      bluetooth.format-connected = "";
      bluetooth.format-connected-battery = " {device_battery_percentage}%";

      pulseaudio.format = "{icon}{volume}%";
      pulseaudio.format-muted = "婢 {volume}%";
      pulseaudio.format-icons.default = ["奄 " "奔 " "墳 "];

      backlight.format = " {percent}%";

      battery.format = "{icon}{capacity}%";
      battery.format-icons = [" " " " " " " " " "];
      battery.states.warning = 20;
      battery.states.critical = 10;
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
        #workspaces,
        #window,
        #tray,
        #mpris,
        #clock,
        #cpu,
        #memory,
        #network,
        #bluetooth,
        #pulseaudio.source-muted,
        #backlight,
        #battery {
          color: #d8dee9;
          border: 1px solid #d8dee9;
          background-color: #2e3440;
          padding: 2px 6px;
        }

        #cpu.warning,
        #memory.warning,
        #battery.warning {
          color: #ebcb8b;
          border: 1px solid #ebcb8b;
          background-color: #2e3440;
          padding: 2px 6px;
        }

        #pulseaudio,
        #cpu.critical,
        #memory.critical,
        #battery.critical {
          color: #bf616a;
          border: 1px solid #bf616a;
          background-color: #2e3440;
          padding: 2px 6px;
        }

        #workspaces {
          padding: 2px;
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
