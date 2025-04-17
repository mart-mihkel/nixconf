#!/usr/bin/env bash

notify_status=3 # 3: > 20 | charging, 2: <= 20, 1: <= 10
bat="/sys/class/power_supply/BAT0"

while true; do
    status=$(cat "$bat/status")
    capacity=$(cat "$bat/capacity")
    idx=$(( capacity * 9 / 100 ))

    if [[ "$status" == "Charging" ]]; then
        icons=("󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")
        notify_status=3
    else
        icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

        if [[ $notify_status -gt 1 && $capacity -le 10 ]]; then
            dunstify -u critical -t 60000 "󰂃 Critical"
            notify_status=1
        fi

        if [[ $notify_status -gt 2 && $capacity -le 20 ]]; then
            dunstify -u normal -t 60000 "󰂃 Low"
            notify_status=2
        fi
    fi

    echo "${icons[$idx]}"
    sleep 2
done
