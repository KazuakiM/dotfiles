<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Heroku](#heroku)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Heroku
===

help
```bash
heroku --help
```

release note
```bash
heroku releases
```

deploy
```bash
cd /dir/to/project
git push heroku master
```

[GitHub to Heroku](http://dqn.sakusakutto.jp/2012/04/github-heroku-push.html)
```bash
heroku create --stack cedar  foo
git clone git@github.com:DQNEO/foo.git
cd foo
git remote add heroku git@heroku.com:foo.git
git push heroku master
```
