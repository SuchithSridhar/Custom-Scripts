#!/bin/bash
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
#
# The startup application to be launched when the computer
# first boots. These are based on the current network
# connectivity.

if [ "$1" == "force" ]; then
        brave &
        chromium &
        syncthing &

elif [ ! -z "$1" ]; then
    echo "Invalid option: $1"
    echo "option: 'force'"
    exit 1

fi

if (xrandr | grep "HDMI-A-0 connected" && xrandr | grep "DisplayPort-0 connected"); then
    $HOME/.sl/3-horizontal.sh
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
