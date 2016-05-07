#!/bin/sh
#--------------------------------
# tmux Starter shell
#
# @author kazuakiM
#--------------------------------
if [ -z `tmux ls` ] ; then
    tmux -f $HOME/.config/tmux/.tmux.conf
else
    tmux -f $HOME/.config/tmux/.tmux.conf attach
fi
