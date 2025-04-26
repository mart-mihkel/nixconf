{pkgs, ...}: {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      gaps.inner = 8;
      floating.modifier = "Mod4";
      defaultWorkspace = "workspace number 1";

      bars = [];
      window.titlebar = false;

      colors = {
        focused = {
          text = "#d8dee9";
          border = "#4c566a";
          indicator = "#4c566a";
          background = "#4c566a";
          childBorder = "#4c566a";
        };

        unfocused = {
          text = "#d8dee9";
          border = "#2e3440";
          indicator = "#2e3440";
          background = "#2e3440";
          childBorder = "#2e3440";
        };
      };

      keybindings = {
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl s 2%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl s +2%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -2%";
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +2%";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioPause" = "exec --no-startup-id playerctl play-pause";
        "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
        "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
        "XF86AudioNext" = "exec --no-startup-id playerctl next";
        "Mod4+period" = "exec --no-startup-id rofi -show emoji -display-emoji '󰀖 '";
        "Mod4+r" = "exec --no-startup-id rofi -show drun -display-drun '󱈆 '";
        "Mod4+n" = "exec --no-startup-id playerctl -a pause & xlock -mode blank";
        "Mod4+s" = "exec --no-startup-id ~/.config/i3/screenshot.sh";
        "Mod4+w" = "exec --no-startup-id ~/.config/i3/wallpaper.sh";
        "Mod4+q" = "exec --no-startup-id kitty -1";

        "Mod4+f" = "fullscreen toggle";
        "Mod4+v" = "floating toggle";
        "Mod4+c" = "kill";
        "Mod4+m" = "exit";

        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";

        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";

        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";
        "Mod4+0" = "workspace number 10";

        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
        "Mod4+Shift+6" = "move container to workspace number 6";
        "Mod4+Shift+7" = "move container to workspace number 7";
        "Mod4+Shift+8" = "move container to workspace number 8";
        "Mod4+Shift+9" = "move container to workspace number 9";
        "Mod4+Shift+0" = "move container to workspace number 10";
      };

      startup = [
        {
          command = "--no-startup-id autotiling";
          always = true;
        }
        {command = "--no-startup-id feh --no-fehbg --bg-fill ~/.cache/wallpaper";}
        {command = "--no-startup-id gammastep -l 58.38:26.72 -t 6500:3000";}
        {command = "--no-startup-id polybar";}
        {command = "--no-startup-id picom";}
        {command = "--no-startup-id dunst";}
      ];
    };
  };

  home = {
    file = {
      ".config/i3/screenshot.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash

          stamp=$(date +%b%d-%H%M%S)
          name="$stamp.png"
          dir="$HOME/Pictures/screenshots"
          target="$dir/$name"

          mkdir --parents "$dir"

          maim -s | xclip -selection clipboard -t image/png
          xclip -selection clipboard -t image/png -o > "$target"

          dunstify -u low -I "$target" "Screenshot" "Saved as $name"
        '';
      };

      ".config/i3/wallpaper.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash

          wals="$HOME/git/wallpapers"
          pick="$wals/$(ls "$wals" | grep -E 'jpg|jpeg|png' | rofi -dmenu -p '󰥷 ')"

          if [[ "$pick" == "$wals/" ]]; then
              echo "No wallpaper selected"
              exit 1
          fi

          cp -f $pick ~/.cache/wallpaper
          feh --no-fehbg --bg-fill ~/.cache/wallpaper
        '';
      };

      ".xinitrc".text = ''
        setxkbmap -layout ee -variant nodeadkeys
        xset r rate 256 32

        export XDG_CURRENT_DESKTOP="i3"
        exec i3
      '';
    };

    packages = with pkgs; [
      brightnessctl
      autotiling
      gammastep
      xlockmore
      xdotool
      xclip
      maim
      feh
    ];
  };
}
