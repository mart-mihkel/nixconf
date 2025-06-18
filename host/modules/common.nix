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
    packages = with pkgs; [
      fastfetch
      ripgrep
      glow
      btop
      bat
      fzf
      fd
    ];
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
