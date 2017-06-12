#!/bin/sh
#--------------------------------
# tmux-battery
#
# @author kazuakiM
#--------------------------------
battery=`pmset -g ps|egrep -o '[0-9]{1,3}%'|egrep -o '[0-9]{1,3}'|tr -d '\n'`
charge=`pmset -g ps|egrep -o 'discharging'|tr -d '\n'`

if [ "$battery" -lt 20 ]; then
    if [ "$charge" = 'discharging' ]; then
        echo "#[fg=colour234,bg=colour1,bold] $battery%"
    else
        echo "#[fg=colour234,bg=colour166,bold] $battery%"
    fi
else
    echo "#[fg=colour234,bg=colour2,bold] $battery%"
fi

if [ "$charge" = 'discharging' -a "$battery" -lt 25 ]; then
    growlnotify -m 'Battery!'
elif [ "$charge" = '' -a "$battery" -gt 95 ]; then
    growlnotify -m 'Battery!'
fi
