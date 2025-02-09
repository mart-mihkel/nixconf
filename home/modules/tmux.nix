{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";

    extraConfig = ''
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set-window-option -g window-active-style "bg=terminal"
      set-window-option -g window-style "bg=terminal"

      set -g set-titles-string "#{pane_current_command}"
      set -g set-titles on

      set -g mode-style "fg=color16 bg=default"

      set -g message-style "fg=color16 bg=default"
      set -g message-command-style "fg=color16 bg=default"

      set -g pane-border-style "fg=color16"
      set -g pane-active-border-style "fg=color16"

      set -g status-style "fg=color16 bg=default"
      set -g status-right "#(whoami)@#h"
    '';
  };
}
