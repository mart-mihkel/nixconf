{pkgs, ...}: {
  nix = {
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

    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  networking.hosts = {
    "192.168.10.2" = ["jaam"];
    "192.168.10.3" = ["dell"];
    "192.168.10.4" = ["alajaam"];
  };

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "ter-u20n";
    keyMap = "et";
    packages = with pkgs; [terminus_font];
  };

  virtualisation.docker.enable = true;

  users.users = {
    kubujuss = {
      shell = pkgs.zsh;
      createHome = true;
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker"];
    };
  };

  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      devcontainer
      gnumake
      openssl
      nodejs
      cacert
      cargo
      cmake
      tmux
      curl
      wget
      gcc
      wol
      git
      vim
      jq
      uv
    ];

    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    };
  };
}
