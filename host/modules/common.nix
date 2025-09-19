{pkgs, ...}: {
  nix = {
    gc.automatic = true;
    settings = {
      trusted-users = ["nixos"];
      experimental-features = ["nix-command" "flakes"];
    };
  };

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";
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

    tmux = {
      enable = true;
      baseIndex = 1;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
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

  virtualisation.docker.enable = true;

  environment = {
    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
    };

    systemPackages = with pkgs; [openssl cacert];
  };
}
