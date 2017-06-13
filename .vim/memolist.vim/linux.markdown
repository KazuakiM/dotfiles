<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Linux](#linux)
  - [File](#file)
    - [No encrypt transfer](#no-encrypt-transfer)
    - [FTP](#ftp)
    - [scp](#scp)
    - [File SQL " q ( SS )"](#file-sql--q--ss-)
    - [File merge](#file-merge)
    - [File sort](#file-sort)
    - [File uniq](#file-uniq)
    - [File word count](#file-word-count)
  - [SSH](#ssh)
  - [SSH(Step by step)](#sshstep-by-step)
  - [SSHFS](#sshfs)
  - [Grep](#grep)
  - [Network](#network)
  - [File size](#file-size)
  - [nohup & disown](#nohup--disown)
  - [sed](#sed)
  - [awk](#awk)
  - [Service](#service)
  - [File compress/decompress](#file-compressdecompress)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Linux
===

## File

### No encrypt transfer

[nc/pv](http://blog.glidenote.com/blog/2014/12/02/using-netcat-for-file-transfers-with-pv/)
Sender
```bash
$ pv ./<File> | nc -l 3000
```

Receiver
```bash
$ nc foobar.com 3000 | pv > <File>
```
### FTP

Sender
```bash
$ ftp -A ftp://<user>:<password>@<host>:<port:21>/tmp/
```

### scp

Sender
```bash
$ scp -P <port:22> <file> <host>:/tmp/
```

Receiver
```bash
$ scp -P <port:22> <host>:/file/to/pasth/<file> /tmp/
```

### File SQL "[ q ](https://github.com/harelba/q)([ SS ](http://www.slideshare.net/serima1/87php-lt))"

I don't use "q" now.
```bash
$ q 'SELECT c1, COUNT(*) AS count FROM ./<file.csv> WHERE c3 > 0 GROUP BY c1'
```

### File merge

vertical
```bash
$ cat file1.tsv
1,neco
3,cat
2,nuko

$ cat file2.tsv
2,かわいい

$ cat file1.tsv file2.tsv > file3.tsv
$ cat file3.tsv
1,neco
3,cat
2,nuko
2,かわいい
```

horizontal
```bash
$ cat file1.tsv
1,neco
3,cat
2,nuko

$ cat file2.tsv
2,かわいい

$ paste file1.tsv file2.tsv > file3.tsv
$ cat file3.tsv
1,neco  2,かわいい
3,cat   
2,nuko  
```

### File sort

No make temporary file
```bash
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

### File uniq

sort and uniq
```bash
$ uniq <(sort file1) > output
```

### File word count

word count
```bash
$ cat <file>
apple
orange
orange
apple
melon
$ sort <file> | uniq -c
2 apple
1 melon
2 orange
```

## SSH

```bash
$ ssh -p <port:22> -i <file.pem> <user>@<host>
```

## SSH(Step by step)

```bash
$ ssh -p <port:22> <user2>@<host2>
```
> ex)$HOME/.ssh/config
> ```apache
> # Step Server {{{
> Host         host               # 実際にコマンドで入力する名前 (任意)
> HostName     host.hoge.fuga     # ホスト名
> User         user1              # ログインユーザ名
> IdentityFile $HOME/.ssh/id_rsa  # 秘密鍵のファイル名
> #}}}
> # Target Server {{{
> Host           host2
> HostName       host2.foo.bar
> User           user2
> IdentityFile   $HOME/.ssh/id_rsa
> ProxyCommand   ssh -CW %h:%p host@user1
> #}}}
> ```

## SSHFS

mount
```bash
$ sshfs -o follow_symlinks -p <port:22> <user>@<host>:/<RemoteDirectory> ./<LocalDirectory>

# Vagrant
$ vagrant ssh-config
Host default
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /path/to/path/private_key
  IdentitiesOnly yes
  LogLevel FATAL

$ sshfs -o follow_symlinks -o IdentitiesOnly=yes -o IdentityFile=/path/to/path/private_key -p 2222 vagrant@127.0.0.1:/<RemoteDirectory> ./<LocalDirectory>
```

unmount
```bash
$ diskutil unmount ./<directory>
```

## Grep

file grep using alias
```bash
$ FIND <keyword>
```

## Network

All network interface
```bash
$ ifconfig -a
```

5 request
```bash
$ ping -d -c 5 <host>
```

Trace route
```bash
$ traceroute -d -p <port> <host>
```

Tcpdump
```bash
$ sudo tcpdump -s0 -A -w /tmp/tcpdump_`date +%Y%m%d_%H%M`.cap port <port:80> host <host>
$ sudo tcpdump -s0 -A -w /tmp/tcpdump_`date +%Y%m%d_%H%M`.cap port <port:80> dst host <host>
$ sudo tcpdump -s0 -A -w /tmp/tcpdump_`date +%Y%m%d_%H%M`.cap port <port:80> src host <host>
```

## File size

disc file system size
```bash
$ df -h
```

directory size
```bash
$ du -sh *
```

file size under directory
```bash
$ find ./ -ls
```

## nohup & disown

Hung up block
```bash
$ nohup <command> > /tmp/nohup.log 2>&1 &
```
途中でバックグラウンド化
```bash
$ <command>
 Ctrl+z
$ jobs
$ disown <PID>
```

## sed

```bash
$ sed -i -e 's/xxx/XXX/g' <file1>
```

## awk

'\47' is SingleQuote.
```bash
$ awk -F "," '{print "{\047id\047:"$1",\047name\047:"$2"}"}' <dumpFile>.csv > /tmp/<dumpFile>_result.csv
```

## Service

Check service status list
```bash
$ service --status-all
```

Check auto start service list
```bash
$ chkconfig --list
```

## File compress/decompress

| 拡張子       | 圧縮                                  | 解凍                                                   |
| :------------| :------------------------------------ | :----------------------------------------------------- |
|.bz2          | $ bzip2    file1                      | $ bzip2 -dc  archive.bz2<br />$ bunzip2 -c archive.bz2 |
|.gz           | $ gzip     file1                      | $ gunzip     archive.gz                                |
|.tgz, .tar.gz | $ tar zcvf archive.tar.gz file1 file2 | $ tar zxvf   archive.tar.gz                            |
|.zip          | $ zip -r   archive.zip    file1 file2 | $ unzip      archive.tar.gz                            |
