hhvm
===

# HHVM info

```bash
$ hhvm --info
```

# HHVM xdebug for homebrew

```php
$ hhvm --info | grep debug
xdebug.enable =>

$ vim /usr/local/etc/hhvm/php.ini

  xdebug.enable = 1

$ hhvm --info | grep debug
xdebug.enable => 1
```
