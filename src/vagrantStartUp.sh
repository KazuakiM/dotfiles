#!/bin/sh
#--------------------------------
# Vagrant Start Up
#
# @author kazuakiM
#--------------------------------
# NeoBundleInstall
vim -N -u $HOME/.vimrc -c 'try | NeoBundleUpdate! | finally | qall! | endtry' -U NONE -i NONE -V1 -e -s
# Ruby on Rails
sudo firewall-cmd --add-service=rails --zone=public --permanent && \
sudo systemctl restart firewalld.service                        && \
sudo systemctl start mysqld.service                             && \
rbenv install -v 2.2.0                                          && \
rbenv rehash                                                    && \
rbenv global 2.2.0                                              && \
gem update --system                                             && \
gem install nokogiri -- --use-system-libraries                  && \
gem install --no-ri --no-rdoc rails                             && \
rbenv rehash
# Sample for Ruby on Rails
cd /srv/                                             && \
rails new sample -d mysql                            && \
cp -f /srv/sample/Gemfile /tmp/                      && \
ln -sf $HOME/work/sample/Gemfile /srv/sample/Gemfile && \
cd /srv/sample/                                      && \
bundle update
# Setting sorcery
#rails generate sorcery:install
#rake db:migrate
#rails generate scaffold user email:string crypted_password:string salt:string --migration false
#rails generate controller UserSessions new create destroy

exit 0
