#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done

polybar -q main -c "$HOME/.dotfiles/polybar/config.ini" &
# current=$(xrandr --listactivemonitors | grep -v Monitors | grep -Eo '[^ ]+$')
# if [ $current == "DP-1" ]
# then
# 	polybar -q main_external -c "$HOME/.dotfiles/polybar/config.ini" &
# else
# 	polybar -q main -c "$HOME/.dotfiles/polybar/config.ini" &
# fi

