{pkgs, ...}: let
  i3cfg = ''
    set $wallpaper ~/Pictures/walls/opattern.png
    set $refresh pkill -SIGRTMIN+1 i3blocks

    tiling_drag modifier
    floating_modifier Mod4
    focus_follows_mouse yes

    gaps inner 0
    gaps outer 0

    default_border          pixel 0
    default_floating_border pixel 0

    bar {
        status_command i3blocks
        font           pango:cozette 8

        colors {
            background #2e3440
            separator  #4c566a
            statusline #d8dee9

            urgent_workspace   #2e3440 #2e3440 #bf616a
            focused_workspace  #2e3440 #2e3440 #d8dee9
            active_workspace   #2e3440 #2e3440 #4c566a
            inactive_workspace #2e3440 #2e3440 #4c566a
        }
    }

    bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl s 2%- && $refresh
    bindsym XF86MonBrightnessUp   exec --no-startup-id brightnessctl s +2% && $refresh

    bindsym XF86AudioLowerVolume  exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && $refresh
    bindsym XF86AudioRaiseVolume  exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && $refresh
    bindsym XF86AudioMicMute      exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && $refresh
    bindsym XF86AudioMute         exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && $refresh

    bindsym XF86AudioPause        exec --no-startup-id playerctl play-pause
    bindsym XF86AudioPlay         exec --no-startup-id playerctl play-pause
    bindsym XF86AudioPrev         exec --no-startup-id playerctl previous
    bindsym XF86AudioNext         exec --no-startup-id playerctl next

    bindsym Control+Print         exec --no-startup-id maim | xclip -selection clipboard -t image/png -i
    bindsym Mod1+Print            exec --no-startup-id maim -w $(xdotool getactivewindow) | xclip -selection clipboard -t image/png -i
    bindsym Print                 exec --no-startup-id maim -s | xclip -selection clipboard -t image/png -i

    bindsym Mod4+Shift+c          exec --no-startup-id i3lock -n -u -i $wallpaper
    bindsym Mod4+r                exec --no-startup-id rofi -show drun
    bindsym Mod4+q                exec --no-startup-id alacritty
    bindsym Mod4+e                exec --no-startup-id thunar

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

    exec --no-startup-id feh --no-fehbg --bg-fill $wallpaper
    exec --no-startup-id autotiling
    exec --no-startup-id picom
    exec --no-startup-id dunst
  '';

  i3b = ''
    [net]
    command=[ $(cat /sys/class/net/wlp2s0/operstate) = "down" ] && echo "net off" || echo "net $(iw dev wlp2s0 link | grep 'dBm$' | grep -Eoe '-[0-9]{2}' | awk '{print  ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')%"
    interval=5

    [vol]
    command=wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "vol off" || echo "vol $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')%"
    interval=once
    signal=1

    [bkl]
    command=echo "bkl $(brightnessctl -m | awk -F , '{print $4}')"
    interval=once
    signal=1

    [bat]
    command=echo "bat $(cat /sys/class/power_supply/BAT0/capacity)%"
    interval=60

    [date]
    command=date +"%b-%d %H:%M" | tr '[:upper:]' '[:lower:]'
    interval=1
  '';

  xinitrc = ''
    TOUCHPAD="$(xinput list --name-only | grep -i touchpad)"

    xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 1

    xset r rate 256 32
    xset m 0 0

    setxkbmap -layout ee -variant nodeadkeys

    exec i3
  '';
in {
  home = {
    file = {
      ".config/i3blocks/config".text = i3b;
      ".config/i3/config".text = i3cfg;
      ".xinitrc".text = xinitrc;
    };

    packages = with pkgs; [
      (pkgs.rofi.override {plugins = [pkgs.rofi-emoji];})
      nerd-fonts.jetbrains-mono
      brightnessctl
      wireplumber
      xfce.thunar
      noto-fonts
      autotiling
      alacritty
      playerctl
      i3blocks
      cozette
      xdotool
      i3lock
      xclip
      maim
      feh
      i3
    ];
  };
}
