#!/bin/sh

function restartPanel() {
    while read -r line; do
        echo "Killing panel on signal $line"
        pkill -x panel
        sleep 1
        echo "Starting panel"
        setsid $HOME/.scripts/panel/panel &
    done
}

bspc subscribe monitor_geometry | restartPanel
