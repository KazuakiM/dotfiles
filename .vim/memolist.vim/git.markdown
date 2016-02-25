<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Git](#git)
  - [Tips](#tips)
  - [git log](#git-log)
  - [git diff](#git-diff)
  - [git add/rm](#git-addrm)
  - [git reset](#git-reset)
  - [git commit](#git-commit)
  - [git push](#git-push)
  - [git stash](#git-stash)
  - [branch delete](#branch-delete)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Git
===

## Tips

Create branch
```bash
pwd
git status

git checkout master
git pull
git branch

NAME="`date +%Y%m%d`_XXX"

git branch      $NAME
git checkout    $NAME
git push origin $NAME
```

Rebase branch to master
```bash
pwd
git status
git push origin xxxxx
#
# Insurance for rebase error.
#

git checkout master
git pull
git branch

git checkout xxxxx
gdiff master

git lg --oneline -n 5
# 5ce576e
# 30ff21a
# 95eaecd
# adb04d8
# 29102b1
#

git rebase -i HEAD~3
#
# 最新から3つ前のコミット(adb04d8以降)を1つにまとめる。
# 最新のコミット以外はsquashに指定する。
#

git log
#
# Check commit message.
#

git lg
#
#  Check graph.
#

# IF error
#  git reset --hard ORIG_HEAD
#  git log
#  git lg
#  git rebase -i HEAD~n
#  git log
#  #
#  # Check commit message.
#  #
#
#  git lg
#  #
#  #  Check graph.
#  #

git rebase master
git lg
#
#  Check graph.
#

git push -f origin xxxxx
git lg
#
#  Check graph.
#

git checkout master
git merge xxxxx

git push origin master
```

Merge fork repository
```bash
pwd
git status

git checkout master
git pull
git branch -a

git pull fork_master master
git status

git push origin master
```

Add fork repository
```bash
pwd
git status
git branch -a

git remote add fork_master git://github.com/xxxxx/xxxxx
```

Update fork repository
```bash
pwd
git status
git branch -a

git fetch fork_master

git rebase fork_master/master
```

Checkout remote branch repository
```bash
pwd
git status
git fetch
git branch -a
git checkout -b xxxxx origin/xxxxx
```

Create github.io pages
* [Create repository at GitHub.](https://github.com/KazuakiM)
 * prefix:SlideShow-XXX
* Confirm
 ```bash
 pwd
 git clone git@github.com:KazuakiM/SlideShow-XXX.git
 cd SlideShow-XXX
 git branch gh-pages
 git checkout gh-pages
 #
 # Copy other repositorys.
 #

 git commit -am 'first commit'
 git push origin gh-pages
 ```

## git log

Help
```bash
git log --help
```

Check modify file
```bash
git log --stat
```

Count
```bash
git log -n 5
```

Check local repository log
```bash
git log origin/master..xxxxx
```

## git diff

Help
```bash
git diff --help
```

ワークディレクトリとリポジトリのfile1のdiff
```bash
gdiff file1
```

file1 のソース変更部分が表示される
```bash
git show (ハッシュ値)
```

最新のコミットと現在のdiff
```bash
gdiff HEAD^ HEAD
```

過去のコミットと現在のdiff
```bash
gdiff (ハッシュ値) HEAD file1
```

マスターリポジトリと現在のリポジトリのdiff
```bash
gdiff master xxxxx
```

マスターリポジトリと現在のリポジトリのファイルdiff
```bash
gdiff master <file1>
```

## git add/rm

Help
```bash
git add --help
git rm --help
```

file1の追加取消
```bash
git reset HEAD file1
```

file1.php , directory1 削除(file1.php , directory1も消される)
```bash
git rm file1.php
git rm -r directory1
```

file1.php , directory1 削除(file1.php , directory1は残る)
```bash
git rm --cached file1.php
git rm -r --cached directory1
```

## git reset

Help
```bash
git reset --help
```

Reset commit.
```bash
git reset --hard
```

Reset additional file1.
```bash
git reset HEAD file1
```

## git commit

Currently update commit message.
```bash
git commit --amend
```

## git push

Help
```bash
git push --help
```

Push remote master branch.
```bash
git push origin master
```

Push remote branch.
```bash
git push origin xxxxx
```

## git stash

Base
```bash
git status
git stash
git status
```

List
```bash
git stash list
```

Delete
```bash
git stash drop
```

All delete(destroy)
```bash
git stash clear
```

誤って退避ファイル全てを削除してしまった場合
```bash
git fsck | awk '/dangling commit/ {print $3}'
#
# 候補のsha1 がいくつか出てくる
#

git show --summary 候補のsha1
#
# 一つ一つの sha1 の内容を確認
#

git cherry-pick -n -m1 見つけたsha1
```

Pop
```bash
git stash pop
```

指定した退避ファイル復活&退避ファイル削除
```bash
git stash pop stash@{N}
```

退避ファイルとの比較
```bash
git stash list -p
```

退避ファイルとの詳細な比較
```bash
git stash list -p stash@{N}
```

特定のファイルを復活
```bash
git checkout stash@{N} fuga.rb
```


## branch delete

Delete local branch.
```bash
git branch -d xxxxx
```

Delete remote branch.
```bash
git push origin :xxxxx
```
