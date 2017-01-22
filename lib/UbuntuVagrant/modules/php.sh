#!/bin/sh
#--------------------------------
# PHP setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "PHP setting ..."
apt-get install -yqq --allow-unauthenticated php7.0 php7.0-curl php7.0-fpm php7.0-mbstring php7.0-soap php7.0-ssh2 php7.0-xdebug php7.0-xml php7.0-zip >> $log 2>> $log && \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin >> $log 2>> $log
