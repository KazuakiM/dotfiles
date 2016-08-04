<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Apache](#apache)
  - [VirtualHost](#virtualhost)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Apache
===

## VirtualHost

/etc/httpd/conf/httpd.conf
```apache
User  [User]
Group [Group]
```
/etc/httpd/conf.d/httpd-vhosts.conf
```apache
NameVirtualHost 127.0.0.1
<VirtualHost *:80>
    ServerAdmin  kazuaki_mabuchi_to_go@hotmail.co.jp
    DocumentRoot [/file/to/path/public]
    ServerName   [domain name]
    ErrorLog     /var/log/httpd/error_log
    CustomLog    /var/log/httpd/access_log common
    <Directory '[/file/to/path/public]'>
        Options FollowSymLinks
        AllowOverride All
        #2.4.* {{{
        Require all granted
        #}}}
        #2.2.* {{{
        #Order allow,deny
        #Allow from all
        #}}}
    </Directory>
</VirtualHost>
``
