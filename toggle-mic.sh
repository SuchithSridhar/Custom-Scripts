#!/bin/bash
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
#
# Toggle the current state of the mic

MIC = "Capture"

amixer set Capture toggle

if ( amixer | grep "$MIC" -A 5 | grep "\[on\]" ); then
    dunstify "Microphone Toggled" "Mic State: ON"
else
    dunstify "Microphone Toggled" "Mic State: OFF"
fi
