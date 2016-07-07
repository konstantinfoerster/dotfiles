#!/bin/sh

pkill -x panel
echo "Panel killed"
sleep 1
echo "Starting panel"
$HOME/.scripts/panel/panel &
