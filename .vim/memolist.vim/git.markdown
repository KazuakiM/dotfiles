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

git branch xxxxx
git checkout xxxxx
git push origin xxxxx
```

Merge master to branch
```bash
pwd
git status

git checkout master
git pull
git branch

git checkout xxxxx
git merge master
gdiff master

git push origin xxxxx
```

Merge branch to master
```bash
pwd
git status

git checkout master
git pull
git branch

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

git push
```

Add fork repository
```bash
pwd
git status
git branch -a

git remote add fork_master git://github.com/xxxxx/xxxxx
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
* [GitHubにてリポジトリ新規作成](https://github.com/KazuakiM)
 * SlideShowリポジトリ名定義:SlideShow-XXX
* 新規リポジトリページからブランチ"gh-pages"を作成
* 別の"SlideShow-XXX"の内容をコピー
* 動作確認

## git log

Help
```bash
git log --help
```

修正ファイル
```bash
git log --stat
```

件数
```bash
git log -n 5
```

ローカルリポジトリのコミットログ
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

コミット取消
```bash
git reset --hard
```

file1の追加取消
```bash
git reset HEAD file1
```

## git push

Help
```bash
git push --help
```

マスターpush
```bash
git push origin master
```

リモートリポジトリpush
```bash
git push origin xxxxx
```

## git stash

ファイル退避
```bash
git stash
git status
```

退避状況確認
```bash
git stash list
```

退避ファイル削除
```bash
git stash drop
```

退避ファイル復活&退避ファイル削除
```bash
git stash pop
```

## branch delete

ローカルブランチ削除
```bash
git branch -d xxxxx
```

リモートブランチ削除push
```bash
git push origin :xxxxx
```
