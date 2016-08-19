# lamda function

By default, device and user, keep in the header, like the following

```
X-Device-ID: FB360513-78C1-4F27-BDC2-09848A20C474
X-User-ID:10341243
```

in the httptables-manager，a field of table `role_types`, the name is lamda, keep in the getattr function

* User
  * "return ngx.req.get_headers()['X-User-ID']"
* Device
  * "return ngx.req.get_headers()['X-Device-ID']",


lamda is a lua expression, tells httptables how to get data, you can modify it according to your needs.


httptables integrated a debugging tool, to test lamda string

```
[vagrant@vagrant-172-28-32-105 ~]$ curl -d "lamda=return ngx.req.get_headers()['X-Test-ID']" -H "X-Test-ID: hello,httptables" "http://127.0.0.1:8001/admin/lamda"
hello,httptables
```

If you have more needs, please create a new issues.

