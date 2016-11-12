#!/bin/sh
#--------------------------------
# FTPS setting
#
# $ ftp -A ftp://vagrant:vagrant@192.168.1.1:2224
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "FTPS setting ..."
mkdir -p /tmp/ftp
sh ftp.sh                                                                                           >> $log 2>> $log && \
echo 'ssl_enable=YES'                                                    >> /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
echo 'rsa_cert_file=/etc/pki/tls/certs/vsftpd.pem'                       >> /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
echo 'ssl_sslv2=NO'                                                      >> /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
echo 'ssl_sslv3=NO'                                                      >> /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
echo 'ssl_tlsv1=YES'                                                     >> /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
echo 'force_local_data_ssl=YES'                                          >> /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
echo 'force_local_logins_ssl=YES'                                        >> /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
systemctl restart vsftpd.service                                                                    >> $log 2>> $log && \
echo '$ sudo openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/pki/tls/certs/vsftpd.pem -out /etc/pki/tls/certs/vsftpd.pem'
