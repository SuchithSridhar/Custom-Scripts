#!/bin/bash
# Author: Suchith Sridhar
# Website: https://suchicodes.com/

# Toggle the current state of picom
# Off if on and on if off

if pgrep -x "picom" > /dev/null
then
	killall picom
    sleep 1
    if [ "$1" == "start" ]; then
        setsid -f picom &> /dev/null
    fi
else
	setsid -f picom &> /dev/null
fi
