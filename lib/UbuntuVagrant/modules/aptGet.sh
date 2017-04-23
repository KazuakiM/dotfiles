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
add-apt-repository -y ppa:ondrej/php >> $log 2>> $log && \
apt update -y                        >> $log 2>> $log && \
apt install automake dh-autoreconf gcc gettext language-pack-ja libtool luajit make pkg-config vim-gnome -y >> $log 2>> $log && \
update-locale LANGUAGE=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 >> $log 2>> $log && \
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime >> $log 2>> $log && \
chown -R $account:$account /usr/local                >> $log 2>> $log
