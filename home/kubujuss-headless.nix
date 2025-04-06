{pkgs, ...}: {
  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        gnumake
        python3
        ripgrep
        nodejs
        cargo
        gcc
        fd
      ];
    };

    tmux = {
      enable = true;
      mouse = true;
      baseIndex = 1;
      keyMode = "vi";
      extraConfig = ''
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"

        set -g pane-active-border-style "fg=default"
        set -g pane-border-style "fg=default"

        set -g status-style "fg=default bg=default"
        set -g status-right-length 100
        set -g status-left-length 100

        bind v split-window -h -c "#{pane_current_path}"
        bind s split-window -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
    };

    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;

      autosuggestion = {
        enable = true;
        strategy = ["completion" "history"];
      };

      shellAliases = {
        rm = "rm -v";
        ls = "ls --color";
        l = "ls -A --color";

        at = "source .venv/bin/activate";
        jl = ".venv/bin/jupyter-lab";
        nb = ".venv/bin/jupyter-notebook";

        hs = "bluetoothctl connect 14:3F:A6:DA:AA:00";
        wj = "ssh alajaam.risuhunnik.xyz wol --port=9 9C:6B:00:13:EE:B0";
      };

      completionInit = ''
        autoload -Uz compinit && compinit
        zstyle ":completion:*" menu yes select
        zstyle ":completion:*" special-dirs true
        zstyle ":completion::complete:*" gain-privileges 1
      '';

      initExtra = ''
        PROMPT="%F{4}%1~%f "
        precmd_functions+=(_rprompt)

        setopt list_packed
        setopt no_case_glob no_case_match

        function _rprompt() {
          items=""

          branch=$(git symbolic-ref --short HEAD 2> /dev/null)
          [[ -n $branch ]] && items="󰊢 $branch"
          [[ -n $SSH_TTY ]] && items="$items  %n@%M"

          RPROMPT="%F{8}$items%f"
        }
      '';
    };

    git = {
      enable = true;
      userName = "mart-mihkel";
      userEmail = "mart.mihkel.aun@gmail.com";

      aliases = {
        st = "status";
        sw = "switch";
        sc = "switch -c";
        ci = "commit";
        ca = "commit -a";
        ri = "rebase -i";
      };

      extraConfig = {
        core.editor = "nvim";
        pull.rebase = true;
      };
    };
  };

  home = {
    username = "kubujuss";
    homeDirectory = "/home/kubujuss";

    file.".config/nvim".source = ../conf/nvim;

    packages = with pkgs; [
      ripgrep
      tree
      fzf
      jq
      fd
      uv

      tty-clock
      fastfetch
      neofetch
      cowsay
      pipes
      btop
      cava
    ];

    stateVersion = "24.05";
  };
}
