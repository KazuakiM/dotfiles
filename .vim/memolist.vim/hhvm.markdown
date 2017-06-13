<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [hhvm](#hhvm)
- [HHVM info](#hhvm-info)
- [HHVM xdebug and PHP7 for homebrew](#hhvm-xdebug-and-php7-for-homebrew)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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
