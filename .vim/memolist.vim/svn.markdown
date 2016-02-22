Svn
===

## Tips

Create branch
```bash
pwd
svn stat

svn up
svn info

NAME="`date +%Y%m%d`_XXX"

svn copy svn://<host>/<Project>/trunk svn://<host>/<Project>/branches/$NAME -m 'XXX'
```

Merge branch to master
```bash
pwd
svn switch svn://<host>/<Project>/branches/<branch name>
svn stat

svn up
#
# latest revision check
#

svn info

svn log --stop-on-copy
#
# merged revision check
#

svn merge -r <old revision>:<latest revision> svn://<host>/<Project>/trunk
svn stat | grep C

#IF Conflict
# svn revert -R .
# svn up
# svn info
# svn merge -r <old revision>:<latest revision> svn://<host>/<Project>/trunk
#   detail merge
# svn stat | grep C
# svn ci -m "Merged branch '<branch name>' into 'master' <old revision>:<latest revision>"
# svn up
# svn info
# svn merge ....

svn ci -m "Merged branch '<branch name>' into 'master' <old revision>:<latest revision>"
svn up
#
# After merge revision check
#

svn info

svn switch svn://<host>/<Project>/trunk
svn merge svn://<host>/<Project>/trunk@<latest revision> svn://<host>/<Project>/branches/<branch name>@<after merge revision> .
svn status
svn diff
svn ci -m "Merged branch 'master' into '<branch name>'"
svn up
```

## svn add/rm

Add
```bash
svn add <file1>
```

Rm
```bash
svn delete <file1>
```

## svn diff

ワークディレクトリとリポジトリのfile1のdiff
```bash
svn diff svn://<host>/<Project>/trunk@<latest revision> svn://<host>/<Project>/branches/<branch name>@<after merge revision> |grep +++
```

