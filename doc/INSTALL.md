# Install

# Pre condition
You need to install [httptables-manager](https://github.com/WALL-E/httptables-manager) first

## Simple
Auto install openresty and htptables

```
sudo httptables/install.sh /apps/waf
```

## Advanced
Frist, your nginx is suppport Lua, second, modify the nginx.conf

```
http {
  ...
  include httptables/httptables.conf;
  ...
}
```

and copy lua script

```
cp -r httptables NGINX_HOME/conf/
```

## startup

```
sbin/nginx -c conf/nginx.conf
```


## demo

* curl http://127.0.0.1:10983/

```
httptables version: 16.8.23-alpha
```

* curl http://127.0.0.1:10983/admin/status

```
{"status":200, "message":"ok", "result": {"center_version_counter":722,"shared_version_counter":719}}
```

* curl http://127.0.0.1:10983/admin/roles

```
{"status":200, "message":"ok", result:[{"expired":1475246619,"duration":100,"createtime":1470304637,"uri":"\/test\/device","method":"get","response":"{\"status\":4003, \"message\":\"illegal device\"}","type":"device","url":"http:\/\/127.0.0.1:8080\/apis\/roles\/1\/","action":"reject","domain":"apis.t.com","mark":"device_1"},{"expired":1475246619,"duration":100,"createtime":1470304637,"uri":"\/test\/user","method":"get","response":"{\"status\":4002, \"message\":\"illegal user\"}","type":"user","url":"http:\/\/127.0.0.1:8080\/apis\/roles\/2\/","action":"reject","domain":"apis.t.com","mark":"user_1"},{"expired":1475246619,"duration":100,"createtime":1470304637,"uri":"\/test\/origin","method":"get","response":"{\"status\":4001, \"message\":\"illegal origin\"}","type":"origin","url":"http:\/\/127.0.0.1:8080\/apis\/roles\/3\/","action":"reject","domain":"apis.t.com","mark":"127.0.0.1"},{"expired":1475246619,"duration":100,"createtime":1470304637,"uri":"\/test\/device","method":"get","response":"{\"status\":4103, \"message\":\"illegal device\"}","type":"device","url":"http:\/\/127.0.0.1:8080\/apis\/roles\/4\/","action":"reject","domain":"apis.z.com","mark":"device_1"},{"expired":1475246619,"duration":100,"createtime":1470304637,"uri":"\/test\/user","method":"get","response":"{\"status\":4102, \"message\":\"illegal user\"}","type":"user","url":"http:\/\/127.0.0.1:8080\/apis\/roles\/5\/","action":"reject","domain":"apis.z.com","mark":"user_1"},{"expired":1475246619,"duration":100,"createtime":1470304637,"uri":"\/test\/origin","method":"get","response":"{\"status\":4101, \"message\":\"illegal origin\"}","type":"origin","url":"http:\/\/127.0.0.1:8080\/apis\/roles\/6\/","action":"reject","domain":"apis.z.com","mark":"127.0.0.1"}]}
```

* curl http://127.0.0.1:10983/admin/role_types

```
{"status":200, "message":"ok", result:[{"enable":1,"optional":0,"lamda":"return ngx.req.get_headers()['X-Device-ID']","url":"http:\/\/127.0.0.1:8080\/apis\/role_types\/1\/","name":"device","priority":1,"domain":"apis.t.com"},{"enable":1,"optional":0,"lamda":"return ngx.req.get_headers()['X-User-ID']","url":"http:\/\/127.0.0.1:8080\/apis\/role_types\/2\/","name":"user","priority":2,"domain":"apis.t.com"},{"enable":1,"optional":0,"lamda":"return ngx.var.remote_addr","url":"http:\/\/127.0.0.1:8080\/apis\/role_types\/3\/","name":"origin","priority":3,"domain":"apis.t.com"},{"enable":1,"optional":0,"lamda":"return ngx.req.get_headers()['X-Device-ID']","url":"http:\/\/127.0.0.1:8080\/apis\/role_types\/4\/","name":"device","priority":1,"domain":"apis.z.com"},{"enable":1,"optional":0,"lamda":"return ngx.req.get_headers()['X-User-ID']","url":"http:\/\/127.0.0.1:8080\/apis\/role_types\/5\/","name":"user","priority":2,"domain":"apis.z.com"},{"enable":1,"optional":0,"lamda":"return ngx.var.remote_addr","url":"http:\/\/127.0.0.1:8080\/apis\/role_types\/6\/","name":"origin","priority":3,"domain":"apis.z.com"}]}
```

* curl http://127.0.0.1:10983/admin/notify

```
{"status":200, "message":"ok", "result": {"center_version_counter": 723}}
```

* curl http://127.0.0.1:8000/test/device -H "host: apis.t.com" -H "X-Device-ID: device_1"

```
{"status":4003, "message":"illegal device"}
```

* curl http://127.0.0.1:8000/test/device -H "host: apis.t.com" -H "X-Device-ID: device_2"

```
{"status":400, "message": "mark: user must be set"}
```

* curl http://127.0.0.1:8000/test/device -H "host: apis.t.com" -H "X-Device-ID: device_2" -H "X-User-ID: user_1"

```
{"status":200, "message": "hello, httptables from unix-domain"}
```
