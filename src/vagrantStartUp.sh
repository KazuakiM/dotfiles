#!/bin/sh
#--------------------------------
# Vagrant Start Up
#
# @author kazuakiM
#--------------------------------
# NeoBundleInstall
vim -N -u $HOME/.vimrc -c 'try | NeoBundleUpdate! | finally | qall! | endtry' -U NONE -i NONE -V1 -e -s
# Sample for Ruby on Rails
sudo firewall-cmd --add-service=rails --zone=public --permanent                                              && \
sudo systemctl restart firewalld.service                                                                     && \
sudo systemctl start mysqld.service                                                                          && \
rbenv install -v 2.2.0                                                                                       && \
rbenv rehash                                                                                                 && \
rbenv global 2.2.0                                                                                           && \
gem update --system                                                                                          && \
gem install nokogiri -- --use-system-libraries                                                               && \
gem install --no-ri --no-rdoc rails                                                                          && \
rbenv rehash
## sorcery for Ruby on Rails
#cd /srv/
#rails new sample -d mysql
#cp -f /srv/sample/Gemfile /tmp/
#ln -sf $HOME/work/sample/Gemfile /srv/sample/Gemfile
#cd /srv/sample/
#bundle update
#rails generate sorcery:install core remember_me reset_password
#rake db:migrate
#rails generate controller users
#rails generate controller session

exit 0
