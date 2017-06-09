#!/bin/sh
#--------------------------------
# Lingr Starter shell
#
# @author kazuakiM
#--------------------------------
# LimeChat Start
open -a LimeChat
# GateWay Server Satrt
nohup ruby $HOME/.vim/dein.vim/repos/github.com/psychs/lingr-irc/lig.rb > /dev/null 2>&1 &
# Finish
exit 0
