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
# A script to launch a floating kitty terminal on the currently
# focused monitor.
# Deps:
# - i3 window manager
# - xdotool
# - tmux (For continued session)
# =============================================================


TERM=kitty
TERM_NAME="Floating-Terminal"
OPTIONS="--title $TERM_NAME --class $TERM_NAME"
COMMAND="tmux new-session -A -s $TERM_NAME"
MONITOR_WIDTH=1920
X_OFFSET=20
Y_OFFSET=750
TERM_WIDTH=700
TERM_HEIGHT=310

# Check if there's alright a floating-terminal
WIN_ID=`xdotool search --onlyvisible --name "$TERM_NAME"`
if (xdotool search --onlyvisible --name "$TERM_NAME"); then
    xdotool windowkill $WIN_ID
    exit 0
fi

kitty $OPTIONS $COMMAND &
MOUSE_X=`xdotool getmouselocation --shell | grep "X=" | cut -d= -f2`
TERM_X=`echo "$MOUSE_X - ($MOUSE_X % $MONITOR_WIDTH) - $X_OFFSET - $TERM_WIDTH + $MONITOR_WIDTH" | bc`
TERM_Y=$Y_OFFSET
sleep 0.2
WIN_ID=`xdotool search --onlyvisible --name "$TERM_NAME"`
xdotool windowsize $WIN_ID $TERM_WIDTH $TERM_HEIGHT
xdotool windowmove $WIN_ID $TERM_X $TERM_Y
