<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [RESTClient](#restclient)
  - [Cookie](#cookie)
  - [JSON(POST or PUT)](#jsonpost-or-put)
  - [POST](#post)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

RESTClient
===

## Cookie

* 開発ツール > Cookie > Cookie情報の表示
* RESTClient > Headers > Custom Header
```
Name:  Set-Cookie
Value: id=1
```

## JSON(POST or PUT)

* RESTClient > Headers > Custom Header
```
Name:  Content-Type
Value: application/json
```
* RESTClient > Method
```
POST or PUT
```
* RESTClient > Body
```
{
    "id": 1,
    "name": "KazuakiM"
}
```

## POST

* RESTClient > Headers > Custom Header
```
Name:  Content-Type
Value: application/x-www-form-urlencoded
```
* RESTClient > Method
```
POST
```
* RESTClient > Body
```
id=1&name=KazuakiM
```
