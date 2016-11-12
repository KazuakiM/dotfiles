#!/bin/sh
#--------------------------------
# yum setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
home=/home/vagrant
#}}}
echo "dotfiles setting..."
mkdir -p $home/work
git clone https://github.com/KazuakiM/dotfiles.git $home/work/dotfiles >> $log 2>> $log && \
ln -sf $home/work/dotfiles/.bash_logout         $home/.bash_logout                  && \
ln -sf $home/work/dotfiles/.bash_profile        $home/.bash_profile                 && \
ln -sf $home/work/dotfiles/.bashrc              $home/.bashrc                       && \
cp -f  $home/work/dotfiles/.bashrc.local        $home/                              && \
ln -sf $HOME/work/dotfiles/.cache               $HOME/.cache                        && \
ln -sf $home/work/dotfiles/.config              $home/.config                       && \
ln -sf $home/work/dotfiles/.ctags               $home/.ctags                        && \
ln -sf $home/work/dotfiles/.dir_colors          $home/.dir_colors                   && \
ln -sf $HOME/work/dotfiles/.eslintrc.js         $HOME/.eslintrc.js                  && \
ln -sf $HOME/work/dotfiles/.eslintrc.limit.js   $HOME/.eslintrc.limit.js            && \
ln -sf $home/work/dotfiles/.gitconfig.org       $home/.gitconfig                    && \
cp -f  $home/work/dotfiles/.gitconfig.local.org $home/.gitconfig.local              && \
ln -sf $home/work/dotfiles/.gvimrc              $home/.gvimrc                       && \
ln -sf $home/work/dotfiles/.inputrc             $home/.inputrc                      && \
ln -sf $home/work/dotfiles/.vim                 $home/.vim                          && \
ln -sf $home/work/dotfiles/.vimrc               $home/.vimrc                        && \
cp -f  $home/work/dotfiles/.vimrc.local         $home/                              && \
ln -sf $home/work/dotfiles/.w3m                 $home/.w3m                          && \
chown -R vagrant:vagrant $home
