#!/bin/sh
#--------------------------------
# tmux Starter shell
#
# @author kazuakiM
#--------------------------------
if [ -z `tmux ls` ] ; then
    tmux -u -f $HOME/.config/tmux/tmux.conf
else
    tmux -u -f $HOME/.config/tmux/tmux.conf attach
fi
