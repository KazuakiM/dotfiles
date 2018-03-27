<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [redis](#redis)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

redis
===

HMSET
```bash
$ redis-cli HMSET sample 2 "35,720" 3 "380,720" 10 "5,720" 6 "3,720"
OK
$ redis-cli EXPIRE sample 10
(integer) 1
$ redis-cli HGET sample 2
"35,720"

(10 sec ago)
$ redis-cli HGET sample 2
(nil)
```

全データ削除
```bash
$ redis-cli flushdb
```
