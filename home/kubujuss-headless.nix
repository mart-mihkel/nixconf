{pkgs, ...}: {
  imports = [
    ./modules/tmux.nix
    ./modules/btop.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/vim.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "kubujuss";
    homeDirectory = "/home/kubujuss";
    packages = with pkgs; [
      cloudflared
      fastfetch
      ripgrep
      glow
      tree
      bat
      fzf
      fd
    ];

    stateVersion = "24.05";
  };
}
