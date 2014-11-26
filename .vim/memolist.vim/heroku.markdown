title: Heroku
==========
date: 2014-11-22 10:05
tags: []
categories: []
- - -

help
```
heroku --help
```

release note
```
heroku releases
```

deploy
```
cd /dir/to/project
git push heroku master
```

[GitHub to Heroku](http://dqn.sakusakutto.jp/2012/04/github-heroku-push.html)
```
heroku create --stack cedar  foo
git clone git@github.com:DQNEO/foo.git
cd foo
git remote add heroku git@heroku.com:foo.git
git push heroku master
```
