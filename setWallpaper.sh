#!/bin/sh
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
# Date: 2023, Nov 05
# 
# Program to set random wallpaper
# from wallpaper directory.

WAL_DIR="$HOME/.config/custom-config/wallpaper/"

FILE=`find "$WAL_DIR" -type f | shuf -n 1`

feh --bg-fill "$FILE"
