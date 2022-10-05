#!/bin/bash

if [ "$1" == "force" ]; then
        brave &
        chromium &
        firefox &
        syncthing &

elif [ ! -z "$1" ]; then
    echo "Invalid option: $1"
    echo "option: 'force'"
    exit 1

fi

$HOME/.local/bin/custom-scripts/keycounter.py & echo $! > /home/suchi/.config/custom-config/keycounter-pid.txt
if (xrandr | grep "HDMI-A-0 connected" && xrandr | grep "DisplayPort-0 connected"); then
    $HOME/.sl/2-horizontal.sh
fi

COUNTER=0;
while true; do
    if ( nmcli | grep " connected" ); then
        notify-send.py --icon=$HOME/.local/share/icons/wifi.png \
            "Connection Status" "Connected to Wifi" -a "startup-apps.sh" \
            && notify-send "Connected to wifi"
        brave &
        chromium &
        syncthing &
        break;
    fi

    if [ "$COUNTER" -gt 10 ]; then
        dunstify "Connection Status" "Unable to connect to internet" -a "startup-apps.sh"
        break;
    fi

    sleep 1;
    let COUNTER+=1;
done
