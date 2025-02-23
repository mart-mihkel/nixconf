{
  programs.tmux = {
    enable = true;
    mouse = true;

    keyMode = "vi";
    baseIndex = 1;

    extraConfig = ''
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set -g mode-style "fg=color0 bg=color16"
      set -g status-style "fg=color16 bg=default"
      set -g status-right "#(whoami)@#H"
    '';
  };
}
