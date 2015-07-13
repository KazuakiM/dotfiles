#!/bin/sh
#--------------------------------
# MySQL setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
home=/home/vagrant
#}}}
echo "MySQL setting ..."
rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql                                       >> $log 2>> $log && \
rpm -ivh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm                 >> $log 2>> $log && \
yum -y --enablerepo=mysql56-community install mysql-community-devel mysql-community-server >> $log 2>> $log && \
systemctl enable mysqld.service                                                            >> $log 2>> $log && \
systemctl restart mysqld.service                                                           >> $log 2>> $log && \
mkdir -p $home/work                                                                        >> $log 2>> $log && \
git clone https://gist.github.com/2f5b562e0ffe337c8fec.git $home/work/sample               >> $log 2>> $log && \
mysql -uroot < $home/work/sample/sample.sql
