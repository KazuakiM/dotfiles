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
rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-7                          >> $log && \
rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/7/x86_64/e/epel-release-7-5.noarch.rpm          >> $log && \
rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi                                    >> $log && \
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm                           >> $log && \
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt                                              >> $log && \
rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm >> $log && \
rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql                                           >> $log && \
rpm -ivh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm                     >> $log && \
yum clean all                                                                                  >> $log && \
yum -y --enablerepo=epel,mysql,remi,rpmforge update                                            >> $log && \
yum clean all                                                                                  >> $log && \
yum -y --enablerepo=epel,mysql,remi,rpmforge install \
    colordiff           ctags \
    gcc                 gcc-c++        git \
    htop                httpd \
    libcurl-devel       libffi-devel   libxml2-devel         libxslt-devel          libyaml-devel lynx \
    make                man-pages-ja   mysql-community-devel mysql-community-server \
    ncurses-devel       nmap-ncat \
    openssl             openssl-devel \
    perl                perl-core      perl-devel            php                    php-devel     pv python python-devel \
    readline            readline-devel ruby                  ruby-devel \
    screen              sqlite-devel \
    the_silver_searcher tmux           tree \
    wget \
    yum-cron \
    zlib-devel                                                                                 >> $log

