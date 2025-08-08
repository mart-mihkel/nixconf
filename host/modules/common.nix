{pkgs, ...}: {
  nix = {
    gc.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      extra-substituters = [
        "https://cuda-maintainers.cachix.org"
        "https://nix-community.cachix.org"
      ];

      extra-trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "et";
    font = "ter-u20n";
    earlySetup = true;
    packages = with pkgs; [terminus_font];
  };

  users.users.kubujuss = {
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
  };

  programs = {
    git = {
      enable = true;
      config = {
        user.name = "mart-mihkel";
        user.email = "mart.mihkel.aun@gmail.com";
        pull.rebase = true;
        core.editor = "vim";
        init.defaultBranch = "main";
        url."git@github.com:".insteadOf = ["gh:"];
      };
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;

      shellAliases = {
        rm = "rm -v";
        cp = "cp -v";
        mv = "mv -v";
        ls = "ls --color";
        grep = "grep --color";
        ll = "ls -lAh --color";
        neofetch = "fastfetch --config neofetch";
      };

      shellInit = ''
        precmd_functions+=(pprecmd)

        function pprecmd() {
          items=""
          branch=$(git symbolic-ref --short HEAD 2> /dev/null)
          [[ -n $VIRTUAL_ENV_PROMPT ]] && items="%F{3}%f "
          [[ -n $branch ]] && items="$items%F{5} $branch%f "
          PROMPT="%F{2}%n@%m%f:%F{4}%~%f $items"
        }

        function tm() {
          dir=$(fdfind -t=d -d=2 . ~ | fzf --preview 'tmux ls' --preview-window=down,25%)
          [[ -n $dir ]] && tmux new-session -A -D -c $dir -s $(basename $dir | tr . _)
        }

        zstyle ":completion:*" menu yes select
        zstyle ":completion:*" special-dirs true
        zstyle ":completion::complete:*" gain-privileges 1

        setopt list_packed
        setopt no_case_glob
        setopt no_case_match
      '';
    };

    tmux = {
      enable = true;
      baseIndex = 1;
      keyMode = "vi";
      extraConfig = ''
        set  -g mouse              on

        set -ag terminal-overrides ",xterm-256color:RGB"
        set  -g default-terminal   "tmux-256color"

        set  -g status-style       "fg=default bg=default"
        set  -g status-right       ""
        set  -g status-left-length 128

        bind % split-window -h -c  "#{pane_current_path}"
        bind \" split-window   -c  "#{pane_current_path}"
        bind c new-window      -c  "#{pane_current_path}"
      '';
    };
  };

  virtualisation.docker.enable = true;

  environment = {
    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
    };

    systemPackages = with pkgs; [
      cloudflared
      fastfetch
      nettools
      openssl
      gnumake
      ripgrep
      cacert
      unzip
      ninja
      meson
      cmake
      tmux
      curl
      wget
      tree
      btop
      zip
      vim
      gcc
      bat
      fzf
      fd
      jq
    ];
  };
}
