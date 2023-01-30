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
# script to help edit other similar scripts
# =============================================================


# Add new script dirs on new line
SCRIPT_DIR="$HOME/.local/bin/custom-scripts/"

if [ -d "$SCRIPT_DIR" ]; then
    FILES=`find "$SCRIPT_DIR" -type f -not -path "*/.git/*" -printf "%f\n"`
    FILE=`echo "$FILES" | \
        fzf --preview "bat --color=always \
                        --line-range :200 \
                        --style=plain $SCRIPT_DIR/{}"`
fi


if [ -f "$SCRIPT_DIR/$FILE" ]; then
    nvim "$FILE"
fi
