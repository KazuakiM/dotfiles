#!/bin/sh
#--------------------------------
# LuaJIT setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "LuaJIT install ..."
git clone http://luajit.org/git/luajit-2.0.git /usr/local/src/luajit >> $log 2>> $log && \
cd /usr/local/src/luajit/                                                             && \
make                                                                 >> $log          && \
make install                                                         >> $log

