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
# A script to launch a floating kitty terminal with qalc
# on the currently focused monitor.
# Deps:
# - i3 window manager
# - qalc
# - xdotool
# - tmux (For continued session)
# =============================================================


APP="qalc"
TERM=kitty
TERM_NAME="Floating-Calculator"
OPTIONS="--title $TERM_NAME --class $TERM_NAME"
MONITOR_WIDTH=1920
TERM_WIDTH=700
TERM_HEIGHT=200
X_OFFSET=20
Y_OFFSET=50

# Check if there's alright a floating-terminal
WIN_ID=`xdotool search --onlyvisible --name "$TERM_NAME"`
if (xdotool search --onlyvisible --name "$TERM_NAME"); then
    xdotool windowkill $WIN_ID
    exit 0
fi

tmux has-session -t "$TERM_NAME" > /dev/null 2>&1
if [ $? != 0 ]; then
    COMMAND="tmux new-session -s $TERM_NAME \"$APP\""
else
    COMMAND="tmux attach-session -t $TERM_NAME"
fi

kitty $OPTIONS $COMMAND &
MOUSE_X=`xdotool getmouselocation --shell | grep "X=" | cut -d= -f2`
TERM_X=`echo "$MOUSE_X - ($MOUSE_X % $MONITOR_WIDTH) - $X_OFFSET - $TERM_WIDTH + $MONITOR_WIDTH" | bc`
TERM_Y=$Y_OFFSET
sleep 0.2
WIN_ID=`xdotool search --onlyvisible --name "$TERM_NAME"`
xdotool windowsize $WIN_ID $TERM_WIDTH $TERM_HEIGHT
xdotool windowmove $WIN_ID $TERM_X $TERM_Y
