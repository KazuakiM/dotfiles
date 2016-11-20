#!/bin/sh
#--------------------------------
# tmux-git repos name
#
# @author kazuakiM
#--------------------------------
gitRevParse=`git rev-parse --show-toplevel 2>/dev/null|tr -d '\n'`
if [ 0 < $gitRevParse ]; then
    echo `basename $gitRevParse`
else
    echo `basename $(pwd)`
fi
