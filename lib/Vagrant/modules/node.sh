#!/bin/sh
#--------------------------------
# Node.js setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
home=/home/vagrant
#}}}
echo "Node.js setting ..."
yum -y --enablerepo=epel install nodejs npm      >> $log 2>> $log && \
npm install -g eslint eslint-plugin-react doctoc >> $log 2>> $log
