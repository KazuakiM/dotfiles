#!/bin/sh
#--------------------------------
# Ruby on Rails setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
account=vagrant
home="/home/$account"
#}}}
echo "Ruby on Rails Setting ..."
git clone https://github.com/sstephenson/rbenv.git            /usr/local/rbenv
git clone https://github.com/sstephenson/ruby-build.git       /usr/local/rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash.git /usr/local/rbenv/plugins/rbenv-gem-rehash
echo 'export RBENV_ROOT=/usr/local/rbenv'       >> $home/.bashrc
echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> $home/.bashrc
echo 'eval "$(rbenv init -)"'                   >> $home/.bashrc
chown -R $account:$account /usr/local
chown -R $account:$account $home
sudo -H -u vagrant bash -i -c "
    source $home/.bashrc                           && \
    rbenv install 2.2.2                            && \
    rbenv global 2.2.2                             && \
    rbenv rehash                                   && \
    gem update --system                            && \
    gem install nokogiri -- --use-system-libraries && \
    gem install --no-ri --no-rdoc rails            && \
    rbenv rehash"

#git clone https://gist.github.com/b3f0994a67e8e10fae95.git    /tmp/rails.xml
#cp -p /tmp/rails.xml/rails.xml /usr/lib/firewalld/services/
#firewall-cmd --add-service=rails --zone=public --permanent
#systemctl stop firewalld.service
