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
elif [ ! -z "$1" ]; then
    echo "Invalid option: $1"
    echo "option: 'force'"
    exit 1
fi

# Configure Displays
if (xrandr | grep "HDMI-A-0 connected"); then
    if (xrandr | grep "DisplayPort-0 connected"); then
        $HOME/.local/bin/custom-scripts/configure-displays.sh edp-hdmi-usbc
    else
        $HOME/.local/bin/custom-scripts/configure-displays.sh edp-hdmi
    fi
elif (xrandr | grep "DisplayPort-0 connected"); then
    $HOME/.local/bin/custom-scripts/configure-displays.sh edp-usbc
else
    $HOME/.local/bin/custom-scripts/setWallpaper.sh "called from startup-apps.sh"
fi

COUNTER=0;
while true; do
    if ( nmcli | grep "wlp2s0: connected" ); then
        SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)
        notify-send.py --icon=$HOME/.local/share/icons/wifi.png \
            "Connection Status" "Connected to Wifi" -a "startup-apps.sh" \
            && notify-send "Connected to wifi"
        brave &
        chromium &
        break;
    fi

    if [ "$COUNTER" -gt 10 ]; then
        dunstify "Connection Status" "Unable to connect to internet" -a "startup-apps.sh"
        break;
    fi

    sleep 1;
    let COUNTER+=1;
done
