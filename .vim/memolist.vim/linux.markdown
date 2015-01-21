title: Linux
==========
date: 2014-11-22 20:22
tags: []
categories: []
- - -

# File Transfer

## No encrypt

[nc/pv](http://blog.glidenote.com/blog/2014/12/02/using-netcat-for-file-transfers-with-pv/)
Sender
```
$ pv ./<File> | nc -l 3000
```
Receiver
```
$ nc foobar.com 3000 | pv > <File>
```

## scp

Sender
```
$ scp -P <port> <file> <host>:/tmp/
```
Receiver
```
$ scp -P <port> <host>:/file/to/pasth/<file> /tmp/
```

# Grep

file grep
```
$ find ./ -type d -name ".git" -prune -o -type d -name ".svn" -prune -o -type f -name "*.js" -prune -o -type f -name "*.css" -prune -o -type f -exec grep --color -I -n "keyword" {} /dev/null \;
```

# Network

All network interface
```
$ ifconfig -a
```
5 request
```
$ ping -d -c 5 <host>
```
Trace route
```
$ traceroute -d -p <port> <host>
```
Tcpdump
```
$ tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port> host <host>
$ tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port> dst host <host>
$ tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port> src host <host>
```

# File size

disc file system size
```
$ df -h
```
directory size
```
$ du -sh *
```
file size under directory
```
$ find ./ -ls
```

# Service

Check service status list
```
$ service --status-all
```
Check auto start service list
```
$ chkconfig --list
```

# File compress/decompress

| 拡張子       | 圧縮                                  | 解凍                                                   |
| :------------| :------------------------------------ | :----------------------------------------------------- |
|.bz2          | $ bzip2 file1                         | $ bzip2 -dc  archive.bz2<br />$ bunzip2 -c archive.bz2 |
|.gz           | $ gzip     file1                      | $ gunzip     archive.tar.gz                            |
|.tgz, .tar.gz | $ tar zcvf archive.tar.gz file1 file2 | $ tar zxvf   archive.tar.gz                            |
|.zip          | $ zip -r   archive.zip    file1 file2 | $ unzip      archive.tar.gz                            |
