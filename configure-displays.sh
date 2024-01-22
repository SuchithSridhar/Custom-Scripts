#!/bin/sh
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
# A script to configure displays.
# =============================================================

# Utility function to turn off unnecessary displays
turn_off_unneeded_displays() {
    all_displays=`xrandr -q | grep "connected" | cut -d" " -f1`
    local intended_displays=("$@")
    for display in $all_displays; do
        local needed=false
        for intended_display in "${intended_displays[@]}"; do
            if [[ $display == $intended_display ]]; then
                needed=true
                break
            fi
        done
        if [[ $needed == false ]]; then
            xrandr --output $display --off
        fi
    done
}

case "$1" in
    # Single display
    edp)
        turn_off_unneeded_displays "eDP"
        xrandr \
            --output eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;
    hdmi)
        turn_off_unneeded_displays "HDMI-A-0"
        xrandr \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        ;;
    usbc)
        turn_off_unneeded_displays "DisplayPort-0"
        xrandr \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;

    # Two Horizontal Displays
    edp-hdmi)
        turn_off_unneeded_displays "eDP" "HDMI-A-0"
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
        ;;
    edp-hdmi-mirror)
        turn_off_unneeded_displays "eDP" "HDMI-A-0"
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        ;;
    edp-usbc)
        turn_off_unneeded_displays "eDP" "DisplayPort-0"
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
        ;;
    hdmi-usbc)
        turn_off_unneeded_displays "HDMI-A-0" "DisplayPort-0"
        xrandr \
            --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
        ;;

    # Triple displays
    edp-hdmi-usbc)
        turn_off_unneeded_displays "HDMI-A-0" "DisplayPort-0" "eDP"
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-0 --mode 1920x1080 --pos 3840x0 --rotate normal
        ;;
    edp-hdmi-vusbc)
        turn_off_unneeded_displays "HDMI-A-0" "DisplayPort-0" "eDP"
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x373 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x373 --rotate normal \
            --output DisplayPort-0 --mode 1920x1080 --pos 3840x0 --rotate left
        ;;
    *)
        echo "Invalid option for configuring displays"
        ;;
esac

sleep 1

/home/suchi/.local/bin/custom-scripts/setWallpaper.sh "called from configure-displays.sh"
i3-msg "restart"
