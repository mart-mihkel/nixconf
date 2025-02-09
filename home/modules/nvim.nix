{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    ref = "minimal";
    rev = "a38c18591b6250ce3db01bc7735fa56541138a7a";
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
