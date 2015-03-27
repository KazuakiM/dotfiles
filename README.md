dotfiles
===

Files are setting my development environments.

## Mac

### Install packages

AppStore
> [Xcode](https://developer.apple.com/jp/xcode/downloads/)

homebrew
```bash
$ xcode-select --install
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ mkdir -p $HOME/work
$ git clone https://github.com/KazuakiM/dotfiles.git $HOME/work/dotfiles
$ brew bundle $HOME/work/dotfiles/lib/Brewfile

  (Important)I don't execute Brewfile. So I'll commentout a lot of code and execute a few code next to next.

$ brew doctor
```

Ricty
```bash
$ git clone https://github.com/yascentur/RictyDiminished.git /tmp/RictyDiminished
$ cp -f /tmp/RictyDiminished/*.ttl $HOME/Library/Fonts/
```

[BetterTouchTool](http://www.bettertouchtool.net/)
> |Action Settings(Window Snapping etc.) > Window Snapping|   |
> |:------------------------------------------------------|:--|
> |Normal Snapping / Moving                               |   |
> |Left width                                             |24%|
> |Right width                                            |76%|
> |Corner Snapping / Move to quarters                     |   |
> |Left width                                             |50%|
> |Right width                                            |50%|

[FireFox](https://www.mozilla.org/ja/firefox/)
> Common setting

[Karabiner](https://pqrs.org/osx/karabiner/index.html.ja)
> |Key Repeat > Basic Configurations > KeyRepeat|     |
> |:--------------------------------------------|:----|
> |Delay Until Repeat                           |200ms|
> |Key Repeat                                   | 25ms|

[iTerm2](http://iterm2.com/)
> |Preferences > General > Preferences         |                              |
> |:-------------------------------------------|:-----------------------------|
> |Load preferences from a custom folder or URL|$HOME/work/dotfiles/lib/iTerm2|

### Set dotfiles

```bash
$ ln -sf $HOME/work/dotfiles/.bash_logout        $HOME/.bash_logout
$ ln -sf $HOME/work/dotfiles/.bash_profile       $HOME/.bash_profile
$ cp -f  $HOME/work/dotfiles/.bash_profile.local $HOME/
$ ln -sf $HOME/work/dotfiles/.ctags              $HOME/.ctags
$ ln -sf $HOME/work/dotfiles/.gitconfig          $HOME/.gitconfig
$ cp -f  $HOME/work/dotfiles/.gitconfig.local    $HOME/
$ ln -sf $HOME/work/dotfiles/.gvimrc             $HOME/.gvimrc
$ ln -sf $HOME/work/dotfiles/.htoprc             $HOME/.htoprc
$ ln -sf $HOME/work/dotfiles/.inputrc            $HOME/.inputrc
$ ln -sf $HOME/work/dotfiles/.mplayer            $HOME/.mplayer
$ cp -f  $HOME/work/dotfiles/.netrc.org          $HOME/.netrc
$ ln -sf $HOME/work/dotfiles/.screenrc           $HOME/.screenrc
$ ln -sf $HOME/work/dotfiles/.tmux.conf          $HOME/.tmux.conf
$ ln -sf $HOME/work/dotfiles/.vim                $HOME/.vim
$ ln -sf $HOME/work/dotfiles/.vimrc              $HOME/.vimrc
$ cp -f  $HOME/work/dotfiles/.vimrc.local        $HOME/
$ ln -sf $HOME/work/dotfiles/.w3m                $HOME/.w3m
$ mkdir -p /srv/vagrant
$ ln -sf $HOME/work/dotfiles/lib/Vagrantfile /srv/vagrant/Vagrantfile
$ git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
$ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp/php_manual_ja.tar.gz
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ chmod a+x $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
$ php $HOME/work/dotfiles/src/phpDict.php
$ sh $HOME/work/dotfiles/src/htmlReference.sh
$ sh $HOME/.vim/bundle/neobundle.vim/bin/neoinstall
```

### Vagrant

```bash
$ cd /srv/vagrant
$ vagrant up
$ vagrant ssh
```

## Linux

I made Vagrantfile.

## Windows

### Install packages

> Cygwin

### Set environment variables

|Name|Value                     |
|:---|:-------------------------|
|HOME|C:\cygwin64\home\<Account>|

### Operate Cygwin

> ```bash
> $ cd $HOME/..
> $ tar zcvf <Account>.tar.gz <Account>
> $ mv <Account>.tar.gz /tmp
> $ rm -rf <Account>
> $ git clone https://github.com/KazuakiM/dotfiles.git <Account>
> $ git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
> $ wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp
> $ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
> $ wget http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
> $ chmod a+x $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
> $ cp -f $HOME/.vimrc.local $HOME/.vimrc.win
> $ cp -f $HOME/.netrc.org   $HOME/.netrc
> $ php $HOME/src/phpDict.php
> $ sh $HOME/src/htmlReference.sh
> $ sh $HOME/.vim/bundle/neobundle.vim/bin/neoinstall
> $ git clone https://github.com/yascentur/RictyDiminished.git /tmp/RictyDiminished
>  Copy font directory
>
> $ exit
> ```

## Common setting

### Install packages

[FireFox](https://www.mozilla.org/ja/firefox/)

* Required sync setting

* オプション > コンテンツ > フォントとカラー
  * デフォルトフォント: [Ricty](https://github.com/yascentur/RictyDiminished)
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

## TODO

* Try Chocolatey
