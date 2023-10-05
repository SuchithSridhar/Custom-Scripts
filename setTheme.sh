#!/bin/bash

if [ -z "$1" ]; then
    echo "Invalid call. Please provide theme as arument."
fi

case "$1" in
    "dark") 
        # Update Alacritty
        ln -sf "$HOME/.config/alacritty/alacritty-dark.yml"\
            "$HOME/.config/alacritty/alacritty.yml"

        # Update I3
        ln -sf "$HOME/.config/i3/config-dark.i3config"\
            "$HOME/.config/i3/config"
        i3-msg reload

        # Update color stored in config (Used by Nvim)
        echo "dark" > "$HOME/.config/suchi-color.txt"

        # Update GTK Applications (2.0, 3.0)
        THEME="Arc-Darkest"
        sed -i "/^gtk-theme-name=/c\gtk-theme-name=\"$THEME\"" "$HOME/.gtkrc-2.0" 
        sed -i "/^gtk-theme-name=/c\gtk-theme-name=$THEME" "$HOME/.config/gtk-3.0/settings.ini"
    ;;
    "light") 
        ln -sf "$HOME/.config/alacritty/alacritty-light.yml"\
            "$HOME/.config/alacritty/alacritty.yml"

        # Update I3
        ln -sf "$HOME/.config/i3/config-light.i3config"\
            "$HOME/.config/i3/config"
        i3-msg reload

        echo "light" > "$HOME/.config/suchi-color.txt"
        THEME="Arc-Lighter"
        sed -i "/^gtk-theme-name=/c\gtk-theme-name=\"$THEME\"" "$HOME/.gtkrc-2.0" 
        sed -i "/^gtk-theme-name=/c\gtk-theme-name=$THEME" "$HOME/.config/gtk-3.0/settings.ini"
    ;;
    *) echo "Invalid theme."
    ;;
esac
