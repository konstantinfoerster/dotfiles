#!/bin/sh

#function restartPanel() {
#    while read -r line; do
        pkill -x panel
        sleep 1
        echo "Starting panel"
        setsid $HOME/.scripts/panel/panel &
#    done
#}

#bspc subscribe monitor_geometry | restartPanel
