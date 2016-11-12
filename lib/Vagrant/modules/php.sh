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
yum -y --enablerepo=epel,remi install php71-php php71-php-devel php71-php-pecl-ssh2 >> $log 2>> $log && \
source /opt/remi/php71/enable                                                       >> $log 2>> $log && \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin    >> $log 2>> $log
