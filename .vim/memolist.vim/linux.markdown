Linux
===

## File

### No encrypt transfer

[nc/pv](http://blog.glidenote.com/blog/2014/12/02/using-netcat-for-file-transfers-with-pv/)
Sender
```
$ pv ./<File> | nc -l 3000
```
Receiver
```
$ nc foobar.com 3000 | pv > <File>
```

### scp

Sender
```
$ scp -P <port:22> <file> <host>:/tmp/
```
Receiver
```
$ scp -P <port:22> <host>:/file/to/pasth/<file> /tmp/
```

### File SQL "[ q ](https://github.com/harelba/q)([ SS ](http://www.slideshare.net/serima1/87php-lt))"

I don't use "q" now.
```
$ q 'SELECT c1, COUNT(*) AS count FROM ./<file.csv> WHERE c3 > 0 GROUP BY c1'
```

### File sort

No make temporary file
```
$ 〜 <(sort <file>)


ex) join file1.tsv, file2.tsv

$ cat file1.tsv
1,neco
3,cat
2,nuko

$ cat file2.tsv
2,かわいい

$ join -a1 -t ',' -e '-' -o '0 1.2 2.2' <(sort file1.tsv) <(sort file2.tsv)
1,neco,-
2,nuko,かわいい
3,cat,-
```


## SSH

```
$ ssh -p <port:22> -i <file.pem> <user>@<host>
```

## Grep

file grep using alias
```
$ FIND <keyword>
```

## Network

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
$ tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port:80> host <host>
$ tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port:80> dst host <host>
$ tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port:80> src host <host>
```

## File size

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

## Service

Check service status list
```
$ service --status-all
```
Check auto start service list
```
$ chkconfig --list
```

## File compress/decompress

| 拡張子       | 圧縮                                  | 解凍                                                   |
| :------------| :------------------------------------ | :----------------------------------------------------- |
|.bz2          | $ bzip2 file1                         | $ bzip2 -dc  archive.bz2<br />$ bunzip2 -c archive.bz2 |
|.gz           | $ gzip     file1                      | $ gunzip     archive.tar.gz                            |
|.tgz, .tar.gz | $ tar zcvf archive.tar.gz file1 file2 | $ tar zxvf   archive.tar.gz                            |
|.zip          | $ zip -r   archive.zip    file1 file2 | $ unzip      archive.tar.gz                            |
