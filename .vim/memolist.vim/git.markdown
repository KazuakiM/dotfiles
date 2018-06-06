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

Create SSH Key
```bash
ssh-keygen -t rsa -b 4096 -C "xxxx@xxx"
ssh-keygen -l -f $HOME/.ssh/id_rsa.pub
pbcopy < $HOME/.ssh/id_rsa.pub

> Add SSH Key
>  https://github.com/settings/keys

ssh -T git@github.com
ssh-add -K $HOME/.ssh/id_rsa.pub
```

Make empty commit & empty PR
```
# オペレーションのみを依頼する場合に口頭になりがち問題を解決
git branch <blanch>
git chckout <blanch>
git commit --allow-empty -m ''
git push origin <blanch>
# PR作成
```

Pull Request local DL and checkout
```
git pr <ID>
```

Rename (Move) file tips
```
# リネーム時の履歴を残し、 git log --follow で追えるようにします。

# バックアップのため、リモートブランチを最新にします。
git st
git rbi
git push -f origin <blanch>

# masterブランチとの差分を確認し、移行前ファイルと移行後ファイルを確認します。

git df master --stat
tar zcvf archive.tar.gz \
 xxx \
 yyy
mv archive.tar.gz /tmp
git st

# バックアップがすでにありますが、保険として操作しているディレクトリ以外に<blanch>をcloneしておきます。
# ※それほど怖い対応です。

# ステップブランチにて移行ファイルをコミットします。
# リモートブランチへのpushは不要です。
git checkout master
git branch step

git mv xxx yyy

git commit
git st

# 一旦、修正を取り消し、ステップブランチを取り込みます。
git checkout <blanch>
git reset --hard HEAD~

# 先程、tarで固めた移行ファイルの修正を取り消します。
# 修正を取り消す理由は<step>ブランチを取り込む際に<step>ブランチでリネームした事実があるため、
# <blanch>上からその事実を消し去る必要があります。
#
# ここはウル覚えのため、要確認・更新
git checkout xxx

# 修正ファイルをコミットします。
# stepブランチを取り込みます。
git cm ' Will delte...' .
git rebase step
cp /tmp/archive.tar.gz .
tar zxvf archive.tar.gz
git cm ' xxxxxxxxxxx' .

# この時点でリモートブランチとの差分は無いはずで、
# あった場合には操作ミスが予想されます。
git df origin/<blanch>

# 問題なければ、"Will delete" を squash します。
# この時点で master ブランチから見ると 2commit 進んだ形になっているはずです。
# tar で固めるファイルを修正ファイル全部でやって1回にまとめれるかも。
git rebase HEAD~

# <step>ブランチを削除
git branch -d step
```

GitHub page ignore Space
```
https://github.com/xxxxx/xxxxx/pull/<number>/files?w=1
```

Create branch
```bash
pwd
git status

git checkout master
git pull
git branch

NAME="`date +%Y%m%d`_XXX"
echo $NAME

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

git checkout xxxxx
git dff master
#
# Check diff.
#

git rebase master
git push origin xxxxx
#
# Insurance for rebase error.
#

git lg --oneline -n 5
# 5ce576e
# 30ff21a
# 95eaecd
# adb04d8
# 29102b1
#

git rebase -i HEAD~3
# before
# # pick 29102b1
# # pick adb04d8
# # pick 95eaecd
#
# after
# # pick 29102b1
# # s adb04d8
# # s 95eaecd
#
# 最新から3つ前のコミット(adb04d8以降)を1つにまとめる。
# 基底となる最初のコミット以外はsquashに指定する。
# squashは画面上にも説明文が表示されているが前のコミットに結合するという意味。
# そのため、基底となる最初のコミットをpickのままとし、残りをsquashに指定する。
#
# IF git rebase -i error.
#  "Interactive rebase already started"
#
#  # git rebase --abort
#
#  "Cannot 'squash' without a previous commit"
#
#  # git rebase --abort

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

git dff origin/xxxxx
#
# Make sure that it is the same.
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
git fetch fork_master
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

Compare URL例。ハッシュでも可能だけど、rebase主義の兼ね合いで、下記の方が都合が良い。
そもそもこれが必要になる理由はリネーム対応においてGitHub上でのdiffが困難な事が要因orz。
※も含めてPRに記載する事。
```bash
https://github.com/xxxxx/xxxxx/compare/<blanch>~...<blanch>?w=1
※ ~ (チルダ)は修正数に応じて追加する必要があります。
```

ワークディレクトリとリポジトリのfile1のdiff
```bash
git dff file1
```

file1 のソース変更部分が表示される
```bash
git show (ハッシュ値)
```

最新のコミットと現在のdiff
```bash
git dff HEAD^ HEAD
```

過去のコミットと現在のdiff
```bash
git dff (ハッシュ値) HEAD file1
```

マスターリポジトリと現在のリポジトリのdiff
```bash
git dff master xxxxx
```

マスターリポジトリと現在のリポジトリの更新ファイルのdiff
```bash
git dff --name-only master xxxxx
```

マスターリポジトリと現在のリポジトリのファイルdiff
```bash
git dff master <file1>
```

リモートブランチとの比較(rebase後とかに使う)
```bash
git df origin/<branch>
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

Local keep & Reset commit.
```bash
git reset --soft HEAD~
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

git管理下でワークディレクトリの修正を無視する。
```bash
git update-index --skip-worktree <file1>
git update-index --assume-unchanged <file1>
```

git管理下でワークディレクトリの修正を無視を解除する。
```bash
git update-index --no-skip-worktree <file1>
git update-index --no-assume-unchanged <file1>
```

git管理下でワークディレトリの修正を無視する設定状況確認
```bash
git ls-files -v|\grep "^h\\|^S"
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

Sync Remote
```bash
git fetch --prune

git remote show origin
git remote prune origin --dry-run
git remote prune origin
git branch -a
```

Delete local branch.
```bash
git branch -d xxxxx
```

Delete remote branch.
```bash
git push origin :xxxxx
```
