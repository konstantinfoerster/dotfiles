#!/bin/bash

# If not running interactively, don't do anything
if [[ $- != *i* ]]; then
    echo "no interactive shell, skipping"
    return
fi

# Ignore duplicate lines in the history and lines starting with space
HISTCONTROL=ignoredups:ignorespace
# Max entries in history
HISTSIZE=5000
HISTFILESIZE=$HISTSIZE

# sync history on every command (makes history work between multiple sessions)
history() {
  _bash_history_sync
  builtin history "$@"
}
_bash_history_sync() {
  builtin history -a # append entered line
  HISTFILESIZE=$HISTSIZE # force history file truncation
  builtin history -c # clear history of current session
  builtin history -r # read history file into current session
}
PROMPT_COMMAND=_bash_history_sync

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS. 
shopt -s checkwinsize

PROMPT_DIRTRIM=4 

# \u user \h hostname \w pwd
PS1="\u@\h \w\\$ "

for filename in "$HOME"/.bashrc.d/*.sh; do
    source "$filename"
done

if [ -f ~/.bashrc.d/git-prompt.sh ]; then
#    source ~/.bashrc.d/git-prompt.sh # already added via script in .bashrc.d
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWUNTRACKEDFILES=1 # can be slow
    GIT_PS1_SHOWSTASHSTATE=1
    PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "; _bash_history_sync'
fi
