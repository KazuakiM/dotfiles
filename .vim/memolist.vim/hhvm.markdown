hhvm
===

# HHVM info

```bash
$ hhvm --info
```

# HHVM xdebug and PHP7 for homebrew

```php
$ hhvm --info | grep debug
xdebug.enable =>

$ vim /usr/local/etc/hhvm/php.ini

  xdebug.enable = 1
  hhvm.php7.all = 1
  hhvm.php7.scalar_types = 0

$ hhvm --info | grep debug
xdebug.enable => 1
```
