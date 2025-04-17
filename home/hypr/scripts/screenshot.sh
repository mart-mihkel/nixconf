#!/usr/bin/env bash

geometry=$(slurp)

if [[ -z "$geometry" ]]; then
    echo "No geometry"
    exit 1
fi

stamp=$(date +%b%d-%H%M%S)
name="$stamp.png"
dir="$HOME/Pictures/screenshots"
target="$dir/$name"

mkdir --parents "$dir"

grim -g "$geometry" - | wl-copy -t image/png
wl-paste > "$target"

dunstify -u low -I "$target" "Screenshot" "Saved as $name"
