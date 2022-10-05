#!/bin/bash

# NOTE: Added grep -vw 0 since acpi was showing 2 batteries and that
# got rid of the second incorrect battery information.

# Program usually run as cronjob every 5 mins:
# */5 * * * * <script-location>

minBattery=20
maxBattery=100
export DISPLAY=:0
battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)' | grep -vw "0"`
not_charging=`acpi -b | grep -i " charging,"`
if [ "$battery_level" -le "$minBattery" ] && [ "$not_charging" == "" ]
then
    /usr/bin/notify-send -u "critical" "Battery low" "Battery at ${battery_level}%!" -a "Script"
    /usr/bin/mpg123 /home/suchi/.local/share/sounds/low_battery.mp3
fi
if [ "$battery_level" -ge "$maxBattery" ] && [ "$not_charging" != "" ]
then
    /usr/bin/notify-send "Battery charged" "Battery at ${battery_level}%." -a "Script"
fi
