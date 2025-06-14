{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;

    shellAliases = {
      rm = "rm -v";
      cp = "cp -v";
      mv = "mv -v";

      ls = "ls --color";
      ll = "ls -lAh --color";
      l = "ls -A --color";

      at = "source .venv/bin/activate";
      jl = ".venv/bin/jupyter-lab";
      nb = ".venv/bin/jupyter-notebook";

      hs = "bluetoothctl connect 14:3F:A6:DA:AA:00";
      wj = "ssh alajaam.risuhunnik.xyz wakeonlan 9C:6B:00:13:EE:B0";
    };

    completionInit = ''
      autoload -Uz compinit && compinit
      zstyle ":completion:*" menu yes select
      zstyle ":completion:*" special-dirs true
      zstyle ":completion::complete:*" gain-privileges 1
    '';

    initContent = ''
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
