#!/bin/sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

if [ -f ~/.bashrc.d/git-prompt.sh ]; then
    source ~/.bashrc.d/git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWUNTRACKEDFILES=1 # can be slow
    GIT_PS1_SHOWSTASHSTATE=1
    # PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
    PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'
fi

if [ -f ~/.bashrc.d/bash-aliases.sh ]; then
    source ~/.bashrc.d/bash-aliases.sh
fi

if [ -f ~/.bashrc.d/bash-env.sh ]; then
    source ~/.bashrc.d/bash-env.sh
fi

if [ -f ~/.bashrc.d/gpg.sh ]; then
    source ~/.bashrc.d/gpg.sh
fi

if [ -f ~/.bashrc.d/k8s.sh ]; then
    source ~/.bashrc.d/k8s.sh
fi

export PIPENV_VENV_IN_PROJECT=1

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
