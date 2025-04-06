{pkgs, ...}: {
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
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

    keyMap = "et";

    packages = with pkgs; [terminus_font];
    font = "ter-u12n";
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
      openssl
      cacert
      tmux
      curl
      wget
      wol
      git
      vim
    ];

    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    };
  };
}
