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
<VirtualHost *:80>
    DocumentRoot [/file/to/path/public]
    ServerName   [domain name]
    ErrorLog     /Users/<User>/.log/httpd/error_log
    CustomLog    /Users/<User>/.log/httpd/access_log common
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

    Alias /repository /file/to/otherPath/
    <Directory '[/file/to/otherPath]'>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```
