#!/bin/bash
# =============================================================
#                                                  
#   █████████   █████████                          
#  ███░░░░░███ ███░░░░░███  Suchith Sridhar        
# ░███    ░░░ ░███    ░░░   
# ░░█████████ ░░█████████   https://suchicodes.com 
#  ░░░░░░░░███ ░░░░░░░░███  https://github.com/suchithsridhar
#  ███    ░███ ███    ░███  
# ░░█████████ ░░█████████                            
#  ░░░░░░░░░   ░░░░░░░░░                            
#                                                    
# =============================================================
# script to help edit config files 
# =============================================================

# The $CONFIG_DIR_FILE contains a file that contains the
# sub-directories that have to be search for config files.
# This is added since there are a lot of config files under the
# general config folder and the search is more accurate when this
# filter is added.

CONFIG_DIR="$HOME/.config"
CONFIG_DIR_FILE="$CONFIG_DIR/custom-config/config-folders.txt"
FILES=`find "$CONFIG_DIR" -maxdepth 1 -type f -printf "%p\n"`
NEWLINE="
"

while read line; do
    if [ -d "$CONFIG_DIR/$line" ]; then
        CUR_FILES=`find "$CONFIG_DIR/$line" -type f -printf "%p\n"`
        FILES+="${NEWLINE}${CUR_FILES}"
    fi
done <<< `cat "$CONFIG_DIR_FILE"`

FILE=`echo "$FILES" | fzf`

if [ -f "$FILE" ]; then
    nvim "$FILE"
fi
