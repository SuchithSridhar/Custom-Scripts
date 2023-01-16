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

case "$1" in
    # Single display
    edp)
        xrandr \
            --output eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal \
            --output HDMI-A-0 --off \
            --output DisplayPort-0 --off
        ;;
    hdmi)
        xrandr \
            --output eDP --off \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
            --output DisplayPort-0 --off
        ;;
    usbc)
        xrandr \
            --output eDP --off \
            --output HDMI-A-0 --off \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;

    # Two Horizontal Displays
    edp-hdmi)
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-0 --off
        ;;
    edp-usbc)
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
            --output HDMI-A-0 --off \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
        ;;
    hdmi-usbc)
        xrandr \
            --output eDP --off \
            --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
        ;;

    # Triple displays
    edp-hdmi-usbc)
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-0 --mode 1920x1080 --pos 3840x0 --rotate normal
        ;;
    edp-hdmi-vusbc)
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x420 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x420 --rotate normal \
            --output DisplayPort-0 --mode 1920x1080 --pos 3840x0 --rotate right
        ;;

    # One horizontal and one vertical
    edp-vhdmi)
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x420 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate right \
            --output DisplayPort-0 --off
        ;;
    edp-vusbc)
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x420 --rotate normal \
            --output HDMI-A-0 --off \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate right
        ;;
    hdmi-vusbc)
        xrandr \
            --output eDP --off \
            --output HDMI-A-0 --mode 1920x1080 --pos 0x420 --rotate normal \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate right
        ;;
    vhdmi-usbc)
        xrandr \
            --output eDP --off \
            --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate left \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x420 --rotate normal
        ;;
    *)
        echo "Invalid option for configuring displays"
        ;;
esac

sleep 1

nitrogen --restore
i3-msg "restart"
