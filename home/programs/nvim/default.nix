{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      python3
      ripgrep
      fd
    ];
  };

  home.file.".config/nvim".source = ./.;
}
