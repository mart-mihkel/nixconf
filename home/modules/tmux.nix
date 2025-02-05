{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";

    extraConfig = ''
      setw -g mouse on
      setw -g mode-style "fg=black,bg=white"

      set -g status-left-length 32
      set -g status-right "#(whoami)@#H"
      set -g status-style "fg=black,bg=white"

      bind s split-window -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
