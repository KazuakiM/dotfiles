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
cp -p /tmp/rails.xml/rails.xml /usr/lib/firewalld/services/                                  >> $log 2>> $log && \
firewall-cmd --add-service=rails --zone=public --permanent                                   >> $log 2>> $log && \
systemctl restart firewalld.service                                                          >> $log 2>> $log && \
rbenv install -v 2.2.0                                                                       >> $log 2>> $log && \
rbenv rehash                                                                                 >> $log 2>> $log && \
rbenv global 2.2.0                                                                           >> $log 2>> $log && \
gem update --system                                                                          >> $log 2>> $log && \
gem install nokogiri -- --use-system-libraries                                               >> $log 2>> $log && \
gem install --no-ri --no-rdoc rails                                                          >> $log 2>> $log && \
rbenv rehash
