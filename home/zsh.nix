{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable = true;
      strategy = [ "completion" "history" ];
    };

    shellAliases = {
      ls = "ls --color";
      l = "ls -A --color";
    };

    completionInit = ''
      autoload -Uz compinit && compinit
      zstyle ":completion:*" menu yes select
      zstyle ":completion:*" special-dirs true
      zstyle ":completion::complete:*" gain-privileges 1
    '';

    initExtra = ''
      PROMPT="%F{4}%1~%f "
      precmd_functions+=(_rprompt)

      setopt list_packed
      setopt no_case_glob no_case_match

      bindkey "^w" forward-word
      bindkey "^b" backward-word
      bindkey "^k" up-line-or-history
      bindkey "^j" down-line-or-history

      tm() {
        sessions=$(tmux ls)
        dir=$(find ~/git ~/ut -mindepth 1 -maxdepth 1 -type d | fzf --header "$sessions" --header-border sharp --header-label "Sessions")

        if [[ -z $dir ]]; then
            return
        fi

        session=$(basename $dir | tr . _)

        if [[ -z $TMUX ]]; then
            tmux new-session -Ac $dir -s $session
            return
        fi

        if ! tmux has-session -t $session 2> /dev/null; then
            tmux new-session -dc $dir -s $session
        fi

        client=$(tmux display-message -p '#{client_name}')
        tmux switch-client -c $client -t $session
      }

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
