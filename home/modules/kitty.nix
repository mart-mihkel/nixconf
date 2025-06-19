{
  programs.kitty = {
    enable = true;
    font = {
      size = 13;
      name = "JetbrainsMono Nerd Font";
    };
    settings = {
      confirm_os_window_close = 0;
      disable_ligatures = "always";
      enable_audio_bell = "no";
      copy_on_select = "yes";
      editor = "nvim";
    };
  };
}
