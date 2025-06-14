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

  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "et";
  console.font = "ter-u20n";
  console.earlySetup = true;
  console.packages = with pkgs; [terminus_font];

  users.users.kubujuss.shell = pkgs.zsh;
  users.users.kubujuss.createHome = true;
  users.users.kubujuss.isNormalUser = true;
  users.users.kubujuss.extraGroups = ["wheel" "networkmanager"];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    openssl
    cacert
    tmux
    curl
    wget
    git
    vim
  ];
}
