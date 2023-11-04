#!/bin/bash

if [ -z "$1" ]; then
    echo "Invalid call. Please provide theme as arument."
fi

case "$1" in
    "dark") 
        BG_COLOR="#121212"
        FG_COLOR="#ffffff"
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

        # Update kitty Terminal
        sed -i "/^background/c\background $BG_COLOR" "$HOME/.config/kitty/kitty.conf"
        sed -i "/^foreground/c\foreground $FG_COLOR" "$HOME/.config/kitty/kitty.conf"

        # Update Tmux
        sed -i "s/#eff1f5/#1e1e2e/g" $HOME/.config/tmux/tmux.conf
    ;;
    "light") 
        BG_COLOR="#F5F6F7"
        FG_COLOR="#000000"
        # Update I3
        ln -sf "$HOME/.config/i3/config-light.i3config"\
            "$HOME/.config/i3/config"
        i3-msg reload

        # Update color stored in config (Used by Nvim)
        echo "light" > "$HOME/.config/suchi-color.txt"

        THEME="Arc-Lighter"
        sed -i "/^gtk-theme-name=/c\gtk-theme-name=\"$THEME\"" "$HOME/.gtkrc-2.0" 
        sed -i "/^gtk-theme-name=/c\gtk-theme-name=$THEME" "$HOME/.config/gtk-3.0/settings.ini"

        # Update kitty Terminal
        sed -i "/^background/c\background $BG_COLOR" "$HOME/.config/kitty/kitty.conf"
        sed -i "/^foreground/c\foreground $FG_COLOR" "$HOME/.config/kitty/kitty.conf"

        # Update Tmux
        sed -i "s/#1e1e2e/#eff1f5/g" $HOME/.config/tmux/tmux.conf
    ;;
    *) echo "Invalid theme."
    ;;
esac
