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
