{pkgs, ...}: {
  nix.gc.automatic = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.extra-substituters = [
    "https://cuda-maintainers.cachix.org"
    "https://nix-community.cachix.org"
  ];

  nix.settings.extra-trusted-public-keys = [
    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  networking.hosts = {
    "192.168.10.2" = ["jaam"];
    "192.168.10.3" = ["dell"];
    "192.168.10.4" = ["alajaam"];
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
    shell = pkgs.zsh;
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"];
  };

  virtualisation.docker.enable = true;

  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  environment.variables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
  };

  environment.systemPackages = with pkgs; [
    devcontainer
    gnumake
    openssl
    sqlite
    nodejs
    cacert
    cargo
    clang
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
}
