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
yum -y --enablerepo=epel,remi install \
    lua lua-devel                                                    >> $log 2>> $log && \
git clone http://luajit.org/git/luajit-2.0.git /usr/local/src/luajit >> $log 2>> $log && \
cd /usr/local/src/luajit/                                                             && \
make                                                                 >> $log 2>> $log && \
make install                                                         >> $log 2>> $log

