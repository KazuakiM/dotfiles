#!/bin/sh
#--------------------------------
# tmux Starter shell
#
# @author kazuakiM
#--------------------------------
if [ -z `tmux ls` ] ; then
    tmux
else
    tmux attach
fi
