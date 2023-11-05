#!/bin/sh
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
# Date: 2023, Nov 05
# 
# Program to set random wallpaper
# from wallpaper directory.

WAL_DIR="$HOME/.config/custom-config/wallpaper/"
LOG_DIR="$HOME/.local/logs"
LOG_FILE="$LOG_DIR/setWallpaper.sh.log"

if [ ! -z "$1" ] && [ -d "$LOG_DIR" ]; then
    echo "$(date) :: $1" >> $LOG_FILE
fi

FILE=`find "$WAL_DIR" -type f | shuf -n 1`

feh --bg-fill "$FILE"
