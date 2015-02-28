tmux
===

## セッション

起動
```bash
$ tmux
```

セッション一覧
```bash
$ tmux ls
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
$ tmux attach -t <id>
```

現在接続中のセッション削除
```bash
$ tmux kill-session
```

指定したセッション削除
```bash
$ tmux kill-session -t <id>
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
Prefix > Ctrl-s
Prefix > Ctrl-d
```

ウィンドウ作成
```
Prefix > Ctrl-k
```

ウィンドウ垂直分割/水平分割
```
Prefix > v
Prefix > s
```

ウィンドウリサイズ
```
Prefix > +
Prefix > -
Prefix > >
Prefix > <
```

ウィンドウ分割解除
```
Prefix > Ctrl-p
```

ウィンドウリネーム
```
Prefix > Ctrl-w
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
