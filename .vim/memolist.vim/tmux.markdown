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

## 概念

階層: Session > Window > Pane

| 概念 | 例えるなら | 説明 |
|------|-----------|------|
| Session | ブラウザのウィンドウ全体 | 複数のWindowをまとめる単位（`tmux ls` で出る） |
| Window | ブラウザのタブ | 画面いっぱいに切替わる。1つだけアクティブ |
| Pane | タブ内の分割画面 | Window内をsplitした区画 |

- **Window切替**: 画面まるごと入れ替わる
- **Pane切替**: 同じ画面内でフォーカスだけ動く

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
Prefix > Ctrl-q
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
Prefix > K
Prefix > J
Prefix > H
Prefix > L
```

ペイン分割解除
```
Prefix > Ctrl-p
```

### Window入れ替え（位置トグル）

枠の中身（プロセス）だけが入れ替わる。レイアウトは維持される。

前のwindow番号と入れ替え
```
Prefix > C-p
```

次のwindow番号と入れ替え
```
Prefix > C-n
```

任意番号と入れ替え（コマンドライン）
```
Prefix > :swap-window -s 3 -t 1
```

### Pane入れ替え（位置トグル）

前のpaneと入れ替え
```
Prefix > {
```

次のpaneと入れ替え
```
Prefix > }
```

pane 1（Claudeメイン）と入れ替え（独自bind）
```
Prefix > C-x
```

任意番号と入れ替え
```
Prefix > :swap-pane -s 2 -t 4
```

ペイン番号を一時表示（番号確認用）
```
Prefix > q
```

### ペイン一時拡大（zoom）

現在のペインをWindowいっぱいに表示。もう一度叩くと戻る。
```
Prefix > z
```

## レイアウト

### Claude用レイアウト一発生成（独自bind）

左35%メイン + 右65%（2×2）の5ペイン構成
```
Prefix > C-c
```

ペイン配置:
```
+----------+----------+----------+
|          |    2     |    3     |
|    1     +----------+----------+
| (Claude) |    4     |    5     |
+----------+----------+----------+
```

### プリセットレイアウト切替

5種類（even-horizontal / even-vertical / main-horizontal / main-vertical / tiled）を順送り
```
Prefix > Space
```

特定レイアウト指定
```
Prefix > :select-layout main-vertical
Prefix > :select-layout main-horizontal
Prefix > :select-layout tiled
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
