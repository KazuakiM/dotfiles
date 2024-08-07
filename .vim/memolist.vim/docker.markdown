<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Docker](#docker)
- [Links](#links)
- [share directory](#share-directory)
- [pull](#pull)
- [build](#build)
- [run](#run)
- [start](#start)
- [stop](#stop)
- [attach](#attach)
- [detach](#detach)
- [commit](#commit)
- [delete](#delete)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Docker
===


# Links

* [Docker Hab](https://hub.docker.com/)

# share directory

Preferences > File sharing  
Add ```/srv/xxx```

# login

```bash
$ docker login
ID/PW
```

# pull

```bash
$ docker pull <ContainerName>

# CentOS
$ docker pull centos
```

# build

Build container from Dockerfile.
```bash
docker build [ -t <ImageName>[:<TagName>]] <DockerfilePath>
```

# run

-d : detach  
-v < host_path >:< remote_path > : mount  
> [Check share direcotry!](#share-directory)

```bash
$ docker run -i -t --privileged --name <ContainerName> <ImageName>[:<TagName>] /bin/bash

# CentOS
$ docker run -i -t --privileged --name <ContainerName> centos[:<TagName>] /bin/bash
```

# start

```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
c5457d36f253        centos              "/bin/bash"         56 minutes ago      Exited (1) 19 minutes ago                       exsample

$ docker start c5457d36f253
or
$ docker start exsample

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
c5457d36f253        centos              "/bin/bash"         56 minutes ago      Up 8 seconds                            exsample
```

# stop

```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
c5457d36f253        centos              "/bin/bash"         56 minutes ago      Up 8 seconds                            exsample

$ docker stop c5457d36f253
or
$ docker stop exsample
or
# exit (docker login)

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                       PORTS               NAMES
c5457d36f253        centos              "/bin/bash"         58 minutes ago      Exited (137) 2 seconds ago                       exsample
```

# attach

```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
c5457d36f253        centos              "/bin/bash"         56 minutes ago      Up 8 seconds                            exsample

$ docker attach c5457d36f253
or
$ docker attach exsample

#
```

# detach

```bash
Ctrl + p -> Ctrl + q
```

# commit

```bash
$ docker commit <ContainerName> kazuakim/<Repository>
$ docker images
```

# delete

* Container
```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
c5457d36f253        centos              "/bin/bash"         38 minutes ago      Exited (1) About a minute ago                       exsample
8541933cccdc        hello-world         "/hello"            3 seconds ago       Exited (0) 2 seconds ago                            sick_euclid

$ docker rm 8541933cccdc
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
c5457d36f253        centos              "/bin/bash"         38 minutes ago      Exited (1) About a minute ago                       exsample

$ docker rm `docker ps -a -q`
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
```

* Image
```bash
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos              centos7             abcdefg12345        6 days ago          193 MB
centos              latest              3bee3060bfc8        6 days ago          193 MB

$ docker rmi abcdefg12345
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos              latest              3bee3060bfc8        6 days ago          193 MB

$ docker rmi `docker images -a -q`
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```

ref: http://qiita.com/tifa2chan/items/e9aa408244687a63a0ae
