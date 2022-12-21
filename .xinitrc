#!/bin/sh

NR_OF_MONITORS=$(xrandr -d :0 -q | grep ' connected' | wc -l)


if [ "$NR_OF_MONITORS" = "4" ]
then
    xrandr --output eDP-1 --mode 2560x1440 --pos 1600x0 --rotate normal --output HDMI-1 --off --output DVI-I-3-2 --mode 1920x1080 --pos 0x1440 --rotate normal --output DVI-I-2-1 --mode 1920x1080 --pos 3840x1440 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output DP-1-2 --primary --mode 1920x1080 --rate 240.00 --pos 1920x1440 --rotate normal --output DP-1-3 --off
fi

feh --bg-scale ~/pictures/apple-macbook-pro-stock-2021-apple-event-2021-dark-mode-6016x5468-6759.jpg

./scripts/toolbar.sh

xrdb ~/.Xresources

xset r rate 200 50

#picom -b

exec dwm


