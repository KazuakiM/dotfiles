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
apt-get install -y --allow-unauthenticated php7.0 php7.0-fpm php-ssh2            >> $log 2>> $log && \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin >> $log 2>> $log
