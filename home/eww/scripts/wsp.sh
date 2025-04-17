#!/usr/bin/env bash

socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
if [[ "$1" == "-a" ]]; then
    socat -u UNIX-CONNECT:$socket - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' \
            -e '/^focusedmon>>/ {print $3}'
elif [[ "$1" == "-w" ]]; then
    hyprctl dispatch workspace $2
else
    hyprctl workspaces -j | jq -c '[.[] | {id,icon:.id}] | sort_by(.id)'
    socat -u UNIX-CONNECT:$socket - | while read -r; do
        hyprctl workspaces -j | jq -c '[.[] | {id,icon:.id}] | sort_by(.id)'
    done
fi
