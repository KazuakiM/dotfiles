#!/bin/sh
#--------------------------------
# MySQL setting
#
# @author KazuakiM
# @url : https://dev.mysql.com/downloads/repo/yum/
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
home=/home/vagrant
#}}}
echo "MySQL setting ..."
yum remove mariadb-libs                                                                               >> $log 2>> $log && \
yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm                >> $log 2>> $log && \
yum -y --enablerepo=mysql57-community install mysql-community-devel mysql-community-server            >> $log 2>> $log && \
systemctl enable  mysqld.service                                                                      >> $log 2>> $log && \
systemctl restart mysqld.service
