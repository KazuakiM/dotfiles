title: Git
==========
date: 2014-11-19 09:19
tags: []
categories: []
- - -

## branch 作成
```
pwd
git status

git checkout master
git pull
git branch

git branch xxxxx
git checkout xxxxx
git push origin xxxxx
```

## merge master to branch
```
pwd
git status

git checkout master
git pull
git branch

git checkout xxxxx
git merge master
gdiff master xxxxx

git push origin xxxxx
```

## merge branch to master
```
pwd
git status

git checkout master
git pull
git branch

git merge xxxxx

git push origin master
```

## merge fork repository
```
pwd
git status

git checkout master
git pull
git branch -a

git pull fork_master master
git status

git push
```

## Add fork repository
```
pwd
git status
git branch -a

git remote add fork_master git://github.com/xxxxx/xxxxx
```

## Checkout remote branch repository
```
pwd
git status
git fetch
git branch -a
git checkout -b xxxxx origin/xxxxx
```

## git log
help
```
git log --help
```
修正ファイル
```
git log --stat
```
件数
```
git log -n 5
```
ローカルリポジトリのコミットログ
```
git log origin/master..xxxxx
```

## git diff
help
```
git diff --help
```
ワークディレクトリとリポジトリのfile1のdiff
```
gdiff file1
```
file1 のソース変更部分が表示される
```
git show (ハッシュ値)
```
最新のコミットと現在のdiff
```
gdiff HEAD^ HEAD
```
過去のコミットと現在のdiff
```
gdiff (ハッシュ値) HEAD file1
```
マスターリポジトリと現在のリポジトリのdiff
```
gdiff master xxxxx
```
マスターリポジトリと現在のリポジトリのファイルdiff
```
gdiff master <file1>
```

## git add/rm
help
```
git add --help
git rm --help
```
file1の追加取消
```
git reset HEAD file1
```
file1.php , directory1 削除(file1.php , directory1も消される)
```
git rm file1.php
git rm -r directory1
```
file1.php , directory1 削除(file1.php , directory1は残る)
```
git rm --cached file1.php
git rm -r --cached directory1
```

## git reset
help
```
git reset --help
```
コミット取消
```
git reset --hard
```
file1の追加取消
```
git reset HEAD file1
```

## git push
help
```
git push --help
```
マスターpush
```
git push origin master
```
リモートリポジトリpush
```
git push origin xxxxx
```

## git stash
ファイル退避
```
git stash
git status
```
退避状況確認
```
git stash list
```
退避ファイル削除
```
git stash drop
```
退避ファイル復活&退避ファイル削除
```
git stash pop
```

## branch delete
ローカルブランチ削除
```
git branch -d xxxxx
```
リモートブランチ削除push
```
git push origin :xxxxx
```
