#!/bin/sh
#--------------------------------
# yum setting
#
# @author KazuakiM
#--------------------------------
#variable {{{
log=/var/log/vagrantfile.log
account=$1
home="/home/$account"
#}}}
echo "dotfiles setting..."
echo "\taccount:$account"
mkdir -p $home/work
git clone https://github.com/KazuakiM/dotfiles.git $home/work/dotfiles && \
cd && \
ln -sf $home/work/dotfiles/.bash_logout         $home/.bash_logout        && \
ln -sf $home/work/dotfiles/.bash_profile        $home/.bash_profile       && \
ln -sf $home/work/dotfiles/.bashrc              $home/.bashrc             && \
cp -f  $home/work/dotfiles/.bashrc.local        $home/                    && \
ln -sf $home/work/dotfiles/.cache               $home/.cache              && \
ln -sf $home/work/dotfiles/.config              $home/.config             && \
ln -sf $home/work/dotfiles/.ctags               $home/.ctags              && \
ln -sf $home/work/dotfiles/.dir_colors          $home/.dir_colors         && \
ln -sf $home/work/dotfiles/.inputrc             $home/.inputrc            && \
ln -sf $home/work/dotfiles/.vim                 $home/.vim                && \
cp -f  $home/work/dotfiles/.vim/vimrc.local.org $home/.vim/vimrc.local    && \
ln -sf $home/work/dotfiles/.w3m                 $home/.w3m                && \
chown -R $account:$account $home && \
cd $home/work/dotfiles/.config/git && \
ln -sf config.org          config          && \
ln -sf gitconfig.local.org gitconfig.local
