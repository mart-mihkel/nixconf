{pkgs, ...}: let
  cfg = ''
    gaps inner              12
    focus_follows_mouse     yes
    floating_modifier       Mod4
    default_border          none
    default_floating_border none

    input type:keyboard {
        xkb_layout  ee
        xkb_variant nodeadkeys

        repeat_rate  32
        repeat_delay 256
    }

    input type:touchpad tap enabled

    output eDP-1 background ~/Pictures/walls/flowers.png fill

    bindsym XF86MonBrightnessDown exec brightnessctl s 2%-
    bindsym XF86MonBrightnessUp   exec brightnessctl s +2%
    bindsym XF86AudioLowerVolume  exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
    bindsym XF86AudioRaiseVolume  exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
    bindsym XF86AudioMicMute      exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindsym XF86AudioMute         exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindsym XF86AudioPause        exec playerctl play-pause
    bindsym XF86AudioPlay         exec playerctl play-pause
    bindsym XF86AudioPrev         exec playerctl previous
    bindsym XF86AudioNext         exec playerctl next
    bindsym Print+Control         exec grimshot --notify savecopy screen
    bindsym Print+Mod1            exec grimshot --notify savecopy window
    bindsym Print                 exec grimshot --notify savecopy area

    bindsym Mod4+Shift+c          exec swaylock -uei ~/Pictures/walls/debian.png
    bindsym Mod4+period           exec tofi-emoji
    bindsym Mod4+r                exec tofi-drun
    bindsym Mod4+q                exec foot

    bindsym Mod4+f fullscreen toggle
    bindsym Mod4+v floating toggle
    bindsym Mod4+c kill

    bindsym Mod4+Shift+r reload
    bindsym Mod4+Shift+e exit

    bindsym Mod4+h focus left
    bindsym Mod4+j focus down
    bindsym Mod4+k focus up
    bindsym Mod4+l focus right

    bindsym Mod4+Shift+h move left
    bindsym Mod4+Shift+j move down
    bindsym Mod4+Shift+k move up
    bindsym Mod4+Shift+l move right

    bindsym Mod4+1 workspace number 1
    bindsym Mod4+2 workspace number 2
    bindsym Mod4+3 workspace number 3
    bindsym Mod4+4 workspace number 4
    bindsym Mod4+5 workspace number 5
    bindsym Mod4+6 workspace number 6
    bindsym Mod4+7 workspace number 7
    bindsym Mod4+8 workspace number 8
    bindsym Mod4+9 workspace number 9
    bindsym Mod4+0 workspace number 10

    bindsym Mod4+Shift+1 move container to workspace number 1
    bindsym Mod4+Shift+2 move container to workspace number 2
    bindsym Mod4+Shift+3 move container to workspace number 3
    bindsym Mod4+Shift+4 move container to workspace number 4
    bindsym Mod4+Shift+5 move container to workspace number 5
    bindsym Mod4+Shift+6 move container to workspace number 6
    bindsym Mod4+Shift+7 move container to workspace number 7
    bindsym Mod4+Shift+8 move container to workspace number 8
    bindsym Mod4+Shift+9 move container to workspace number 9
    bindsym Mod4+Shift+0 move container to workspace number 10

    exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    exec systemctl --user start xdg-desktop-portal xdg-desktop-portal-wlr
    exec autotiling
    exec gammastep
    exec waybar
    exec dunst
  '';
in {
  home = {
    file.".config/sway/config".text = cfg;

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      brightnessctl
      wireplumber
      noto-fonts
      autotiling
      playerctl
      grimshot
      sway
      tofi
    ];
  };
}
