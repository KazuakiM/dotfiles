#!/bin/sh
#--------------------------------
# yum setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "yum install ..."
yum -y install epel-release                                                                    >> $log 2>> $log && \
rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi                                    >> $log 2>> $log && \
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm                           >> $log 2>> $log && \
yum clean all                                                                                  >> $log 2>> $log && \
yum -y --enablerepo=epel,remi update                                                           >> $log 2>> $log && \
yum clean all                                                                                  >> $log 2>> $log && \
yum -y --enablerepo=epel,remi install \
    colordiff           ctags \
    gcc                 gcc-c++        git \
    htop \
    libcurl-devel       libffi-devel   libxml2-devel libxslt-devel libyaml-devel lynx \
    make                man-pages-ja \
    ncurses-devel       nmap-ncat \
    openssl             openssl-devel \
    pv \
    readline            readline-devel \
    screen              sqlite-devel \
    the_silver_searcher tmux           tree \
    wget \
    yum-cron \
    zlib-devel                                                                                 >> $log 2>> $log
