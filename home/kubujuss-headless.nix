{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    rev = "sha1-DdcQgDP0B6VIPWsroZxyIqqMoE4=";
    ref = "tty";
  };
in
{
  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      extraPackages = with pkgs; [ ripgrep ];
    };

    git = {
      enable = true;
      userName = "mart-mihkel";
      userEmail = "mart.mihkel.aun@gmail.com";

      extraConfig = {
        core.editor = "nvim";
        pull.rebase = true;
      };
    };
  };

  home = {
    username = "kubujuss";
    homeDirectory = "/home/kubujuss";

    file.".config/nvim".source = conf.outPath + "/.config/nvim";
    file.".tmux.conf".source = conf.outPath + "/.tmux.conf";

    file.".bash_profile".text = "[[ -f ~/.bashrc ]] && . ~/.bashrc";
    file.".bashrc".source = conf.outPath + "/.bashrc";

    stateVersion = "24.05";
  };
}
