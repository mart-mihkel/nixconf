#!/usr/bin/env bash


if [[ "$1" == "-s" ]]; then
    playerctl -a pause &
    hyprlock &
    systemctl suspend
elif [[ "$1" == "-l" ]]; then
    playerctl -a pause &
    hyprlock &
else
    echo "Usage $0 [suspend | lock]"
fi
