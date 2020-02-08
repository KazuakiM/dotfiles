dotfiles
===

Files are setting my development environments.

## Mac

### sudo

```bash
$ pwd
/Users/<Account>
$ sudo visudo

   <Account> ALL=(root) NOPASSWD: /usr/local/bin/htop,/usr/bin/find
```

### Install packages

App
* [BetterTourchTool](https://www.boastr.net/downloads/)
* [Growl](https://itunes.apple.com/jp/app/growl/id467939042)
* [LINE](https://itunes.apple.com/jp/app/line/id539883307)
* [TweetDeck](https://itunes.apple.com/jp/app/tweetdeck-by-twitter/id485812721)
* [Wireshark](https://www.wireshark.org/download.html)
* [Xcode](https://itunes.apple.com/jp/app/xcode/id497799835)
* [Xperia Companion](http://www.sonymobile.co.jp/support/software/xperia-companion/)

[homebrew](https://brew.sh/index_ja.html)
```bash
$ sudo chown -R $USER:staff /usr/local
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ mkdir -p $HOME/work
$ git clone https://github.com/KazuakiM/dotfiles.git $HOME/work/dotfiles
$ sudo cp -f $HOME/work/dotfiles/etc/paths /etc/paths
$ cd $HOME/work/dotfiles/lib/Homebrew/
$ brew update
$ brew upgrade
$ brew doctor

$ open -a safari "https://gist.github.com/KazuakiM/a689e22ebd22e02fdbd2fdd878d12900"

$ brew doctor
$ cd /tmp
$ brew bundle dump
$ cp -p Brewfile $HOME/work/dotfiles/lib/Homebrew/
$ cd $HOME/work/dotfiles/
$ git status
```

Auto start
* ~/Applications/Alfred 3.app
* ~/Applications/BetterTouchTool.app
* ~/Applications/CheatSheet.app
* ~/Applications/Google Drive.app
* ~/Applications/Growl.app
* ~/Applications/iTerm.app
* ~/Applications/KeePassX.app
* ~/Applications/LINE.app
* ~/Applications/スティッキーズ

License
> * BetterTouchTool

Dock
> Disabled none using app.

システム環境設定
> | 大項目                         | 小項目                                                  |                                     |
> |:-------------------------------|:--------------------------------------------------------|------------------------------------:|
> | 一般                           |                                                         |                                     |
> |                                | サイドバーのアイコンサイズ                              | 小                                  |
> |                                | アプリケーションを終了するときにウィンドウを閉じる      | チェック外し                        |
> | デスクトップとスクリーンセーバ |                                                         |                                     |
> |                                | 開始までの時間                                          | 開始しない                          |
> | Dock                           |                                                         |                                     |
> |                                | サイズ                                                  | 適当に小さく                        |
> |                                | 拡大                                                    | 適当に大きく                        |
> |                                | Dockを自動的に隠す/表示                                 | チェック                            |
> | Mission Control                |                                                         |                                     |
> |                                | 最新の使用状況に基づいて操作スペースを自動的に並び替える| チェック外し                        |
> | 省エネルギー                   |                                                         |                                     |
> |                                | ディスプレイをオフにするまでの時間                      | しない                              |
> | キーボード                     |                                                         |                                     |
> |                                | キーのリピート                                          | 速い                                |
> |                                | リピート入力認識までの時間                              | 速い                                |
> |                                | メニューバーにキーボードビューアと絵文字ビューアを表示  | 速い                                |
> |                                | 修飾キー > Caps Lock                                    | Control                             |
> | トラックパッド                 |                                                         |                                     |
> |                                | ポイントとクリック > 調べる&データ検出                  | 無効                                |
> |                                | ポイントとクリック > 副ボタンのクリック                 | 2本指でクリックまたはタップ         |
> |                                | ポイントとクリック > タップでクリック                   | 1本指でタップ                       |
> |                                | ポイントとクリック > クリック & 軌跡の速さ              | 速い                                |
> |                                | その他のジェスチャ > ページ間をスワイプ                 | チェック外し                        |
> |                                | その他のジェスチャ > アプリケーションExpose             | チェック                            |
> |                                | その他のジェスチャ > デスクトップを表示                 | チェック外し                        |
> | iCloud                         |                                                         |                                     |
> |                                | 写真 > オプション                                       | 全チェック外し                      |
> |                                | 連絡先                                                  | チェック外し                        |
> |                                | カレンダー                                              | チェック外し                        |
> |                                | リマインダー                                            | チェック外し                        |
> |                                | Safari                                                  | チェック外し                        |
> |                                | メモ                                                    | チェック外し                        |
> |                                | Macを探す                                               | チェック外し                        |
> | App Store                      |                                                         |                                     |
> |                                | 設定 & ロック                                           | 適切に設定してロック                |
> | Bluetooth                      |                                                         |                                     |
> |                                | メニューバーにBluetoothを表示                           | チェック                            |
> | 機能拡張                       |                                                         |                                     |
> |                                | 共有メニュー                                            | 全チェック外し                      |
> |                                | 今日                                                    | iTunes                              |
> |                                |                                                         | 天気                                |
> |                                |                                                         | 計算機                              |
> | 共有                           |                                                         |                                     |
> |                                | コンピュータ名                                          | イカした名前                        |
> | ユーザとグループ               |                                                         |                                     |
> |                                | アイコン画像                                            | GitHubからDLして、ドラッグ&ドロップ |
> | 日付と時刻                     |                                                         |                                     |
> |                                | 時計 > 日付を表示                                       | チェック                            |


Finder
> 環境設定
>
> | 大項目                             | 小項目                                                   |                               |
> |:-----------------------------------|:---------------------------------------------------------|------------------------------:|
> | 一般                               |                                                          |                               |
> |                                    | デスクトップに表示する項目                               | 全チェック外し                |
> |                                    | 新規Finderウィンドウで次を表示                           | デスクトップ                  |
> | タグ                               |                                                          |                               |
> |                                    | サイドバーに表示するタグ                                 | 全チェック削除                |
> | サイドバー                         |                                                          |                               |
> |                                    | マイファイル                                             | チェック外し                  |
> |                                    | AirDrop                                                  | チェック外し                  |
> |                                    | ホーム                                                   | チェック                      |
> |                                    | 共有                                                     | 全チェック外し                |
> |                                    | PC名                                                     | チェック                      |
> |                                    | 外部ディスク                                             | チェック外し                  |
> |                                    | CD、DVD、およびiPad                                      | チェック外し                  |
> |                                    | タグ                                                     | チェック外し                  |
> | 詳細                               |                                                          |                               |
> |                                    | すべてのファイル名拡張子を表示                           | チェック                      |

[Alfred](http://www.alfredapp.com/)
> Application設定
>
> |大項目     |小項目                            |                        |
> |:----------|:---------------------------------|-----------------------:|
> |Preferences|                                  |                        |
> |           |General >Where are you            |Japan                   |
> |           |詳細 > デフォルトのエンコーディング |Unicode(UTF-8)        |
> |Features   |                                  |                        |
> |           |Default Results > Essentials > Bookmarks - Safari |Check   |

[BetterTouchTool](http://www.bettertouchtool.net/)
> Application設定
>
> |大項目                                                 |小項目                            |   |
> |:------------------------------------------------------|:---------------------------------|--:|
> |Advanced > Advanced Settings > Window Snapping         |                                  |   |
> |                                                       |Normal Snapping / Moving          |   |
> |                                                       |Left width                        |24%|
> |                                                       |Right width                       |76%|
> |                                                       |Corner Snapping / Move to quarters|   |
> |                                                       |Left width                        |50%|
> |                                                       |Right width                       |50%|

[CheatSheet](http://www.cheatsheetapp.com/CheatSheet/)

[Chicken](http://sourceforge.net/projects/chicken/)

[FileZilla](https://filezilla-project.org/)

[FireFox](https://www.mozilla.org/ja/firefox/)
> Common setting

[GIMP](http://www.gimp.org)

[Google Chrome](https://www.google.com/chrome/)
> Common setting

[Google drive](https://drive.google.com/)

[Google 日本語IME](https://www.google.co.jp/ime/)
システム環境設定
> | 大項目    | 小項目    |                       |
> |:----------|:----------|----------------------:|
> | キーボード|           |                       |
> |           | 入力ソース| 英数(Google) 追加     |
> |           |           | ひらがな(Google) 追加 |
> |           |           | 日本語 削除           |

メニューバー
> | 大項目    | 小項目                         |                   |
> |:----------|:-------------------------------|------------------:|
> | 辞書ツール|                                |                   |
> |           | 管理 > 選択した辞書にインポート| Google Drive 参照 |

TODO: [GrowlNotify](http://growl.info/downloads)

iThunes
> 環境設定
>
> |大項目                             |小項目                                      |                              |
> |:----------------------------------|:-------------------------------------------|:-----------------------------|
> |一般                               |                                            |                              |
> |                                   |リストのサイズ                              |小                            |
> |                                   |すべての曲変更をセンター通知に残す          |チェック                      |
> |再生                               |                                            |                              |
> |                                   |音量を自動調整                              |チェック                      |
> |ダウンロード                       |                                            |                              |
> |                                   |ミュージック                                |チェックし、それ以外を解除    |

[iTerm2](http://iterm2.com/)
> Application設定
>
> |大項目                             |小項目                                      |                              |
> |:----------------------------------|:-------------------------------------------|:-----------------------------|
> |Preferences > General > Preferences|                                            |                              |
> |                                   |Load preferences from a custom folder or URL|$HOME/work/dotfiles/lib/iTerm2|
> |Preferences > Keys > Key Mappings  |                                            |                              |
> |                                   |⌘w                                          |Ignore                        |

[KeyCast](https://github.com/cho45/KeyCast)
> Application設定
>
> |大項目               |小項目|                                                                    |
> |:--------------------|:-----|-------------------------------------------------------------------:|
> |KeyCast > Preferences|      |                                                                    |
> |                     |Width |300                                                                 |
> |                     |Height|200                                                                 |
> |                     |Font  |[RictyDiminished](https://github.com/yascentur/RictyDiminished) 15px|

[KeePassX](http://www.keepassx.org/)
> Preferences
>
> |大項目                |小項目 |                                                                    |
> |:---------------------|:------|-------------------------------------------------------------------:|
> |KeePassX > Preferences|       |                                                                    |
> |                      |一般(1)|全チェック                                                          |
> |                      |言語   |日本語(日本)                                                        |

[Kindle](https://www.amazon.com/gp/digital/fiona/kcp-landing-page)

[LINE](https://itunes.apple.com/jp/app/line/id539883307)
複数PCからのログインブロックの機構があるため、要注意
> 設定
>
> |大項目  |小項目              |               |
> |:-------|:-------------------|:--------------|
> |基本設定|同じウィンドウで開く|チェック       |
> |通知    |サウンドの通知      |チェック外し   |
> |トーク  |サイズ              |小             |
> |トーク  |送信方法            |Command + Enter|

[RictyDiminished](https://github.com/yascentur/RictyDiminished)

[Safari](https://www.apple.com/jp/safari/)
> Application設定
>
> |大項目           |小項目                                                                             |                                        |
> |:----------------|:----------------------------------------------------------------------------------|:---------------------------------------|
> |Safari > 環境設定|                                                                                   |                                        |
> |                 |一般 > 新規ウィンドウを開く場合                                                    |ホームページ                            |
> |                 |一般 > 新規タブを開く場合                                                          |空のページ                              |
> |                 |一般 > ホームページ                                                                |file:///file/to/path/bookmark.html      |
> |ブックマーク     |ホームページの内容をブックマークに登録する([Alfred](http://www.alfredapp.com/)利用)|                                        |

[Skitch](http://evernote.com/skitch/)
> Application設定
>
> |大項目           |小項目                                       |              |
> |:----------------|:--------------------------------------------|:-------------|
> |Skitch > 環境設定|                                             |              |
> |                 |一般設定 > Skitch Helper                     |全チェック外し|
> |                 |同期 > 新しい Skitch ノートを Evernote に保存|手動          |
> |                 |同期 > Evernote との動機頻度                 |手動          |

[Sony Ericsson Bridge for Mac](http://support.sonymobile.com/au/tools/bridge-for-mac/)

[The Unarchiver](http://unarchiver.c3.cx/)

[tunnelblick](https://tunnelblick.net/)

### Set dotfiles

```bash
$ cd $HOME
$ ln -sf $HOME/work/dotfiles/.bash_logout         $HOME/.bash_logout
$ ln -sf $HOME/work/dotfiles/.bash_profile        $HOME/.bash_profile
$ ln -sf $HOME/work/dotfiles/.bashrc              $HOME/.bashrc
$ cp -f  $HOME/work/dotfiles/.bashrc.local        $HOME/
$ ln -sf $HOME/work/dotfiles/.cache               $HOME/.cache
$ ln -sf $HOME/work/dotfiles/.config              $HOME/.config
$ ln -sf $HOME/work/dotfiles/.ctags.d             $HOME/.ctags.d
$ ln -sf $HOME/work/dotfiles/.curlrc              $HOME/.curlrc
$ ln -sf $HOME/work/dotfiles/.config/docker       $HOME/.docker
$ cd $HOME/.config/git && ln -sf config.org          config
$ cd $HOME/.config/git && ln -sf gitconfig.local.org gitconfig.local
$ cd $HOME
$ ln -sf $HOME/work/dotfiles/.lib                 $HOME/.lib
$ ln -sf $HOME/work/dotfiles/.local               $HOME/.local
$ ln -sf $HOME/work/dotfiles/.log                 $HOME/.log
$ ln -sf $HOME/work/dotfiles/.ssh                 $HOME/.ssh
$ cp -f  $HOME/.ssh/config.mac                    $HOME/.ssh/config
$ ln -sf $HOME/work/dotfiles/.vim                 $HOME/.vim
$ cp -f  $HOME/work/dotfiles/.vim/vimrc.local.org $HOME/.vim/vimrc.local
$ ln -sf $HOME/work/dotfiles/.w3m                 $HOME/.w3m
$ ln -sf $HOME/work/dotfiles/.zshrc               $HOME/.zshrc
$ ln -sf $HOME/work/dotfiles/go                   $HOME/go
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $HOME/installer.sh
$ sh $HOME/installer.sh $HOME/.vim/dein.vim/
$ rm $HOME/installer.sh
$ go get -u github.com/nsf/gocode
$ go get -u github.com/alecthomas/gometalinter
$ gometalinter --install
#MEMO: https://github.com/KazuakiM/dotfiles/blob/master/.vim/memolist.vim/git.markdown#tips
$ ssh-keygen -t rsa -b 4096 -C "xxxx@xxx"
$ ssh-keygen -l -f $HOME/.ssh/id_rsa.pub
$ pbcopy < $HOME/.ssh/id_rsa.pub

> Add SSH Key
>  https://github.com/settings/keys

$ ssh -T git@github.com
$ ssh-add -K $HOME/.ssh/id_rsa.pub
$ wget http://jp2.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp/php_manual_ja.tar.gz
$ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
$ php $HOME/work/dotfiles/src/phpDict.php
$ sh $HOME/work/dotfiles/src/htmlReference.sh
$ exit
```

### Composer

```bash
$ php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin
$ composer global update
```
### npm

```bash
$ npm install -g
```

### Vagrant

```bash
$ cd /srv/vagrant
$ vagrant plugin install vagrant-cachier
$ vagrant plugin install vagrant-vbguest
$ vagrant up
$ vagrant ssh-config > ssh.config
$ scp -P 2222 -F /srv/vagrant/ssh.config /tmp/<file> default:/tmp/
$ scp -P 2222 -F /srv/vagrant/ssh.config default:/tmp/<file> /tmp/
```

### sudo

```bash
$ which htop
/usr/local/bin/htop
$ which find
/usr/bin/find
$ sudo visudo

   <Account> ALL=(root) NOPASSWD: /usr/local/bin/htop,/usr/bin/find
```

## Linux

I made Vagrantfile.

## Windows

### CMD

```
mkdir C:\usr\local\bin
```

### Install packages

> * [Cygwin](https://cygwin.com/install.html)
>  * tar
>  * gnupg
>  * gawk
>  * wget
> * [Executor](http://executor.dk/)
> * [FireFox](https://www.mozilla.org/ja/firefox/new/)
> * [Chrome](https://www.google.co.jp/chrome/browser/desktop/index.html)
> * [Kaoriya-Vim](http://www.kaoriya.net/software/vim/)
> * [Wireshark](https://www.wireshark.org/download.html)
> * [Sizer](http://www.brianapps.net/sizer/)
> * [WinMerge](http://www.geocities.co.jp/SiliconValley-SanJose/8165/winmerge.html)
> * [JSONViewer](http://jsonviewer.codeplex.com/)
> * [X-Finder](http://www.vector.co.jp/soft/win95/util/se320392.html)
> * [SQLFix](http://www.vector.co.jp/soft/dl/win95/business/se266921.html)
> * [XMLFix](http://www.vector.co.jp/soft/dl/winnt/net/se342840.html)
> * [Poderosa](https://osdn.jp/projects/sfnet_poderosa/)
> * [FileZilla](https://osdn.jp/projects/filezilla/)

### Set environment variables

|Name|Value                     |
|:---|:-------------------------|
|HOME|C:\cygwin64\home\<Account>|

### Operate Cygwin

TODO:wgetオプションの確認  
TODO:apt-cygのインストール状況を確認'apt-cyg show'
> ```bash
> $ cd /cygdrive/c/usr/local/bin/Poderosa/Protocols/Cygterm
> $ make
> $ wget https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg -O /usr/local/bin
> $ chmod 0755 /usr/local/bin/apt-cyg
> $ wget https://raw.githubusercontent.com/KazuakiM/dotfiles/master/lib/Cygwin/aptCyg.sh -O /tmp
> $ sh /tmp/aptCyg.sh
> $ cd $HOME/..
> $ tar zcvf <Account>.tar.gz <Account>
> $ mv <Account>.tar.gz /tmp
> $ rm -rf <Account>
> $ git clone https://github.com/KazuakiM/dotfiles.git <Account>
> $ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
> $ sh ./installer.sh $HOME/.vim/dein.vim/
> $ rm installer.sh
> $ ssh-keygen -t rsa -b 4096 -C "xxxx@xxx"
> $ cd $HOME/.config/git && ln -sf config.org          config
> $ cd $HOME/.config/git && ln -sf gitconfig.local.org gitconfig.local
>  Update local setting.
>
> $ wget http://jp2.php.net/distributions/manual/php_manual_ja.tar.gz -O /tmp
> $ tar zxvf /tmp/php_manual_ja.tar.gz -C $HOME/.vim/vim-ref
> $ wget http://get.sensiolabs.org/php-cs-fixer.phar -O $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
> $ chmod a+x $HOME/.vim/vim-php-cs-fixer/php-cs-fixer
> $ php $HOME/src/phpDict.php
> $ sh $HOME/src/htmlReference.sh
> $ git clone https://github.com/yascentur/RictyDiminished.git /tmp/RictyDiminished
>  Copy font directory
>
> $ exit
> ```

## Common setting

### Install packages

[Google Chrome](https://www.google.com/chrome/)
> Application設定
>
> |大項目                |小項目                                             |                                                                         |
> |:---------------------|:--------------------------------------------------|:------------------------------------------------------------------------|
> |Required sync setting |                                                   |                                                                         |
> |Chrome > 環境設定     |                                                   |                                                                         |
> |                      |設定 > デザイン > ホームボタンを表示する           |check                                                                    |
> |                      |設定 > デザイン > ホームボタンを表示する > 変更する|file:///file/to/path/bookmark.html                                       |
> |拡張機能              |                                                   |                                                                         |
> |                      |[Awesome Screenshot](https://chrome.google.com/webstore/detail/awesome-screenshot-screen/alelhddbbhepgpmgidjdcjakblofbmce)  ||
> |                      |[Text Link Plus](https://chrome.google.com/webstore/detail/text-link/ikfmghnmgeicocakijcebpkmbfljnogk)                      ||
> |                      |[User-Agent Switcher](https://chrome.google.com/webstore/detail/user-agent-switcher/lkmofgnohbedopheiphabfhfjgkhfcgf)       ||
> |                      |[はてなブックマーク](https://chrome.google.com/webstore/detail/%E3%81%AF%E3%81%A6%E3%81%AA%E3%83%96%E3%83%83%E3%82%AF%E3%83%9E%E3%83%BC%E3%82%AF-googlechrome-%E6%8B%A1%E5%BC%B5/dnlfpnhinnjdgmjfpccajboogcjocdla)||
> |設定                  |                                                   |                                                                         |
> |                      |ウェブコンテンツ                                   |フォント: [RictyDiminished](https://github.com/yascentur/RictyDiminished)|
> |開発ツール            |                                                   |                                                                         |
> |                      |Customize and control DevTools > Settings > Preferences > Theme|Dark                                                         |

[FireFox](https://www.mozilla.org/ja/firefox/)
> Application設定
>
> |大項目                |小項目                                             |                                                                    |
> |:---------------------|:--------------------------------------------------|:-------------------------------------------------------------------|
> |Required sync setting |                                                   |                                                                    |
> |Firefox > 環境設定    |                                                   |                                                                    |
> |                      |一般 > ホームページ                                |file:///file/to/path/bookmark.html                                  |
> |                      |検索                                               |Google以外Remove                                                    |
> |                      |検索 > ロケーションバーに検索候補を表示する        |チェック                                                            |
> |                      |コンテンツ > フォントとカラー > デフォルトフォント |[RictyDiminished](https://github.com/yascentur/RictyDiminished)     |
> |                      |コンテンツ > 言語 > 言語設定                       |Add Japanese[ja]                                                    |
> |開発ツール            |                                                   |                                                                    |
> |                      |開発ツールのオプション > テーマ                    |Dark                                                                |
> |                      |開発ツールのオプション > エディター設定 > タブ幅   |4                                                                   |
> |                      |開発ツールのオプション > スクリーンショットの動作 > カメラのシャッター音を再生 |チェック外し                            |
> |                      |開発ツールのオプション > 利用可能なツールボックスのボタン > ページ全体のスクリーンショットを撮ります |チェック          |
> |add-on                |                                                   |                                                                    |
> |                      |[FireMobileSimulator](https://addons.mozilla.org/ja/firefox/addon/firemobilesimulator/)                                ||
> |                      |[Hatena Bookmark](https://addons.mozilla.org/ja/firefox/addon/hatena-bookmark/)                                        ||
> |                      |                                                   |全般 > 検索機能を有効にする チェック外し                            |
> |                      |                                                   |全般 > Ctrl + Shift キーによる検索ショートカットを使う チェック外し |
> |                      |                                                   |全般 > 右クリックメニューを拡張する チェック外し                    |
> |                      |                                                   |全般 > ブックマークやリンクを新しいタブで開く チェック外し          |
> |                      |                                                   |Web閲覧 > ブックマークされた数を表示する チェック外し               |
> |                      |                                                   |Web閲覧 > コメントビューワーで表示 ボタンを表示する チェック外し    |
> |                      |                                                   |Web閲覧 > リンク チェック外し                                       |
> |                      |                                                   |ショートカット > サイドバー表示の切り替え √⌘  + B                  |
> |                      |[JSONView](https://addons.mozilla.org/ja/firefox/addon/jsonview/)                                                      ||
> |                      |[Quick Translator](https://addons.mozilla.org/ja/firefox/addon/quick-translator/)                                      ||
> |                      |[RESTClient](https://addons.mozilla.org/ja/firefox/addon/restclient/)                                                  ||
> |                      |[The Addon Bar(restored)](https://addons.mozilla.org/ja/firefox/addon/the-addon-bar/?src=hp-btn-promo)                 ||
> |                      |[Web Developer](https://addons.mozilla.org/ja/firefox/addon/web-developer/)                                            ||
> |                      |[テキストリンク](https://addons.mozilla.org/ja/firefox/addon/text-link/)                                               ||
> |about:config          |                                                   |                                                                    |
> |                      |browser.bookmarks.showRecentlyBookmarked           |false                                                               |
> |                      |browser.link.open_newwindow.restriction            |0                                                                   |
> |                      |browser.showQuitWarning                            |true                                                                |
> |                      |browser.tabs.closeWindowWithLastTab                |false                                                               |
> |                      |dom.push.enabled                                   |false                                                               |
> |                      |dom.webnotifications.enabled                       |false                                                               |

## TODO

* Try Chocolatey

