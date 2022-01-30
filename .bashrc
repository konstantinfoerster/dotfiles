#!/bin/bash

# If not running interactively, don't do anything
if [[ $- != *i* ]]; then
    echo "no interactive shell, skipping"
    return
fi

# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS. 
shopt -s checkwinsize

PROMPT_DIRTRIM=4 

# \u user \h hostname \w pwd
PS1="\u@\h \w\\$ "

for filename in "$HOME"/.bashrc.d/*.sh; do
    source $filename
done

if [ -f ~/.bashrc.d/git-prompt.sh ]; then
#    source ~/.bashrc.d/git-prompt.sh # already added
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWUNTRACKEDFILES=1 # can be slow
    GIT_PS1_SHOWSTASHSTATE=1
    # PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
    PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'
fi

setxkbmap  de
