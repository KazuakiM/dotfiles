#!/bin/sh
#--------------------------------
# PHP setting
#
# @author KazuakiM
#--------------------------------
echo "PHP setting ..."
add-apt-repository ppa:mapnik/boost && \
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
echo deb http://dl.hhvm.com/ubuntu precise main | tee /etc/apt/sources.list.d/hhvm.list && \
apt install --allow-unauthenticated apache2 \
    php7.1 php7.1-curl php7.1-fpm php7.1-mbstring php7.1-soap php7.1-ssh2 php7.1-xdebug php7.1-xml php7.1-zip \
    hhvm -y && \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && \
echo 'xdebug.enable = 1' >> /etc/hhvm/php.ini
