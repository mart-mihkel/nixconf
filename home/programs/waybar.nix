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

    style = ''
      * {
        all: unset;

        font-family: "cozette";
        font-size: 12px;

        color: #d8dee9;
      }

      #workspaces button {
        padding: 0 2px;
        opacity: 0.6;
      }

      #workspaces button.active {
        opacity: 1;
      }

      tooltip,
      #tray menu {
        background-color: #2e3440;
        border: 1px solid #d8dee9;
        padding: 2px 4px;
      }

      #workspaces,
      #window,
      #tray,
      #mpris,
      #clock,
      #cpu,
      #memory,
      #network,
      #bluetooth,
      #pulseaudio,
      #backlight,
      #battery {
        background-color: #2e3440;
        border: 1px solid #d8dee9;
        padding: 2px 4px;
      }

      #cpu.warning,
      #memory.warning,
      #battery.warning {
        border: 1px solid #ebcb8b;
        color: #ebcb8b;;
      }

      #workspaces button.urgent,
      #cpu.critical,
      #memory.critical,
      #battery.critical {
        border: 1px solid #bf616a;
        color: #bf616a;
      }
    '';
  };
}
