#!/bin/bash
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
#
# This script allows a user to filter through a youtube watch later
# playlist and select the ones to keep and the ones to remove.

# based on number of monitors
OFFSET_X=1920
OFFSET_Y=0

# Position of the 3 dots menu on the screen
# relative to the top left corner of current screen
BUTTON_POSITION_X=845
BUTTON_POSITION_Y=720

remove_item_from_watch_later () {
    X_POS=$((OFFSET_X + BUTTON_POSITION_X))
    Y_POS=$((OFFSET_Y + BUTTON_POSITION_Y))

    # move mouse to "remove from watch later" button
    # in the sub menu.
    REMOVE_OFFSET=120
    REMOVE_POS=$((Y_POS + REMOVE_OFFSET))

    # Click on 3 dots to open menu
    xdotool mousemove $X_POS $Y_POS
    xdotool click 1

    # Click on remove from watch later
    xdotool mousemove $X_POS $REMOVE_POS
    xdotool click 1
}

scroll_to_next_item () {

    X_POS=$((OFFSET_X + BUTTON_POSITION_X))
    Y_POS=$((OFFSET_Y + BUTTON_POSITION_Y))

    xdotool mousemove $X_POS $Y_POS

    # Scroll down to next item
    xdotool click 5
    xdotool click 5
}

refocus_terminal () {
    xdotool mousemove $X $Y
    xdotool click 1
}

print_help () {
    echo "Choose from the following options:"
    echo "   1. skip (s) skip the current video (don't remove from list)."
    echo "   2. remove (r) remove the current video from list."
    echo "   3. quit (q) stop the program."
    echo ""
}

# Set the current position of the mouse
# so that we can refocus to the terminal after
# we've either skipped or removed.
eval $(xdotool getmouselocation --shell)
print_help

while (true)
do
    printf "Choose option for video (s / r / q): "
    read user_input

    if [[ "$user_input" == "q" ]] || [[ "$user_input" == "quit" ]]; then
        break;
    elif [[ "$user_input" == "s" ]] || [[ "$user_input" == "skip" ]]; then
        scroll_to_next_item 
        refocus_terminal
    elif [[ "$user_input" == "h" ]] || [[ "$user_input" == "help" ]]; then
        print_help
    elif [[ "$user_input" == "r" ]] || [[ "$user_input" == "remove" ]]; then
        remove_item_from_watch_later
        refocus_terminal
    else
        echo "Invalid option."
        print_help
    fi
done
