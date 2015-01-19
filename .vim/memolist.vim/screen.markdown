title: screen
==========
date: 2015-01-11 15:51
tags: []
categories: []
- - -

# セッション

起動
```
$ screen
```
セッション一覧
```
$ screen -ls
```
デタッチ
```
Prefix > Ctrl-u
```
アタッチ
```
$ screen -r <id>
```

# コピー

```
$ Prefix > [

 h,j,k,l でコピー対象の頭に移動
 ^:start, $:end

$ Prefix > ]
```

# Window操作

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

# Etc

設定ファイル再読み込み
```
Prefix > r
```
