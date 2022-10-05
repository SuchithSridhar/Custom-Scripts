#!/bin/bash

COUNTER=1;
BASE=`cat $HOME/.config/custom-config/picpath`
while true; do
    if [ -f "$BASE/pic$COUNTER.png" ]; then
        let COUNTER+=1;
    else
        cp $HOME/Pictures/ScreenShots/a_screenshot.png "$BASE/pic$COUNTER.png"
        notify-send "Copied to $BASE/pic$COUNTER.png"
        break
    fi
done
