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
        Order allow,deny
        Allow from all
        Require all granted
    </Directory>
</VirtualHost>
```

