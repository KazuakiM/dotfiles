#!/bin/zsh
#--------------------------------
# tmux Starter shell
#
# @author kazuakiM
#--------------------------------
if tmux has-session 2>/dev/null; then
    tmux -u -f "$HOME/.config/tmux/tmux.conf" attach
else
    tmux -u -f "$HOME/.config/tmux/tmux.conf"
fi
