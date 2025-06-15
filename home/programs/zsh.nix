{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;

    shellAliases = {
      rm = "rm -v";
      cp = "cp -v";
      mv = "mv -v";

      ls = "ls --color";
      la = "la -A --color";
      ll = "ls -lAh --color";

      at = "source .venv/bin/activate";
      jl = ".venv/bin/jupyter-lab";
      nb = ".venv/bin/jupyter-notebook";

      hs = "bluetoothctl connect 14:3F:A6:DA:AA:00";
      wj = "ssh alajaam.risuhunnik.xyz /usr/sbin/etherwake -i eth0 9C:6B:00:13:EE:B0";
    };

    completionInit =
      # bash
      ''
        autoload -Uz compinit && compinit
        zstyle ":completion:*" menu yes select
        zstyle ":completion:*" special-dirs true
        zstyle ":completion::complete:*" gain-privileges 1
      '';

    initContent =
      # bash
      ''
        setopt list_packed
        setopt no_case_glob no_case_match

        precmd_functions+=(_prompt)
        function _prompt() {
          items=""
          branch=$(git symbolic-ref --short HEAD 2> /dev/null)
          venv=$(echo $VIRTUAL_ENV_PROMPT | tr -d '()')

          [[ -n $venv ]] && items="%F{3}$venv%f"
          [[ -n $branch ]] && items="$items%F{5}$branch%f "

          PROMPT="%F{2}%m%f %F{4}%~%f $items"
        }
      '';
  };
}
