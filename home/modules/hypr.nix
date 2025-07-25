{pkgs, ...}: let
  hyprcfg = ''
    general {
        gaps_in = 16
        gaps_out = 64
        border_size = 2

        col.active_border = rgb(d8dee9)
        col.inactive_border = rgb(4c566a)
    }

    decoration {
        rounding = 8

        shadow {
            range = 32
            color = rgba(3b4252cc)
            color_inactive = rgba(2e3440cc)
        }
    }

    animations {
        animation = global, 1, 4, default
        animation = layers, 1, 4, default, slide
    }

    input {
        kb_layout = ee
        kb_variant = nodeadkeys

        repeat_rate = 32
        repeat_delay = 256

        follow_mouse = 1
        sensitivity = 0

        touchpad {
            natural_scroll = false
        }
    }

    gestures {
        workspace_swipe = true
        workspace_swipe_invert = true
    }

    cursor {
        inactive_timeout = 1
    }

    misc {
        disable_hyprland_logo = true
    }

    env = XDG_SCREENSHOTS_DIR,~/Pictures/screenshots

    monitor = , preferred, auto, 1, mirror, edp-1

    layerrule = blur, notifications

    bindm = SUPER, mouse:273, resizewindow
    bindm = SUPER, mouse:272, movewindow

    bind = , XF86MonBrightnessDown, exec, brightnessctl s 2%-
    bind = , XF86MonBrightnessUp,   exec, brightnessctl s +2%

    bind = , XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
    bind = , XF86AudioRaiseVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
    bind = , XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bind = , XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

    bind = , XF86AudioPause,        exec, playerctl play-pause
    bind = , XF86AudioPlay,         exec, playerctl play-pause
    bind = , XF86AudioPrev,         exec, playerctl previous
    bind = , XF86AudioNext,         exec, playerctl next

    bind = CTRL, Print,    exec, grimshot --notify savecopy screen
    bind = ALT , Print,    exec, grimshot --notify savecopy window
    bind=      , Print,    exec, grimshot --notify savecopy area

    bind = SUPER SHIFT, R, exec, hyprctl reload
    bind = SUPER SHIFT, C, exec, hyprlock
    bind = SUPER,       R, exec, tofi-drun
    bind = SUPER,       Q, exec, foot

    bind = SUPER SHIFT, E, exit,
    bind = SUPER,       V, togglefloating,
    bind = SUPER,       C, killactive,
    bind = SUPER,       F, fullscreen,
    bind = SUPER,       P, pseudo,

    bind = SUPER, H, movefocus, l
    bind = SUPER, L, movefocus, r
    bind = SUPER, K, movefocus, u
    bind = SUPER, J, movefocus, d

    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10

    bind = SUPER SHIFT, 1, movetoworkspacesilent, 1
    bind = SUPER SHIFT, 2, movetoworkspacesilent, 2
    bind = SUPER SHIFT, 3, movetoworkspacesilent, 3
    bind = SUPER SHIFT, 4, movetoworkspacesilent, 4
    bind = SUPER SHIFT, 5, movetoworkspacesilent, 5
    bind = SUPER SHIFT, 6, movetoworkspacesilent, 6
    bind = SUPER SHIFT, 7, movetoworkspacesilent, 7
    bind = SUPER SHIFT, 8, movetoworkspacesilent, 8
    bind = SUPER SHIFT, 9, movetoworkspacesilent, 9
    bind = SUPER SHIFT, 0, movetoworkspacesilent, 10

    exec-once = hyprpaper
    exec-once = hypridle
    exec-once = waybar
    exec-once = dunst
  '';

  lockcfg = ''
    general {
        hide_cursor = true
    }

    background {
        monitor =

        path = screenshot

        blur_passes = 2
        blur_size = 4
    }

    input-field {
        monitor =

        rounding = 8
        size = 512, 128
        outline_thickness = 2

        font_family = JetbrainsMono Nerd Font
        font_color = rgb(eceff4)

        inner_color = rgba(2e344000)
        outer_color = rgba(eceff400)
        check_color = rgba(5e81ac80)
        fail_color = rgba(d0877080)

        fade_on_empty = true

        position = 0, 0
        halign = center
        valign = center
    }

    label {
        monitor =

        text = cmd[update:1000] date +"%A, %B %d"
        color = rgb(eceff4)

        font_family = JetbrainsMono Nerd Font
        font_size = 28

        position = 0, 300
        halign = center
        valign = center
    }

    label {
        monitor =

        text = cmd[update:1000] date +"%H:%M"
        color = rgb(eceff4)

        font_family = JetbrainsMono Nerd Font
        font_size = 100

        position = 0, 200
        halign = center
        valign = center
    }
  '';

  papercfg = ''
    preload = ~/Pictures/walls/opattern.png
    wallpaper = ,~/Pictures/walls/opattern.png
  '';
in {
  programs.hyprlock.enable = true;
  services.hyprpaper.enable = true;

  home = {
    file = {
      ".config/hypr/hyprland.conf".text = hyprcfg;
      ".config/hypr/hyprlock.conf".text = lockcfg;
      ".config/hypr/hyprpaper.conf".text = papercfg;
    };

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      sway-contrib.grimshot
      brightnessctl
      wl-clipboard
      wireplumber
      xfce.thunar
      hyprland
      wtype
      tofi
      foot
    ];
  };
}
