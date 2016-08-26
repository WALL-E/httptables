软件防火墙设计文档
===============

版本: v0.6

日期: 2016年08月13日


# 一. 前置条件
本软件只在某些场景下适用

* 需要安装nginx, 并且需要支持lua, 推荐使用openresty套件
* 用户定义(mark)
  * 来源IP （需要上游代理传递客户端来源IP，默认从ngx.remote_addr获取）
  * 设备ID （推荐以HTTP Header形式传递，默认名为X-Device-ID）
  * 用户ID （推荐以HTTP Header形式传递，默认名为X-User-ID）
* 软件本身不会生成规则，需要第三方系统下发规则


# 二. 设计原则
* 每一种用户(mark)都可以独立并且唯一识别一个HTTP请求调用者，目前默认有三种mark
  * 来源IP
  * 设备ID
  * 用户ID
* 每条规则只允许设置一种mark

# 三. 规则组成
每条规则由5部分组成

* mark，默认支持3种类型
* attr，规则属性
  * uri
  * method 请求方法
* expired 失效时间
* action 动作
* response 自定义响应内容
* duration 延迟请求的时间长度


# 四. 架构设计

* 数据流

   Nginx(httptables) <--  httptables-manager <-- (用户行为系统、风控系统)

* 事件流

  更新规则 -> 实时生效(需要主要触发事件)

  更新规则 -> 定时生效(cron触发)


# 五. 数据库设计
规则使用MySQL作持久化存储，涉及到2个表，表字段请查看 [Restful接口设计](#RestFul接口设计)

* role_type
* role


# 六. RestFul接口设计
<span id = "RestFul设计">
使用http API接口管理规则，采用Restful风格的设计理念，数据格式目前仅支持
</span>

* x-www-form-urlencoded

** 规则类型或规则更新后，需要调用http://httptables_host:10983:/admin/notify, 通知httptables同步更新数据，如果是多台httptables，需要依次通知**

## 规则类型
目前内置三种规则类型

* 接口地址：/apis/role_types
* 权限：创建/更新/删除/查看
* 请求方法：GET/POST/PUT/PATCH/DELETE

| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| name    | 字符串(64)    | 目前仅支持三种origin、device、user    |
| priority    | 整型    |  规则优先级相同时，执行顺序不确定   |
| lamda    | 字符串(1024)    |   有效的lua语句，定义怎样获取数据，目前不支持修改(可选)  |
| enable    | 整型    |   此类规则是否启用，0表示停用，1表示启用, 默认值为1  |
| optional  | 整型    |   此类规则是否可选，0表示不可选，1表示可选, 默认值为0  |
| domain  | 字符串(1024)  |  域名，类似命名空间  |

`注意：name和domain两个字段需要保证联合唯一性`

返回数据格式

```
[
    {
        "url": "http://172.28.32.105:10085/apis/role_types/2/",
        "name": "device",
        "priority": 1,
        "lamda": "return ngx.req.get_headers()['X-Device-ID']",
        "enable": 1,
        "optional":0,
        "domain": "apis.t.com"
    },
    {
        "url": "http://172.28.32.105:10085/apis/role_types/3/",
        "name": "user",
        "priority": 1,
        "lamda": "return ngx.req.get_headers()['X-User-ID']",
        "enable": 1,
        "optional":0,
        "domain": "apis.t.com"
    },
    {
        "url": "http://172.28.32.105:10085/apis/role_types/5/",
        "name": "origin",
        "priority": 3,
        "lamda": "return ngx.var.remote_addr",
        "enable": 1,
        "optional":0,
        "domain": "apis.t.com"
    }
]

或者是

{
    "message": "ok",
    "result": [
        {
            "id": 2,
            "name": "device",
            "priority": 1,
            "lamda": "return ngx.req.get_headers()['X-Device-ID']",
            "enable": 1,
            "optional":0,
            "domain": "apis.t.com"
        },
        {
            "id": 3,
            "name": "user",
            "priority": 1,
            "lamda": "return ngx.req.get_headers()['X-User-ID']",
            "enable": 1,
            "optional":0,
            "domain": "apis.t.com"
        },
        {
            "id": 5,
            "name": "origin",
            "priority": 3,
            "lamda": "return ngx.var.remote_addr",
            "enable": 1,
            "optional":0,
            "domain": "apis.t.com"
        },
        {
            "id": 12,
            "name": "user1",
            "priority": 1,
            "lamda": "return ngx.req.get_headers()['XX-User-ID']",
            "enable": 1,
            "optional":0,
            "domain": "apis.t.com"
        }
    ],
    "status": 200
}
```

## 规则
规则详细内容

* 接口地址：/apis/roles
* 权限：创建/更新/删除/查看
* 请求方法：GET/POST/PUT/PATCH/DELETE


| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| type    | 字符串(64)    | 规则类型，支持origin，device，user    |
| mark    | 字符串(1024)    | IP地址，或者是设备id或者是用户id。多个用逗号分隔    |
| uri    | 字符串(1024)    | 请求地址，不包含query参数    |
| method    | 字符串(64)    | 请求方法，多个值以逗号分隔    |
| createtime    | 整型    |  规则创建时间   |
| expired    | 整型    |  规则失效时间(unix timestamp)   |
| action    | 字符串(64)    |   目前仅支持reject、defer  |
| response    | json字符串(1024)    |   响应体内容，需要符合resthub规范(可选)  |
| duration    | 整型    |   延迟请求的时间长度, 单位是毫秒, 默认是0 (可选)  |
| domain  | 字符串(1024)  |  域名，类似命名空间  |
返回数据格式

```
[
    {
        "url": "http://172.28.32.105:10085/apis/roles/3/",
        "type": "device",
        "mark": "device_1",
        "uri": "/test/device",
        "method": "post",
        "createtime": 1470304637,
        "expired": 1475246619,
        "action": "reject",
        "response": "{\"status\":4003, \"message\":\"illegal device\"}",
        "duration": 0,
        "domain": "apis.t.com"
    },
    {
        "url": "http://172.28.32.105:10085/apis/roles/4/",
        "type": "user",
        "mark": "user_1",
        "uri": "/test/user",
        "method": "get",
        "createtime": 1470304637,
        "expired": 1475246619,
        "action": "reject",
        "response": "{\"status\":4002, \"message\":\"illegal user\"}",
        "duration": 0,
        "domain": "apis.t.com"
    },
    {
        "url": "http://172.28.32.105:10085/apis/roles/18/",
        "type": "origin",
        "mark": "127.0.0.1",
        "uri": "/test/origin",
        "method": "get,post",
        "createtime": 1470304637,
        "expired": 1475246619,
        "action": "reject",
        "response": "{\"status\":4001, \"message\":\"illegal origin\"}",
        "duration": 0,
        "domain": "apis.t.com"
    }
]

或者是

{
    "message": "ok",
    "result": [
        {
            "id": 3,
            "type": "device",
            "mark": "device_1",
            "uri": "/test/device",
            "method": "post",
            "createTime": 1470304637,
            "expired": 1475246619,
            "action": "reject",
            "response": "{\"status\":4003, \"message\":\"illegal device\"}",
            "duration": 0,
            "domain": "apis.t.com"
        },
        {
            "id": 4,
            "type": "user",
            "mark": "user_1",
            "uri": "/test/user",
            "method": "get",
            "createTime": 1470304637,
            "expired": 1475246619,
            "action": "reject",
            "response": "{\"status\":4002, \"message\":\"illegal user\"}",
            "duration": 0,
            "domain": "apis.t.com"
        },
        {
            "id": 8,
            "type": "origin",
            "mark": "106.38.84.66",
            "uri": "repayment",
            "method": "put,post",
            "createTime": 1470734880,
            "expired": 1475246619,
            "action": "reject",
            "response": "{\"code\":0,\"result\":{},\"msg\":\"对不起，您的IP发生还款请求异常\",\"success\":false}",
            "duration": 0,
            "domain": "apis.t.com"
        }
    ],
    "status": 200
}
```

# 七. 规则引擎设计
规则引擎使用Nginx+Lua实现

## 引擎逻辑
按照规则优先级，遍历所有类型的规则(待优化)

## 管理接口
默认管理接口为10983

* 发送更新通知，立即从Http/Redis获取最新配置
  * get http://host:10983/admin/notify
* 查看规则版本号
  * get http://host:10983/admin/status
* 查看规则类型
  * get http://host:10983/admin/role_types
* 查看规则
  * get http://host:10983/admin/roles
* 查看进行排序优化的规则
  * get http://host:10983/admin/sorted_role_types
