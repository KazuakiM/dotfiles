dotfiles
==========
Files are setting my development environments.

# Mac

### Install packages

AppStore
* [Xcode](https://developer.apple.com/jp/xcode/downloads/)

homebrew
```bash
$ cd $HOME
$ mkdir -p work
$ xcode-select --install
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ git clone git@github.com:KazuakiM/dotfiles.git work/dotfiles
$ $HOME/work/dotfiles/lib/Brewfile
$ brew doctor
```
rbenv
```bash
$ rbenv install 2.0.0-p247
$ rbenv rehash
```
Ricty
```bash
$ git clone git@github.com:yascentur/RictyDiminished.git /tmp/RictyDiminished
$ cp -p /tmp/RictyDiminished/*.ttl $HOME/Library/Fonts/
```
[BetterTouchTool](http://www.bettertouchtool.net/)

* Action Settings(Window Snapping etc.) > Window Snapping
  * Normal Snapping / Moving:
    * Left width: 24%
    * Right width: 76%
  * Corner Snapping / Move to quarters:
    * Left width: 50%
    * Right width: 50%

[FireFox](https://www.mozilla.org/ja/firefox/)

Common setting

[Karabiner](https://pqrs.org/osx/karabiner/index.html.ja)

* Key Repeat > Basic Configurations > KeyRepeat
 * Delay Until Repeat: 200ms
 * Key Repeat: 25ms

### Set dotfiles

```bash
$ cd $HOME
$ ln -sf $HOME/work/dotfiles/.bash_logout  .bash_logout
$ ln -sf $HOME/work/dotfiles/.bash_profile .bash_profile
$ cp $HOME/work/dotfiles/.bash_profile.local .
$ ln -sf $HOME/work/dotfiles/.ctags        .ctags
$ ln -sf $HOME/work/dotfiles/.gitconfig    .gitconfig
$ cp $HOME/work/dotfiles/.gitconfig.local .
$ ln -sf $HOME/work/dotfiles/.gvimrc       .gvimrc
$ ln -sf $HOME/work/dotfiles/.htoprc       .htoprc
$ ln -sf $HOME/work/dotfiles/.inputrc      .inputrc
$ ln -sf $HOME/work/dotfiles/.mplayer      .mplayer
$ cp $HOME/work/dotfiles/.netrc.org        .netrc
$ ln -sf $HOME/work/dotfiles/.screenrc     .screenrc
$ ln -sf $HOME/work/dotfiles/.tmux.conf    .tmux.conf
$ ln -sf $HOME/work/dotfiles/.vim          .vim
$ ln -sf $HOME/work/dotfiles/.vimrc        .vimrc
$ cp $HOME/work/dotfiles/.vimrc.local .
$ ln -sf $HOME/work/dotfiles/.w3m          .w3m
$ git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
$ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp/php_manual_ja.tar.gz
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ chmod a+x $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ php $HOME/work/dotfiles/src/phpDict.php
$ vi
 Update from NeoBundleFetch to NeoBundle
 :NeoBundleInstall

 Update from NeoBundle to NeoBundleFetch

$ cd $HOME/.vim/bundle/regexper
$ bundle install
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
$ sudo rpm -ivh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
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
    htop httpd \
    libcurl-devel lynx \
    make man-pages-ja mercurial \
    ncurses-devel nmap-ncat \
    openssl openssl-devel \
    perl perl-core perl-devel php php-devel pv python python-devel \
    readline ruby ruby-devel \
    screen \
    the_silver_searcher tmux tree \
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
rbenv
```
$ git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
$ git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
$ cd /usr/local/rbenv
$ rbenv install 2.0.0-p247
$ rbenv rehash
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
$ sudo ./configure \
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
    --enable-pythoninterp \
    --with-python-config-dir=/usr/lib64/python2.7/config \
    --enable-perlinterp \
    --enable-luainterp \
    --with-lua-prefix=/usr/local \
    --with-luajit
$ sudo make && sudo make install
```
Composer
```bash
$ curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin
```

### Set dotfiles

```bash
$ cd $HOME
$ mkdir -p work
$ mkdir -p .config/htop
$ git clone git@github.com:KazuakiM/dotfiles.git work/dotfiles
$ ln -sf $HOME/work/dotfiles/.bash_logout  .bash_logout
$ ln -sf $HOME/work/dotfiles/.bash_profile .bash_profile
$ cp $HOME/work/dotfiles/.bash_profile.local .
$ ln -sf $HOME/work/dotfiles/.ctags        .ctags
$ ln -sf $HOME/work/dotfiles/.dir_color    .dir_color
$ ln -sf $HOME/work/dotfiles/.gitconfig    .gitconfig
$ cp $HOME/work/dotfiles/.gitconfig.local .
$ ln -sf $HOME/work/dotfiles/.gvimrc       .gvimrc
$ ln -sf $HOME/work/dotfiles/.htoprc       .config/htop/htoprc
$ ln -sf $HOME/work/dotfiles/.inputrc      .inputrc
$ ln -sf $HOME/work/dotfiles/.mplayer      .mplayer
$ cp $HOME/work/dotfiles/.netrc.org        .netrc
$ ln -sf $HOME/work/dotfiles/.screenrc     .screenrc
$ ln -sf $HOME/work/dotfiles/.tmux.conf    .tmux.conf
$ ln -sf $HOME/work/dotfiles/.vim          .vim
$ ln -sf $HOME/work/dotfiles/.vimrc        .vimrc
$ cp $HOME/work/dotfiles/.vimrc.local .
$ ln -sf $HOME/work/dotfiles/.w3m          .w3m
$ git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
$ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp/php_manual_ja.tar.gz
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ chmod a+x $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ php $HOME/work/dotfiles/src/phpDict.php
$ vi
 Update from NeoBundleFetch to NeoBundle
 :NeoBundleInstall

 Update from NeoBundle to NeoBundleFetch

$ cd $HOME/.vim/bundle/regexper
$ bundle install
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
$ cp $HOME/.netrc.org   $HOME/.netrc
$ php $HOME/src/phpDict.php
$ cd $HOME/.vim/bundle/regexper
$ bundle install
$ git clone git@github.com:yascentur/RictyDiminished.git /tmp/RictyDiminished
 Copy font directory

$ exit
```
alias, export情報を読み込ませるため、一旦ターミナルを閉じる
```bash
$ vi
 Update from NeoBundleFetch to NeoBundle
 :NeoBundleInstall

 Update from NeoBundle to NeoBundleFetch
```

# Common setting

### Install packages

[FireFox](https://www.mozilla.org/ja/firefox/)

* Required sync setting

* オプション > コンテンツ > フォントとカラー
  * デフォルトフォント: Ricty
* add-on
  * [Adblock Plus](https://addons.mozilla.org/ja/firefox/addon/adblock-plus/)
  * [AutoPager](https://addons.mozilla.org/ja/firefox/addon/autopager/)
  * [chaika](https://addons.mozilla.org/ja/firefox/addon/chaika/)
    * オプション > 板一覧 > 検索ボックス > デフォルト検索エンジン  
      2ch検索(ff2ch.syoboi.jp)
  * [DownThemAll!](https://addons.mozilla.org/ja/firefox/addon/downthemall/)
  * [feedly](https://addons.mozilla.org/ja/firefox/addon/feedly/)
  * [Firebug](https://addons.mozilla.org/ja/firefox/addon/firebug/)
  * [FireMobileSimulator](https://addons.mozilla.org/ja/firefox/addon/firemobilesimulator/)
  * [Growl/GNTP](https://addons.mozilla.org/ja/firefox/addon/growlgntp/)
  * [Hatena Bookmark](https://addons.mozilla.org/ja/firefox/addon/hatena-bookmark/)
  * [JSONView](https://addons.mozilla.org/ja/firefox/addon/jsonview/)
  * [nclvauto](https://addons.mozilla.org/ja/firefox/addon/nclvauto/)
  * [Quick Translator](https://addons.mozilla.org/ja/firefox/addon/quick-translator/)
  * [RESTClient](https://addons.mozilla.org/ja/firefox/addon/restclient/)
  * [ScrollyFox](https://addons.mozilla.org/ja/firefox/addon/scrollyfox/)
  * [The Addon Bar(restored)](https://addons.mozilla.org/ja/firefox/addon/the-addon-bar/?src=hp-btn-promo)
  * [Web Developer](https://addons.mozilla.org/ja/firefox/addon/web-developer/)
  * [テキストリンク](https://addons.mozilla.org/ja/firefox/addon/text-link/)

# TODO

* Try Chocolatey
