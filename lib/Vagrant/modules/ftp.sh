#!/bin/sh
#--------------------------------
# FTP setting
#
# $ ftp -A ftp://vagrant:vagrant@192.168.1.1:2224
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "FTP setting ..."
mkdir -p /tmp/ftp
yum -y --enablerepo=epel,remi install vsftpd                                                                            >> $log 2>> $log && \
systemctl enable vsftpd.service                                                                                         >> $log 2>> $log && \
firewall-cmd --add-service=ftp --permanent                                                                              >> $log 2>> $log && \
firewall-cmd --reload                                                                                                   >> $log 2>> $log && \
sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g'                                           /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/local_umask/#local_umask/g'                                                           /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/#xferlog_file/xferlog_file/g'                                                         /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/#ascii_upload_enable=YES/ascii_upload_enable=YES/g'                                   /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/#ascii_download_enable=YES/ascii_download_enable=YES/g'                               /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g'                                       /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/#chroot_list_enable=YES/chroot_list_enable=YES/g'                                     /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's:#chroot_list_file=/etc/vsftpd/chroot_list:chroot_list_file=/etc/vsftpd/chroot_list:g' /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/listen=NO/listen=YES/g'                                                               /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i 's/listen_ipv6=YES/listen_ipv6=NO/g'                                                     /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i '$ a allow_writeable_chroot=YES'                                                         /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i '$ a local_root=/tmp/ftp'                                                                /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i '$ a ls_recurse_enable=YES'                                                              /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i '$ a pasv_enable=NO'                                                                     /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
sed -i '$ a use_localtime=YES'                                                                  /etc/vsftpd/vsftpd.conf >> $log 2>> $log && \
echo '' >                                                                                       /etc/vsftpd/chroot_list >> $log 2>> $log && \
sed -i '$ a vagrant'                                                                            /etc/vsftpd/chroot_list >> $log 2>> $log && \
systemctl restart vsftpd.service                                                                                        >> $log 2>> $log
