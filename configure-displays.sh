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

all_displays=`xrandr -q | grep "connected" | cut -d" " -f1`

# Turn off all displays
for display in $all_displays; do
    xrandr --output $display --off
done

case "$1" in
    # Single display
    edp)
        xrandr \
            --output eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;
    hdmi)
        xrandr \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        ;;
    usbc)
        xrandr \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;

    # Two Horizontal Displays
    edp-hdmi)
        xrandr \
            --output eDP --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        ;;
    edp-usbc)
        xrandr \
            --output eDP --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;
    hdmi-usbc)
        xrandr \
            --output HDMI-A-0 --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;

    # Triple displays
    edp-hdmi-usbc)
        xrandr \
            --output eDP --mode 1920x1080 --pos 3840x0 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DisplayPort-0 --mode 1920x1080 --pos 0x0 --rotate normal
        ;;
    edp-hdmi-vusbc)
        xrandr \
            --output eDP --mode 1920x1080 --pos 0x420 --rotate normal \
            --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x420 --rotate normal \
            --output DisplayPort-0 --mode 1920x1080 --pos 3840x0 --rotate right
        ;;

    mama-displays)
        xrandr \
            --output DVI-I-2-2 --mode 1920x1080 --pos 1920x0 --rotate normal \
            --output DVI-I-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
        ;;
    *)
        echo "Invalid option for configuring displays"
        ;;
esac

sleep 1

nitrogen --restore
i3-msg "restart"
