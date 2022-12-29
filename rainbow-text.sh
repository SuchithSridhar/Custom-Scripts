#!/bin/bash
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
# Display color changing bold font for some text

if [ "$1" == "" ]; then
    echo "Usage: <script> \"<Text to display>\""
    exit 1
fi

clear
while true; do
    banner "$1" "$2" "$3" | lolcat
    echo -en "\033[s\033[500A"
    sleep 0.1
done


