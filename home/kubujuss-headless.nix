{pkgs, ...}: {
  imports = [
    ./modules/btop.nix
    ./modules/git.nix
    ./modules/vim.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "kubujuss";
    homeDirectory = "/home/kubujuss";
    stateVersion = "24.05";
  };
}
