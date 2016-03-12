<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Svn](#svn)
  - [Tips](#tips)
  - [svn add/rm](#svn-addrm)
  - [svn diff](#svn-diff)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Svn
===

## Tips

Create branch
```bash
pwd
svn status

svn update
svn info

NAME="`date +%Y%m%d`_XXX"
echo $NAME

svn copy svn://<host>/<Project>/trunk svn://<host>/<Project>/branches/$NAME -m 'XXX'
```

Merge branch to master
```bash
pwd
svn switch svn://<host>/<Project>/branches/<branch name>
svn status

svn update
#
# latest revision check
#

svn info

svn log --stop-on-copy
#
# merged revision check
#

svn merge -r <old revision>:<latest revision> svn://<host>/<Project>/trunk
svn status | grep C
#
# Check Conflict.
#

# IF Conflict
#  svn revert -R .
#  svn status
#  svn status | grep '^?' | awk '{print $2}' | xargs rm -rf
#  svn update
#  svn status
#
#  # IF ! file exist
#  #  rm -rf xxxx
#  #  svn update
#  #  svn status
#
#  svn info
#  svn log --stop-on-copy
#  svn merge -r <old revision>:<latest revision> svn://<host>/<Project>/trunk
#    detail merge
#  svn status | grep C
#  svn commit -m "Merged branch '<branch name>' into 'master' <old revision>:<latest revision>"
#  svn update
#  svn info
#  svn merge ....

svn commit -m "Merged branch '<branch name>' into 'master' <old revision>:<latest revision>"
svn update
#
# After merge revision check
#

svn info

svn switch svn://<host>/<Project>/trunk
svn merge svn://<host>/<Project>/trunk@<latest revision> svn://<host>/<Project>/branches/<branch name>@<after merge revision> .
svn status
svn diff
svn commit -m "Merged branch 'master' into '<branch name>'"
svn update
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

