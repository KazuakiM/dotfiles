title: Linux
==========
date: 2014-11-22 20:22
tags: []
categories: []
- - -

# Grep
file grep
```
find ./ -type d -name ".git" -prune -o -type d -name ".svn" -prune -o -type f -exec grep "keyword" {} /dev/null \;
```

# Network
All network interface
```
ifconfig -a
```
5 request
```
ping -d -c 5 <host>
```
Trace route
```
traceroute -d -p <port> <host>
```
Tcpdump
```
tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port> host <host>
tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port> dst host <host>
tcpdump -s0 -A -w /tmp/tcpdump_%Y%m%d_%H%M.cap port <port> src host <host>
```

# File size
disc file system size
```
df -h
```
directory size
```
du -sh *
```
file size under directory
```
find ./ -ls
```
