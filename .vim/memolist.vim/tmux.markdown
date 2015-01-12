title: tmux
==========
date: 2015-01-11 15:51
tags: []
categories: []
- - -

# セッション

起動
```
$ tmux
```
セッション一覧
```
$ tmux ls
```
接続中のセッション一覧
```
$ tmux lsc
```
デタッチ
```
Prefix > d
```
アタッチ
```
$ tmux attach -t <id>
```
現在接続中のセッション削除
```
$ tmux kill-session
```
指定したセッション削除
```
$ tmux kill-session -t <id>
```
全てのセッション削除
```
$ tmux kill-server
```

# コピー

```
$ Prefix > [

 h,j,k,l でコピー対象の頭に移動
 v:start, y:end (image :Visual mode)

$ Prefix > ]
```

# Window操作

ウィンドウ一覧
```
Prefix > w
```
ウィンドウ切替
```
Prefix > <ウィンドウ番号>
```
ウィンドウ作成
```
Prefix > c
```
ウィンドウ削除
```
Prefix > &
```
# Etc

設定ファイル再読み込み
```
Prefix > r
```
現在の設定の確認
```
$ tmux show-options -g        > /tmp/show-options.txt
$ tmux show-window-options -g > /tmp/show-window-options.txt
Prefix > :list-keys -t vi-copy
```
