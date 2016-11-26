#!/bin/sh
#--------------------------------
# FTP setting
#
# MEMO:This environment base is https://github.com/KazuakiM/bardiche
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
account=$1
#}}}
echo "FTP setting ..."
echo "\taccount:$account"
apt-get install -yqq proftpd                                                                            >> $log 2>> $log && \
mkdir -p /tmp/ftp                                                                                       >> $log 2>> $log && \
chmod 777 /tmp/ftp                                                                                      >> $log 2>> $log && \
echo pass | ftpasswd --file /tmp/ftpd.passwd --passwd --name fate --uid $(id -u) -gid $(id -g) --home /tmp/ftp --shell /bin/sh --stdin
ftpasswd --file /tmp/ftpd.group --group --name nogroup --gid $(id -g)
cat <<EOS > /tmp/proftpd.conf
DefaultAddress 127.0.0.1
Port 10021
AuthUserFile /tmp/ftpd.passwd
AuthGroupFile /tmp/ftpd.group
AuthOrder mod_auth_file.c
DefaultRoot /tmp/ftp
ListOptions -a
EOS
#/usr/sbin/proftpd -c /tmp/proftpd.conf -S 127.0.0.1
