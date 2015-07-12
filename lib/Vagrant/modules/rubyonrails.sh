#!/bin/sh
#--------------------------------
# Ruby on Rails setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "Ruby on Rails Setting ..."
git clone https://github.com/sstephenson/rbenv.git      /usr/local/rbenv                     >> $log 2>> $log && \
git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build  >> $log 2>> $log && \
git clone https://gist.github.com/b3f0994a67e8e10fae95.git /tmp/rails.xml                    >> $log 2>> $log && \
git clone https://gist.github.com/2f5b562e0ffe337c8fec.git $HOME/work/sample                 >> $log 2>> $log && \
cp -p /tmp/rails.xml/rails.xml /usr/lib/firewalld/services/                                  >> $log 2>> $log && \
systemctl start mysqld.service                                                               >> $log 2>> $log && \
mysql -uroot < $HOME/work/sample/sample.sql

