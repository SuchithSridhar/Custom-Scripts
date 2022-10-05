#!/bin/sh

network="That's a lot of damage"
x=`nmcli | grep "$network"`

if [ "$x" != '' ]
then
    setsid -f sshfs suchi@192.168.2.100:/home/suchi /mnt/suchi-server
fi
