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
Ctrl-t + d
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

# Window操作

ウィンドウ一覧
```
Ctrl-t + w
```
ウィンドウ切替
```
Ctrl-t + <ウィンドウ番号>
```
ウィンドウ作成
```
Ctrl-t + c
```
ウィンドウ削除
```
Ctrl-t + &
```
# Etc

設定ファイル再読み込み
```
Ctrl-t + r
```
