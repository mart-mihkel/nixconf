let
  swaycfg = ''
    gaps inner 12

    floating_modifier Mod4
    focus_follows_mouse yes

    default_border none
    default_floating_border none

    input type:keyboard {
        xkb_layout ee
        xkb_variant nodeadkeys
        repeat_rate 32
        repeat_delay 256
    }

    input type:touchpad tap enabled

    output * background ~/Pictures/walls/flowers.png fill

    bindsym XF86MonBrightnessDown exec brightnessctl s 2%-
    bindsym XF86MonBrightnessUp exec brightnessctl s +2%
    bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
    bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
    bindsym XF86AudioMicMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindsym XF86AudioPause exec playerctl play-pause
    bindsym XF86AudioPlay exec playerctl play-pause
    bindsym XF86AudioPrev exec playerctl previous
    bindsym XF86AudioNext exec playerctl next
    bindsym Print+Control exec grimshot --notify savecopy screen
    bindsym Print+Mod1 exec grimshot --notify savecopy window
    bindsym Print exec grimshot --notify savecopy area

    bindsym Mod4+Shift+c exec swaylock -uei ~/Pictures/walls/debian.png
    bindsym Mod4+period exec tofi-emoji
    bindsym Mod4+r exec tofi-drun
    bindsym Mod4+q exec alacritty

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
    exec autotiling
    exec gammastep
    exec waybar
    exec dunst
  '';

  waybarcfg = ''
    {
      "spacing": 24,
      "modules-left": [
        "sway/workspaces",
        "tray"
      ],
      "modules-right": [
        "network",
        "bluetooth",
        "wireplumber",
        "backlight",
        "battery",
        "clock"
      ],
      "tray": {
        "icon-size": 12
      },
      "network": {
        "format-wifi": "net: {signalStrength}%",
        "format-ethernet": "net: eth",
        "format-disconnected": "net: off"
      },
      "bluetooth": {
        "format": "blu: off",
        "format-connected": "blu: con",
        "format-connected-battery": "blu: {device_battery_percentage}%"
      },
      "wireplumber": {
        "format": "vol: {volume}%",
        "format-muted": "vol: off"
      },
      "backlight": {
        "format": "bkl: {percent}%"
      },
      "battery": {
        "format": "bat: {capacity}%"
      }
    }
  '';

  waybarcss = ''
    * {
      all: unset;
      font-family: Jetbrains Mono Nerd Font;
      font-size: 12px;
    }

    #workspaces button {
      padding: 0 2px;
    }
  '';

  toficfg = ''
    font             = Jetbrains Mono Nerd Font
    font-size        = 10
    fuzzy-match      = true
    drun-launch      = true
    terminal         = foot
    result-spacing   = 25
    num-results      = 5
    width            = 100%
    height           = 100%
    padding-left     = 45%
    padding-top      = 35%
    outline-width    = 0
    border-width     = 0
    text-color       = #d8dee9
    selection-color  = #88c0d0
    background-color = #2e3440cc
  '';

  dunstrc = ''
    [global]
    font          = Jetbrains Mono Nerd Font 10
    format        = "%s\n%b"
    markup        = full
    alignment     = right
    icon_position = right
    width         = (0, 512)
    height        = (0, 256)
    offset        = (8, 8)
    min_icon_size = 64
    max_icon_size = 64
    frame_width   = 2
    foreground    = "#d8dee9"
    background    = "#2e3440"

    [urgency_low]
    frame_color   = "#eceff4"
    timeout       = 4

    [urgency_normal]
    frame_color   = "#ebcb8b"
    timeout       = 8

    [urgency_critical]
    frame_color   = "#bf616a"
    timeout       = 16
  '';

  alacrittycfg = ''
    [window]
    dynamic_padding = true

    [font]
    normal = { family = "JetBrains Mono Nerd Font" }
    size = 12.0
  '';
in {
  imports = [./kubujuss-headless.nix];

  programs = {
    tofi.enable = true;
    waybar.enable = true;
    alacritty.enable = true;
  };

  home = {
    file = {
      ".config/alacritty/alacritty.toml".text = alacrittycfg;
      ".config/waybar/config.jsonc".text = waybarcfg;
      ".config/waybar/style.css".text = waybarcss;
      ".config/dunst/dunstrc".text = dunstrc;
      ".config/sway/config".text = swaycfg;
      ".config/tofi/config".text = toficfg;
    };

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      brightnessctl
      wireplumber
      noto-fonts
      autotiling
      playerctl
      qdigidoc
      grimshot
      discord
      brave
      dunst
      sway
      vlc
    ];
  };
}
