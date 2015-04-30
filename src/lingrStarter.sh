#!/bin/sh
#--------------------------------
# Lingr Starter shell
#
# @author kazuakiM
#--------------------------------
logFile="/Trashes/#vim/`date +%Y-%m-%d`_Lingr.txt"

# Log file delete
rm -f /Trashes/#vim/`date -v-4d +%Y-%m-%d`_Lingr.txt
# Log file make
touch $logFile
# LimeChat Start
open -a /Users/mabuchikazuaki/Applications/LimeChat.app
# GateWay Server Satrt
nohup ruby $HOME/.vim/bundle/lingr-irc/lig.rb > /dev/null 2>&1 &
nohup tail -F $logFile|perl -e 'system "growlnotify", "-m",  $_ while(<STDIN>);' &
# Finish
exit 0
