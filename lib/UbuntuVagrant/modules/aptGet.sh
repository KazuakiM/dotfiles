#!/bin/sh
#--------------------------------
# apt-get setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
account=$1
#}}}
echo "apt-get setting ..."
echo "\taccount:$account"
add-apt-repository -y ppa:ondrej/php && \
apt update -y && \
apt install automake dh-autoreconf gcc gettext language-pack-ja libtool luajit make pkg-config vim-gnome -y && \
update-locale LANGUAGE=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 && \
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
chmod 755 /usr/share/doc/git/contrib/diff-highlight/diff-highlight && \
chown -R $account:$account /usr/local
