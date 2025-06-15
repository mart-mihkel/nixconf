{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    extraConfig =
      # tmux
      ''
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"

        set -g status-style "fg=default bg=default"
        set -g pane-active-border-style "fg=default"
        set -g pane-border-style "fg=default"

        bind v split-window -h -c "#{pane_current_path}"
        bind s split-window -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
  };
}
