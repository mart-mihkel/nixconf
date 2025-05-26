{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 0;
      };

      decoration = {
        rounding = 0;
        blur.enabled = false;
        shadow.enabled = false;
      };

      animations.animation = [
        "global, 1, 2.5, default"
        "layers, 1, 2.5, default, slide"
      ];

      input = {
        kb_layout = "ee";
        kb_variant = "nodeadkeys";

        repeat_rate = 32;
        repeat_delay = 256;

        follow_mouse = 1;
        sensitivity = 0;

        touchpad.natural_scroll = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = true;
      };

      cursor.inactive_timeout = 1;
      misc.disable_hyprland_logo = true;

      # monitor = ", preferred, auto, 1";
      monitor = ", preferred, auto, 1, mirror, eDP-1";

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      bind = [
        "     , XF86MonBrightnessDown, exec, brightnessctl s 2%-"
        "     , XF86MonBrightnessUp  , exec, brightnessctl s +2%"
        "     , XF86AudioLowerVolume , exec, pactl set-sink-volume @DEFAULT_SINK@ -2%"
        "     , XF86AudioRaiseVolume , exec, pactl set-sink-volume @DEFAULT_SINK@ +2%"
        "     , XF86AudioMicMute     , exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        "     , XF86AudioMute        , exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        "     , XF86AudioPause       , exec, playerctl play-pause"
        "     , XF86AudioPlay        , exec, playerctl play-pause"
        "     , XF86AudioPrev        , exec, playerctl previous"
        "     , XF86AudioNext        , exec, playerctl next"
        "SUPER, code:60              , exec, rofi -show emoji -display-emoji '󰀖 '"
        "SUPER, R                    , exec, rofi -show drun -display-drun '󱈆 '"
        "SUPER, N                    , exec, playerctl -a pause & hyprlock"
        "SUPER, S                    , exec, ~/.config/hypr/screenshot.sh"
        "SUPER, W                    , exec, ~/.config/hypr/wallpaper.sh"
        "SUPER, Q                    , exec, foot"

        "SUPER, V, togglefloating,"
        "SUPER, F, fullscreen,"
        "SUPER, C, killactive,"
        "SUPER, P, pseudo,"
        "SUPER, M, exit,"

        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        "SUPER, Tab, cyclenext,"
        "SUPER, Tab, bringactivetotop,"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER SHIFT, 9, movetoworkspacesilent, 9"
        "SUPER SHIFT, 0, movetoworkspacesilent, 10"
      ];

      exec-once = [
        "gammastep -l 58.38:26.72 -t 6500:3000 -m wayland"
        "wayland-pipewire-idle-inhibit"
        "hyprpaper"
        "hypridle"
        "waybar"
        "dunst"
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 2;
          blur_size = 4;
        }
      ];

      input-field = [
        {
          monitor = "";

          rounding = 0;
          size = "512, 128";
          outline_thickness = 0;

          font_family = "JetbrainsMono Nerd Font";
          font_color = "rgb(eceff4)";

          inner_color = "rgba(2e344000)";
          outer_color = "rgba(eceff400)";
          check_color = "rgba(5e81ac80)";
          fail_color = "rgba(d0877080)";

          fade_on_empty = true;

          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";

          text = "cmd[update:1000] date +'%A, %B %d'";
          color = "rgb(eceff4)";

          font_family = "JetbrainsMono Nerd Font";
          font_size = 28;

          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";

          text = "cmd[update:1000] date +'%H:%M'";
          color = "rgb(eceff4)";

          font_family = "JetbrainsMono Nerd Font";
          font_size = 100;

          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "playerctl -a pause";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 450;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    hyprpaper = {
      enable = true;
      settings = {
        preload = ["~/.cache/wallpaper"];
        wallpaper = [",~/.cache/wallpaper"];
      };
    };
  };

  home = {
    file = {
      ".config/hypr/screenshot.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash

          geometry=$(slurp)

          if [[ -z "$geometry" ]]; then
              echo "No geometry"
              exit 1
          fi

          stamp=$(date +%b%d-%H%M%S)
          name="$stamp.png"
          dir="$HOME/Pictures/screenshots"
          target="$dir/$name"

          mkdir --parents "$dir"

          grim -g "$geometry" - | wl-copy -t image/png
          wl-paste > "$target"

          dunstify -u low -I "$target" "Screenshot" "Saved as $name"
        '';
      };

      ".config/hypr/wallpaper.sh" = {
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
          hyprctl hyprpaper reload ,$pick
        '';
      };
    };

    packages = with pkgs; [
      wayland-pipewire-idle-inhibit
      brightnessctl
      wl-clipboard
      gammastep
      wtype
      slurp
      grim
    ];
  };
}
