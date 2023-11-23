#!/bin/sh
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
# Date: 2023, Nov 05

WAL_DIR="$HOME/.config/custom-config/wallpaper"
WAL_FILE="$WAL_DIR/set-wallpaper"
LOG_DIR="$HOME/.local/logs"
LOG_FILE="$LOG_DIR/setWallpaper.sh.log"

if [ ! -z "$2" ] && [ -d "$LOG_DIR" ]; then
    echo "$(date) :: $2" >> $LOG_FILE

elif [ ! -z "$1" ] && \
     [ "suchi" != "$1" ] && [ "random" != "$1" ] && \
     [ -d "$LOG_DIR" ]; then
    echo "$(date) :: $1" >> $LOG_FILE

fi

if [ ! -f "$WAL_FILE" ]; then
    FILE=`find "$WAL_DIR" -type f | shuf -n 1`
    ln -s "$FILE" "$WAL_FILE"

elif [ "random" == "$1" ]; then
    CUR_WAL_FILE_PATH=`readlink -f "$WAL_FILE"`
    CUR_WAL_FILE=`basename "$CUR_WAL_FILE_PATH"`
    CUR_WAL_LINK=`basename "$WAL_FILE"`
    FILE=`find "$WAL_DIR/images" -maxdepth 1 -type f \
                                 -not -name "$CUR_WAL_LINK" \
                                 -not -name "$CUR_WAL_FILE" | shuf -n 1`
    ln -fs "$FILE" "$WAL_FILE"

elif [ "suchi" == "$1" ]; then
    FILE="$WAL_DIR/lockscreen/suchi-img.png" 
    ln -fs "$FILE" "$WAL_FILE"
fi


feh --bg-fill "$WAL_FILE"
