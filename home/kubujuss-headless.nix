{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    rev = "sha1-Ot903jgViwm7f9oNW7BbkaBGLIo=";
  };
in
{
  imports = [ ./zsh.nix ./git.nix ];

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
      extraPackages = with pkgs; [ ripgrep ];
    };
  };

  home = {
    username = "kubujuss";
    homeDirectory = "/home/kubujuss";

    file.".config/nvim".source = conf.outPath + "/.config/nvim";
    file.".config/tmux".source = conf.outPath + "/.config/tmux";

    stateVersion = "24.05";
  };
}
