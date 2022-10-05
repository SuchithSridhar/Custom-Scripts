#!/bin/sh

if [ "$1" == "on" ]; then
    xrandr --output HDMI-A-0 --mode 1920x1080 --right-of eDP --primary
elif [ "$1" == "off" ]; then
    xrandr --output HDMI-A-0 --off
fi

sleep 2

i3-msg restart
