{pkgs, ...}: {
  nix = {
    gc.automatic = true;
    settings = {
      trusted-users = ["kubujuss"];
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
  console.keyMap = "et";

  users.users.kubujuss = {
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
  };

  programs = {
    git = {
      enable = true;
      config = {
        pull.rebase = true;
        core.editor = "vim";
        init.defaultBranch = "main";
        url."git@github.com:".insteadOf = ["gh:"];
        user = {
          name = "mart-mihkel";
          email = "mart.mihkel.aun@gmail.com";
        };
      };
    };

    tmux = {
      enable = true;
      baseIndex = 1;
    };
  };

  virtualisation.docker.enable = true;

  environment = {
    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
    };

    systemPackages = with pkgs; [
      openssl
      cacert
      tmux
      vim
      git
    ];
  };
}
