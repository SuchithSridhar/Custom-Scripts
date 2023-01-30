#!/bin/sh
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
#
# Toggle the polybar

flag=0
killall -q polybar && flag=1

if [ "$flag" == "0" ]; then
    $HOME/.config/polybar/launch.sh
    i3-msg gaps top all set 38
else
    i3-msg gaps top all set 5
fi
