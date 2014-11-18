dotfiles
==========
Files are setting my development environments.
# Mac

### Install packages

AppStore
* [Xcode](https://developer.apple.com/jp/xcode/downloads/)

homebrew
```bash
$ xcode-select --install
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew doctor
$ brew install git
$ brew update
$ brew upgrade
$ brew doctor
```
### Set dotfiles
```bash
$ cd $HOME
$ mkdir -p work
$ git clone git@github.com:KazuakiM/dotfiles.git work/dotfiles
$ ln -sf $HOME/work/dotfiles/.bash_logout  .bash_logout
$ ln -sf $HOME/work/dotfiles/.bash_profile .bash_profile
$ cp $HOME/work/dotfiles/.bash_profile.local .
$ ln -sf $HOME/work/dotfiles/.ctags        .ctags
$ ln -sf $HOME/work/dotfiles/.gitconfig    .gitconfig
$ cp $HOME/work/dotfiles/.gitconfig.local .
$ ln -sf $HOME/work/dotfiles/.gvimrc       .gvimrc
$ ln -sf $HOME/work/dotfiles/.mplayer      .mplayer
$ ln -sf $HOME/work/dotfiles/.vim          .vim
$ ln -sf $HOME/work/dotfiles/.vimrc        .vimrc
$ cp $HOME/work/dotfiles/.vimrc.local .
$ ln -sf $HOME/work/dotfiles/.w3m          .w3m
$ git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
$ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ php $HOME/work/shell/phpDict.php
$ vi
 :NeoBundleInstall

$ exit
```
# Linux

### Setting
```bash
$ sudo chown -R <Account>:<AccountGroup> /usr/local
```
### Install key & RPM
Check key
* [epel](http://ftp.riken.jp/Linux/fedora/epel)
* [ius](http://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY)
* [remi](http://rpms.famillecollet.com/RPM-GPG-KEY-remi)
* [rpmforge](http://apt.sw.be/RPM-GPG-KEY.dag.txt)

Usage
> example CentOS7.

```bash
$ sudo rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-7
$ sudo rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
$ sudo rpm --import http://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY
$ sudo rpm -ivh http://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-13.ius.centos7.noarch.rpm
$ sudo rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
$ sudo rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
$ sudo rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
$ sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
$ sudo rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
$ cd /etc/yum.repos.d
 Check repository.
```
### Install packages
yum
``` bash
$ sudo yum update
$ sudo yum install \
    colordiff ctags \
    gcc \
    httpd \
    libcurl-devel lynx \
    make man-pages-ja mercurial \
    ncurses-devel \
    openssl openssl-devel \
    perl-core perl-devel php php-devel python-devel \
    ruby ruby-devel \
    tree \
    wget
```
Git
```bash
$ git clone git://git.kernel.org/pub/scm/git/git.git /usr/local/src/git
$ cd /usr/local/src/git
$ make prefix=/usr/local all && make prefix=/usr/local install
```
LuaJIT
```bash
$ git clone http://luajit.org/git/luajit-2.0.git /usr/local/src/luajit
$ cd /usr/local/src/luajit
$ make && make install
```
Vim
> Check command path

```bash
$ which ruby
 /usr/bin/ruby
$ which python
 /usr/bin/python
$ find / -name "config.c" 2>&1|grep config.c
 /usr/lib64/python2.7/config/config.c
$ which perl
 /usr/bin/perl
$ find / -name "lua.h" 2>&1|grep lua.h
 /usr/local/include/luajit-2.0/lua.h
```
> Usage

```bash
$ sudo yum remove vim-enhanced vim-common
$ hg clone https://vim.googlecode.com/hg/ /usr/local/src/vim
$ cd /usr/local/src/vim
$ ./configure \
    --prefix=/usr/local \
    --enable-fail-if-missing \
    --disable-darwin \
    --disable-selinux \
    --disable-xsmp \
    --disable-xsmp-interact \
    --enable-cscope \
    --disable-netbeans \
    --enable-multibyte \
    --disable-xim \
    --enable-fontset \
    --with-features=huge \
    --enable-rubyinterp \
    --with-ruby-command=/usr/bin/ruby \
    --enable-python3interp \
    --with-python3-config-dir=/usr/lib64/python2.7/config \
    --enable-perlinterp \
    --enable-luainterp \
    --with-lua-prefix=/usr/local \
    --with-luajit
$ make && make install
```
Composer
```bash
$ curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin
```
### Set dotfiles
```bash
$ cd $HOME
$ mkdir -p work
$ git clone git@github.com:KazuakiM/dotfiles.git work/dotfiles
$ ln -sf $HOME/work/dotfiles/.bash_logout  .bash_logout
$ ln -sf $HOME/work/dotfiles/.bash_profile .bash_profile
$ cp $HOME/work/dotfiles/.bash_profile.local .
$ ln -sf $HOME/work/dotfiles/.ctags        .ctags
$ ln -sf $HOME/work/dotfiles/.gitconfig    .gitconfig
$ cp $HOME/work/dotfiles/.gitconfig.local .
$ ln -sf $HOME/work/dotfiles/.gvimrc       .gvimrc
$ ln -sf $HOME/work/dotfiles/.mplayer      .mplayer
$ ln -sf $HOME/work/dotfiles/.vim          .vim
$ ln -sf $HOME/work/dotfiles/.vimrc        .vimrc
$ cp $HOME/work/dotfiles/.vimrc.local .
$ ln -sf $HOME/work/dotfiles/.w3m          .w3m
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
# Windows

### Install packages

Cygwin
### Set environment variables
* HOME
* C:\cygwin64\home\<Account>

### Operate Cygwin
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
* Try Chocolatey
