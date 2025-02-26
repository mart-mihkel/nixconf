{ pkgs, ... }:

let
  conf = builtins.fetchGit {
    url = "https://github.com/mart-mihkel/conf.git";
    rev = "sha1-ujr/Z4sgFeTQ+pqc2oUliYeeDK0=";
    ref = "nix";
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [ ripgrep ];
  };

  home.file.".config/nvim".source = conf.outPath + "/.config/nvim";
}
