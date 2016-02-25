<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [screen](#screen)
  - [セッション](#%E3%82%BB%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3)
  - [コピー](#%E3%82%B3%E3%83%94%E3%83%BC)
  - [Window操作](#window%E6%93%8D%E4%BD%9C)
  - [Etc](#etc)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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
