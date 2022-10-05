#!/bin/bash
if pgrep -x "picom" > /dev/null
then
	killall picom
    sleep 1
    if [ "$1" == "start" ]; then
        setsid -f picom --experimental-backends &> /dev/null
    fi
else
	setsid -f picom --experimental-backends &> /dev/null
fi
