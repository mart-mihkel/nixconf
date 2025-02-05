{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" ];

    shellAliases = {
      neofetch = "fastfetch";

      activate = ". .venv/bin/activate";
      notebook = ". .venv/bin/activate && jupyter-notebook";

      headset = "bluetoothctl connect 14:3F:A6:DA:AA:00";
      wake-jaam = "wol --port=9 9C:6B:00:13:EE:B0";
    };

    initExtra = ''
      PS1="\[\033[01;34m\]\W\[\033[00m\] "

      bind 'set completion-ignore-case on'
      bind 'set show-all-if-ambiguous on'
      bind 'TAB:menu-complete'
    '';
  };
}
