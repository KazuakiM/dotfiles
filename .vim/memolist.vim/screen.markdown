screen
===

## セッション

起動
```bash
$ screen
```

セッション一覧
```bash
$ screen -ls
```

デタッチ
```
Prefix > Ctrl-u
```

アタッチ
```bash
$ screen -r <id>
```

## コピー

```
Prefix > [

 h,j,k,l でコピー対象の頭に移動
 ^:start, $:end

Prefix > ]
```

## Window操作

ウィンドウ一覧
```
Prefix > Ctrl-l
```

ウィンドウ次へ
```
Prefix > Ctrl-d
```

ウィンドウ前へ
```
Prefix > Ctrl-s
```

ウィンドウ作成
```
Prefix > Ctrl-k
```

ウィンドウ水平分割
```
Prefix > -
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
