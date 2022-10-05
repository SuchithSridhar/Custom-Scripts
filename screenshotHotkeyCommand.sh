#!/bin/bash

base_folder="$HOME/Pictures/ScreenShots/"


if echo "qwero" | grep -q $1 ; then
    output="$base_folder"$(date +"ss_%y-%m-%d__%H-%M-%S(%3N)").png
elif echo "asdf" | grep -q $1 ; then
    output="$base_folder""a_screenshot.png"
else
    exit
fi

if echo "qa" | grep -q $1 ; then
    flameshot gui -r > "${output}"
elif echo "ws" | grep -q $1 ; then
    scrot -ub $base_folder"temp.png"
    mv -f $base_folder"temp.png" $output

elif echo "ed" | grep -q $1 ; then
    flameshot screen -r > "$output"
elif echo "rf" | grep -q $1 ; then
    flameshot full -r > "$output"
elif echo "o" | grep -q $1 ; then
    cp "$HOME/Pictures/ScreenShots/a_screenshot.png" "$output"
fi

xclip -selection clipboard -t image/png -i $output
notify-send "Screenshot Saved" $output
