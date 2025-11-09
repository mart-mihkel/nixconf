{pkgs, ...}: {
  nix = {
    gc.automatic = true;
    settings = {
      trusted-users = ["nixos"];
      experimental-features = ["nix-command" "flakes"];
    };
  };

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_DK.UTF-8";
  console.keyMap = "et";

  users.users.nixos = {
    shell = pkgs.zsh;
    createHome = true;
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = ["wheel" "docker"];
  };

  programs = {
    vim.enable = true;
    direnv.enable = true;

    tmux = {
      enable = true;
      baseIndex = 1;
    };

    bash = {
      completion.enable = true;
      shellInit = ''
        bind '"\t": menu-complete'
        bind "set show-all-if-ambiguous on"
        bind "set completion-ignore-case on"
        bind "set menu-complete-display-prefix on"
      '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      shellAliases = {
        rm = "rm -v";
        cp = "cp -v";
        mv = "mv -v";
      };

      shellInit = ''
        zstyle ":completion:*" menu yes select
        zstyle ":completion::complete:*" gain-privileges 1
      '';
    };

    git = {
      enable = true;
      config = {
        pull.rebase = true;
        core.editor = "vim";
        user = {
          name = "mart-mihkel";
          email = "mart.mihkel.aun@gmail.com";
        };
      };
    };
  };

  zramSwap.enable = true;
  virtualisation.docker.enable = true;

  environment = {
    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
    };

    systemPackages = with pkgs; [
      openssl
      ripgrep
      gnumake
      cacert
      unzip
      wget
      glow
      btop
      tree
      gcc
      zip
      bat
      fzf
      fd
      jq
      uv
    ];
  };
}
