{pkgs, ...}: {
  services.polybar = {
    enable = true;
    script = "polybar bar &";

    settings = {
      settings = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };

      "bar/status" = {
        width = "100%";

        foreground = "#d8dee9";
        background = "#002e3440";

        padding = "2px";
        module-margin = "8px";

        font-0 = "JetbrainsMono Nerd Font:size=10:weight=bold";

        modules-left = "workspaces";
        modules-right = "network bluetooth audio backlight battery date";

        enable-ipc = true;
      };

      "module/workspaces" = {
        type = "internal/i3";

        index-sort = "true";

        format = "<label-state>";

        label-focused = "%index%";
        label-focused-padding = "2px";

        label-unfocused = "%index%";
        label-unfocused-foreground = "#4c566a";
        label-unfocused-padding = "2px";
      };

      "module/date" = {
        type = "internal/date";

        date = "%A, %B-%d";
        time = "%H:%M";

        label = "󰃰 %date% %time%";
      };

      "module/network" = {
        type = "internal/network";

        interface-type = "wireless";

        format-connected = "<label-connected> <ramp-signal>";

        label-connected = "%signal%%";
        label-disconnected = "󰤮";

        ramp-signal-0 = "󰤯";
        ramp-signal-1 = "󰤟";
        ramp-signal-2 = "󰤢";
        ramp-signal-3 = "󰤥";
        ramp-signal-4 = "󰤨";
      };

      "module/bluetooth" = {
        type = "custom/script";
        exec = "bluetoothctl info | grep -q 'Connected' && echo '󰂱' || echo ''";
      };

      "module/audio" = {
        type = "internal/pulseaudio";

        format-volume = "<label-volume> <ramp-volume>";
        format-muted = "<label-muted>";

        label-volume = "%percentage%%";
        label-muted = "󰖁 %percentage%%";

        ramp-volume-0 = "󰕿";
        ramp-volume-1 = "󰖀";
        ramp-volume-2 = "󰕾";
      };

      "module/backlight" = {
        type = "internal/backlight";

        format = "<label> <ramp>";
        label = "%percentage%%";

        ramp-0 = "󰃞";
        ramp-1 = "󰃟";
        ramp-2 = "󰃠";
      };

      "module/battery" = {
        type = "internal/battery";

        format-charging = "<label-discharging> <ramp-capacity>";
        format-discharging = "<label-discharging> <ramp-capacity>";
        format-full = "<label-full> <ramp-capacity>";

        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "%percentage%";

        ramp-capacity-0 = "󰁺";
        ramp-capacity-1 = "󰁻";
        ramp-capacity-2 = "󰁼";
        ramp-capacity-3 = "󰁽";
        ramp-capacity-4 = "󰁾";
        ramp-capacity-5 = "󰁿";
        ramp-capacity-6 = "󰂀";
        ramp-capacity-7 = "󰂁";
        ramp-capacity-8 = "󰂂";
        ramp-capacity-9 = "󰁹";
      };
    };

    package = pkgs.polybar.override {
      pulseSupport = true;
      i3Support = true;
    };
  };
}
