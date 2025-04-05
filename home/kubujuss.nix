{pkgs, ...}: let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    rev = "sha1-CtZ4WFmnq4Ity3ziAwiZ1yYN3DQ=";
  };
in {
  programs = {
    home-manager.enable = true;
    tmux.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        ripgrep
        nodejs
        fd
      ];
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

    file.".config/nvim".source = conf.outPath + "/.config/nvim";
    file.".config/tmux".source = conf.outPath + "/.config/tmux";

    file.".config/alacritty".source = conf.outPath + "/.config/alacritty";
    file.".config/picom".source = conf.outPath + "/.config/picom";
    file.".config/dunst".source = conf.outPath + "/.config/dunst";
    file.".config/rofi".source = conf.outPath + "/.config/rofi";
    file.".config/i3".source = conf.outPath + "/.config/i3";

    packages = with pkgs; [
      i3
      feh
      maim
      picom
      dunst
      gammastep
      alacritty
      autotiling

      rofi
      rofi-emoji

      xclip
      xdotool
      xlockmore

      bluetui
      playerctl
      pulsemixer
      brightnessctl
      networkmanager

      jq
      uv
      fd
      fzf
      ripgrep

      btop
      cava
      pipes
      neofetch
      fastfetch
      tty-clock

      noto-fonts
      nerd-fonts.jetbrains-mono
    ];

    stateVersion = "24.05";
  };
}
