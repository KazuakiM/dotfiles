<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [tmux](#tmux)
  - [セッション](#%E3%82%BB%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3)
  - [コピー](#%E3%82%B3%E3%83%94%E3%83%BC)
  - [Window操作](#window%E6%93%8D%E4%BD%9C)
  - [Etc](#etc)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

tmux
===

## セッション

起動
```bash
$ tm
```

セッション一覧
```bash
$ tml
```

接続中のセッション一覧
```bash
$ tmux lsc
```

デタッチ
```
Prefix > Ctrl-u
```

アタッチ
```bash
$ tml
$ tma <id>
```

現在接続中のセッション削除
```bash
$ tml
$ tmk <id>
```

全てのセッション削除
```bash
$ tmux kill-server
```

## コピー

```
Prefix > [

 h,j,k,l でコピー対象の頭に移動
 0:start-of-line, 9:end-of-line
 v:start, y:end (image :Visual mode)

Prefix > ]
```

## Window操作

ウィンドウ一覧
```
Prefix > Ctrl-l
```

ウィンドウ切替
```
Prefix > <ウィンドウ番号>
```

ウィンドウ前へ/次へ
```
Ctrl-s
```

ウィンドウ作成
```
Prefix > Ctrl-k
```

ウィンドウリネーム
```
Prefix > Ctrl-e
```

ウィンドウ削除
```
Prefix > &
```

ペイン垂直分割/水平分割
```
Ctrl-_
Ctrl-h
```

ペイン間移動
```
Prefix > o
```

ペインリサイズ
```
Prefix > +
Prefix > -
Prefix > >
Prefix > <
```

ペイン分割解除
```
Prefix > Ctrl-p
```

## Etc

設定ファイル再読み込み
```
Prefix > r
```

現在の設定の確認
```bash
$ tmux show-options -g        > /tmp/show-options.txt
$ tmux show-window-options -g > /tmp/show-window-options.txt
Prefix > :list-keys -t vi-copy
```
