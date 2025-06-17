{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    extraConfig =
      # tmux
      ''
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -g default-terminal "tmux-256color"
        set -g status-style "fg=default bg=default"
        set -g pane-active-border-style "fg=default"
        set -g pane-border-style "fg=default"
      '';
  };
}
