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
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      lua-language-server
      tree-sitter
      alejandra
      fastfetch
      ripgrep
      gnumake
      glow
      btop
      gcc
      nil
      bat
      fzf
      fd
    ];
  };

  programs = {
    git = {
      enable = true;
      config = {
        user.name = "mart-mihkel";
        user.email = "mart.mihkel.aun@gmail.com";
        pull.rebase = true;
        core.editor = "nvim";
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [ "gh:" ];
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
        la = "la -A --color";
        ll = "ls -lAh --color";

        at = "source .venv/bin/activate";
        jl = ".venv/bin/jupyter-lab";
        nb = ".venv/bin/jupyter-notebook";

        neofetch = "fastfetch --config neofetch";
      };

      shellInit =
        # bash
        ''
          precmd_functions+=(pprecmd)
          function pprecmd() {
          items=""
          branch=$(git symbolic-ref --short HEAD 2> /dev/null)
          [[ -n $VIRTUAL_ENV_PROMPT ]] && items="%F{3}%f "
          [[ -n $branch ]] && items="$items%F{5} $branch%f "
          PROMPT="%F{2}%n@%m%f:%F{4}%~%f $items"
          }

          function tm() {
          dir=$(fd -t=d -d=2 . ~ | fzf)
          [[ -z $dir ]] && return
          name=$(basename $dir | tr . _)
          tmux new-session -A -D -c $dir -s $name
          }

          zstyle ":completion:*" menu yes select
          zstyle ":completion:*" special-dirs true
          zstyle ":completion::complete:*" gain-privileges 1

          setopt list_packed
          setopt no_case_glob no_case_match
          '';
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
      withRuby = true;
      vimAlias = true;
    };

    tmux = {
      enable = true;
      baseIndex = 1;
      keyMode = "vi";
      extraConfig =
        # tmux
        ''
        set  -g mouse              on

        set -ag terminal-overrides ",xterm-256color:RGB"
        set  -g default-terminal   "tmux-256color"

        set  -g status-left-length 100
        set  -g status-right       ""

        bind % split-window -h -c  "#{pane_current_path}"
        bind \" split-window   -c  "#{pane_current_path}"
        bind c new-window      -c  "#{pane_current_path}"
        '';
    };
  };

  environment = {
    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
    };

    systemPackages = with pkgs; [
      cloudflared
      openssl
      cacert
      tmux
      curl
      wget
      tree
      git
      vim
      jq
    ];
  };
}
