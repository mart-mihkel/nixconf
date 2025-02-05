{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    rev = "4d0b5e119217dee9e12f0c23bea689c0a646c5bf";
    name = "conf";
  };
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      ripgrep
    ];
  };

  home.file.".config/nvim".source = conf.outPath + "/.config/nvim";
}
