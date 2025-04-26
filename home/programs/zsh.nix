{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable = true;
      strategy = ["completion" "history"];
    };

    shellAliases = {
      rm = "rm -v";
      cp = "cp -v";
      mv = "mv -v";

      ls = "ls --color";
      l = "ls -A --color";

      at = "source .venv/bin/activate";
      jl = ".venv/bin/jupyter-lab";
      nb = ".venv/bin/jupyter-notebook";

      hs = "bluetoothctl connect 14:3F:A6:DA:AA:00";
      wj = "ssh alajaam.risuhunnik.xyz wol --port=9 9C:6B:00:13:EE:B0";
    };

    completionInit = ''
      autoload -Uz compinit && compinit
      zstyle ":completion:*" menu yes select
      zstyle ":completion:*" special-dirs true
      zstyle ":completion::complete:*" gain-privileges 1
    '';

    initContent = ''
      PROMPT="%F{4}%1~%f "
      precmd_functions+=(_rprompt)

      setopt list_packed
      setopt no_case_glob no_case_match

      function _rprompt() {
        items=""

        branch=$(git symbolic-ref --short HEAD 2> /dev/null)
        [[ -n $branch ]] && items="󰊢 $branch"
        [[ -n $SSH_TTY ]] && items="$items  %n@%M"

        RPROMPT="%F{8}$items%f"
      }
    '';
  };
}
