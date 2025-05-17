{pkgs, ...}: {
  imports = [
    ./programs/fastfetch.nix
    ./programs/tmux.nix
    ./programs/btop.nix
    ./programs/zsh.nix
    ./programs/git.nix

    ./programs/nvim
  ];

  programs.home-manager.enable = true;

  home.username = "kubujuss";
  home.homeDirectory = "/home/kubujuss";
  home.packages = with pkgs; [
    ripgrep
    unzip
    btop
    glow
    tree
    zip
    bat
    fzf
    fd
  ];

  home.stateVersion = "24.05";
}
