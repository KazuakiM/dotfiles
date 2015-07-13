#!/bin/sh
#--------------------------------
# Vim setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
#}}}
echo "Vim install ..."
git clone https://github.com/vim/vim.git /usr/local/src/vim                                        >> $log 2>> $log && \
cd /usr/local/src/vim/                                                                                              && \
ln -s /usr/local/bin/luajit /usr/bin/luajit                                                                         && \
./configure --disable-darwin --disable-netbeans --disable-selinux --disable-xim --disable-xsmp --disable-xsmp-interact --enable-cscope \
  --enable-fail-if-missing --enable-fontset --enable-luainterp --enable-multibyte --enable-rubyinterp --enable-perlinterp --enable-pythoninterp \
  --prefix=/usr/local --with-features=huge --with-ruby-command=/usr/bin/ruby --with-python-config-dir=/usr/lib64/python2.7/config --with-luajit \
  --with-lua-prefix=/usr/local                                                                     >> $log 2>> $log && \
make                                                                                               >> $log 2>> $log && \
make install                                                                                       >> $log 2>> $log

