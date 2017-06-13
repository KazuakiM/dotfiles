#!/bin/sh
#--------------------------------
# PHP setting
#
# @author KazuakiM
#--------------------------------
echo "PHP setting ..."
yum -y --enablerepo=epel,remi install php71-php php71-php-devel php71-php-intl php71-php-mbstring php71-php-xml php71-php-pecl-ssh2
source /opt/remi/php71/enable
php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin
