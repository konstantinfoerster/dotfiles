#!/bin/sh

# If not running interactively, don't do anything
[[ $- = *i* ]] || return

source ~/.scripts/common.sh

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS. 
shopt -s checkwinsize

PROMPT_DIRTRIM=4 

#Arch default
#PS1='[\u@\h \W]\$ '

#\u user \h hostname \w pwd
PS1="\u@\h \w\\$ "

if [ -f ~/.bashrc.d/git-prompt.sh ]; then
    source ~/.bashrc.d/git-prompt.sh
    PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=1
fi

if [ -f ~/.bashrc.d/bash-aliases.sh ]; then
  source ~/.bashrc.d/bash-aliases.sh
fi

# TMUX
if which tmux >/dev/null 2>&1; then
  #if not inside a tmux session, and if no session is started, start a new session
  test -z "$TMUX" && (tmux attach || tmux new-session)
fi
