#!/bin/sh
#--------------------------------
# apt-get setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
account=$1
#}}}
echo "apt-get setting ..."
echo "\taccount:$account"
add-apt-repository -y ppa:ondrej/php  >> $log 2>> $log && \
apt-get update -y                     >> $log 2>> $log && \
chown -R $account:$account /usr/local >> $log 2>> $log
