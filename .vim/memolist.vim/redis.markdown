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

