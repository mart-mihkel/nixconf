{
  imports = [
    ./modules/nvim.nix
    ./modules/bash.nix
    ./modules/tmux.nix
    ./modules/git.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "kubujuss";
    homeDirectory = "/home/kubujuss";
    stateVersion = "24.05";
  };
}
