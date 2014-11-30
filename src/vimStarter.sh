#!/bin/sh
#--------------------------------
# gVim Starter shell
#
# @author kazuakiM
#--------------------------------
if [ $# -eq 1 ]; then
    "/cygdrive/c/usr/local/bin/Vim/gvim.exe" $(cygpath -aw $*) &
else
    "/cygdrive/c/usr/local/bin/Vim/gvim.exe" &
fi
