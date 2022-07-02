#!/bin/sh
/usr/bin/gnome-terminal -e "bash -c \"tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME\" " &
