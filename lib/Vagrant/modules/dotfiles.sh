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
mkdir -p $home/work $home/.config/htop                                                                                   && \
git clone https://github.com/KazuakiM/dotfiles.git $home/work/dotfiles                                  >> $log 2>> $log && \
ln -sf $home/work/dotfiles/.bash_logout         $home/.bash_logout                                                       && \
ln -sf $home/work/dotfiles/.bash_profile        $home/.bash_profile                                                      && \
ln -sf $home/work/dotfiles/.bashrc              $home/.bashrc                                                            && \
cp -f  $home/work/dotfiles/.bashrc.local        $home/                                                                   && \
ln -sf $home/work/dotfiles/.ctags               $home/.ctags                                                             && \
ln -sf $home/work/dotfiles/.dir_colors          $home/.dir_colors                                                        && \
ln -sf $home/work/dotfiles/.gitconfig.org       $home/.gitconfig                                                         && \
cp -f  $home/work/dotfiles/.gitconfig.local.org $home/.gitconfig.local                                                   && \
ln -sf $home/work/dotfiles/.gvimrc              $home/.gvimrc                                                            && \
ln -sf $home/work/dotfiles/.htoprc              $home/.config/htop/htoprc                                                && \
ln -sf $home/work/dotfiles/.inputrc             $home/.inputrc                                                           && \
ln -sf $home/work/dotfiles/.mplayer             $home/.mplayer                                                           && \
cp -f  $home/work/dotfiles/.netrc.org           $home/.netrc                                                             && \
ln -sf $home/work/dotfiles/.screenrc            $home/.screenrc                                                          && \
ln -sf $home/work/dotfiles/.tmux.conf           $home/.tmux.conf                                                         && \
ln -sf $home/work/dotfiles/.vim                 $home/.vim                                                               && \
ln -sf $home/work/dotfiles/.vimrc               $home/.vimrc                                                             && \
cp -f  $home/work/dotfiles/.vimrc.local         $home/                                                                   && \
ln -sf $home/work/dotfiles/.w3m                 $home/.w3m                                                               && \
git clone https://github.com/Shougo/neobundle.vim.git $home/.vim/bundle/neobundle.vim                   >> $log 2>> $log && \
vim -N -u $home/.vimrc -c 'try | NeoBundleUpdate! | finally | qall! | endtry' -U NONE -i NONE -V1 -e -s >> $log 2>> $log && \
wget http://jp2.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp/php_manual_ja.tar.gz          >> $log 2>> $log && \
tar zxvf /tmp/php_manual_ja.tar.gz -C $home/.vim/vim-ref                                                >> $log 2>> $log && \
wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $home/.vim/vim-php-cs-fixer/php-cs-fixer         >> $log 2>> $log && \
chmod a+x $home/.vim/vim-php-cs-fixer/php-cs-fixer                                                                       && \
php $home/work/dotfiles/src/phpDict.php                                                                                  && \
sh $home/work/dotfiles/src/htmlReference.sh                                                             >> $log 2>> $log

