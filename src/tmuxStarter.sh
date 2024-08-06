#!/bin/zsh
#--------------------------------
# tmux Starter shell
#
# @author kazuakiM
#--------------------------------
if [ -z `tmux ls 2>/dev/null` ] ; then
    tmux -u -f $HOME/.config/tmux/tmux.conf
else
    tmux -u -f $HOME/.config/tmux/tmux.conf attach
fi
