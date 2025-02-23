{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    ref = "minimal";
    rev = "sha1-NCR7/bRqt3ap2rgn0Mf38kHU9Gw=";
  };
in
{
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
