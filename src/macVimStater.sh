#!/bin/sh
#--------------------------------
# gVim Starter shell for MAC
#
# @author kazuakiM
#--------------------------------
if [ ! -e $1 ] ; then
    touch $1;
fi
open -a MacVim $1;
