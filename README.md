dotfiles
==============

Files are setting my development environments.

# Mac

```zsh
$ cd $HOME
$ mkdir -p work
$ git clone git@github.com:KazuakiM/dotfiles.git work/dotfiles
$ git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
$ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ php $HOME/work/shell/phpDict.php
$ vi
 :NeoBundleInstall

$ exit
```

# Linux

```bash
$ cd $HOME
$ mkdir -p work
$ git clone git@github.com:KazuakiM/dotfiles.git work/dotfiles
$ git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
$ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ chmod a+x $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ php $HOME/work/shell/phpDict.php
$ vi
 :NeoBundleInstall

$ exit
```

# Cygwin @ Windows

Environment variables
* HOME
* xxxxxx

```bash
$ cd $HOME
$ cd ..
$ ls
 <Account>

$ tar zcvf <Account>.tar.gz <Account>
$ mv <Account>.tar.gz /tmp
$ rm -rf <Account>
$ git clone git@github.com:KazuakiM/dotfiles.git <Account>
$ git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
$ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ chmod a+x $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ cp $HOME/.vimrc.local $HOME/.vimrc.win
$ php $HOME/shell/phpDict.php
$ exit
```

```bash
$ vi
 :NeoBundleInstall

$ cp $HOME/.vim/colors/jellybeans.vim /cygwin/c/path/to/path/Vim/colors/
```

# TODO

* Add Windows detail
* Add Brewfile
* Add yum management file
* Try Chocolatey
