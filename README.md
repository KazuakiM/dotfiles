dotfiles
===

Files are setting my development environments.

## Mac

### Install packages

AppStore
* [Growl](https://itunes.apple.com/jp/app/growl/id467939042?mt=12)
* [TweetDeck](https://itunes.apple.com/jp/app/tweetdeck-by-twitter/id485812721?mt=12)
* [Xcode](https://developer.apple.com/jp/xcode/downloads/)

homebrew
```bash
$ sudo chown -R $USER:staff /usr/local
$ xcode-select --install
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ mkdir -p $HOME/work
$ git clone https://github.com/KazuakiM/dotfiles.git $HOME/work/dotfiles
$ sudo cp -f $HOME/work/dotfiles/etc/paths /etc/paths
$ cd $HOME/work/dotfiles/lib
$ brew update
$ brew upgrade
$ brew doctor
$ brew tap Homebrew/brewdler
$ brew brewdle
$ brew doctor
$ cd /tmp
$ brew brewdle dump
$ cp -p Brewfile $HOME/work/dotfiles/lib/
$ cd $HOME/work/dotfiles/
$ git status
```

Auto start
* /Users/xxxxx/Applications/BetterTouchTool.app
* /Users/xxxxx/Applications/CheatSheet.app
* /Users/xxxxx/Applications/Google Drive.app
* /Users/xxxxx/Applications/iTerm.app
* /Users/xxxxx/Applications/KeePassX.app

[BetterTouchTool](http://www.bettertouchtool.net/)
> Application設定
>
> |大項目                                                 |少項目                            |   |
> |:------------------------------------------------------|:---------------------------------|--:|
> |Action Settings(Window Snapping etc.) > Window Snapping|                                  |   |
> |                                                       |Normal Snapping / Moving          |   |
> |                                                       |Left width                        |24%|
> |                                                       |Right width                       |76%|
> |                                                       |Corner Snapping / Move to quarters|   |
> |                                                       |Left width                        |50%|
> |                                                       |Right width                       |50%|

[CheatSheet](http://www.cheatsheetapp.com/CheatSheet/)

[Chicken](http://sourceforge.net/projects/chicken/)

[FileZilla](https://filezilla-project.org/)

[Google drive](https://drive.google.com/)

[Google 日本語IME](https://www.google.co.jp/ime/)

TODO: [GrowlNotify](http://growl.info/downloads)

[iTerm2](http://iterm2.com/)
> Application設定
>
> |Preferences > General > Preferences         |                              |
> |:-------------------------------------------|:-----------------------------|
> |Load preferences from a custom folder or URL|$HOME/work/dotfiles/lib/iTerm2|

[Karabiner](https://pqrs.org/osx/karabiner/index.html.ja)
> Application設定
>
> |大項目                                       |少項目            |     |
> |:--------------------------------------------|:-----------------|----:|
> |Key Repeat > Basic Configurations > KeyRepeat|                  |     |
> |                                             |Delay Until Repeat|200ms|
> |                                             |Key Repeat        | 25ms|

[KeePassX](http://www.keepassx.org/)

[Kindle](https://www.amazon.com/gp/digital/fiona/kcp-landing-page)

[LibreOffice](https://www.libreoffice.org/)

[LimeChat](http://limechat.net/mac/)
> Application設定
>
> |大項目                |少項目                       |              |
> |:---------------------|:----------------------------|:-------------|
> |LimeChat > Preferences|                             |              |
> |                      |Log > Show job/leave events  |チェック外し  |
> |                      |Log > Show rename events     |チェック外し  |
> |                      |Log > Log transcripts        |Trashes       |
> |                      |Theme > Current theme        |Spring Night  |
> |                      |Theme > Override log font    |[RictyDiminished](https://github.com/yascentur/RictyDiminished) 13px |
> |                      |Theme > Override input font  |[RictyDiminished](https://github.com/yascentur/RictyDiminished) 13px |
> |Server > Add Server   |                             |              |
> |                      |General > Network name       |Lingr         |
> |                      |General > Connect on start up|チェック      |
> |                      |General > Server             |localhost     |
> |                      |General > Port               |26667         |
> |                      |General > Server Password    |\* \* \* \*   |
> |                      |General > Nickname           |kazuakiM      |
> |                      |General > Login name         |kazuakiM      |
> |                      |General > Real name          |kazuakiM      |
> |                      |Details > Encoding           |UTF-8         |
> |                      |Details > Fallback encoding  |Don't Fallback|


[RictyDiminished](https://github.com/yascentur/RictyDiminished)

[夜フクロウ(Night 0wl)](https://sites.google.com/site/yorufukurou/home-en)
> Application設定
>
> |大項目                               |少項目                                            |                   |
> |:------------------------------------|:-------------------------------------------------|:------------------|
> |環境設定 > 一般                      |                                                  |                   |
> |                                     |リアルタイム更新を有効化する                      |チェック           |
> |                                     |投稿した後リストに自動フォーカスする              |チェック外し       |
> |                                     |更新時に一番上にスクロールする                    |チェック           |
> |環境設定 > アカウント                |                                                  |                   |
> |                                     |タイムラインタブを未読管理する                    |チェック外し       |
> |環境設定 > 表示                      |                                                  |                   |
> |                                     |片思いバッジを表示する                            |チェック           |
> |                                     |ミニビューを使用する                              |チェック           |
> |                                     |リストに表示する名前                              |ユーザID           |
> |環境設定 > タブ                      |                                                  |                   |
> |                                     |起動時に取得したツイートを既読状態にする          |チェック           |
> |                                     |市場鵺にスクロールした際にツイートを既読状態にする|チェック           |
> |                                     |Favoritesタブを表示する(要再起動)                 |チェック外し       |
> |環境設定 > テキスト入力              |                                                  |                   |
> |                                     |ツイート入力                                      |チェック           |
> |                                     |フォントサイズ                                    |11pt               |
> |                                     |投稿に使用するキー                                |⌘ + Return         |
> |環境設定 > 色                        |                                                  |                   |
> |                                     |リストの表示スタイル                              |ダーク             |
> |                                     |デフォルトの色設定                                |ダーク             |
> |環境設定 > 詳細                      |                                                  |                   |
> |                                     |ダブルクリック時の挙動                            |会話ビューオン/オフ|
> |                                     |ツイートのコピー形式                              |ツイートのURL      |
> |表示                                 |                                                  |                   |
> |                                     |ツールバーを表示する/隠す                         |選択               |
> |                                     |縮小                                              |選択               |
> |ツイートボックス > ⚙                 |                                                  |                   |
> |                                     |ハッシュタグを保持                                |                   |

[tunnelblick](https://code.google.com/p/tunnelblick/)

[FireFox](https://www.mozilla.org/ja/firefox/)
> Common setting

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
  * デフォルトフォント: [RictyDiminished](https://github.com/yascentur/RictyDiminished)
* add-on
  * [Adblock Plus](https://addons.mozilla.org/ja/firefox/addon/adblock-plus/)
  * [AutoPager](https://addons.mozilla.org/ja/firefox/addon/autopager/)
  * [DownThemAll!](https://addons.mozilla.org/ja/firefox/addon/downthemall/)
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
