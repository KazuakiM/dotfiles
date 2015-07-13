#!/bin/sh
#--------------------------------
# Apache setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "Apache setting ..."
yum -y --enablerepo=epel,remi,rpmforge install httpd       >> $log 2>> $log && \
firewall-cmd --add-service=http --zone=public --permanent  >> $log 2>> $log && \
systemctl restart firewalld.service                        >> $log 2>> $log && \
systemctl enable httpd.service                             >> $log 2>> $log && \
systemctl restart httpd.service
