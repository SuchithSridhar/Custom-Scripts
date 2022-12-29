#!/bin/sh
# Author: Suchith Sridhar
# Website: https://suchicodes.com/

setsid -f syncthing
setsid -f blueman-applet
sleep 20
/home/suchi/.local/bin/custom-scripts/mount-suchi-server.sh
