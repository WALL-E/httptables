软件防火墙设计文档
===============

版本: v0.3

日期: 2016年08月01日


一. 前置条件
-----------

* 需要安装nginx, 并且需要支持lua, 推荐使用openresty套件
* 每一个URL对应唯一一个业务场景
* 用户定义
  * 来源IP （需要上游代理传递客户端来源IP，默认从ngx.remote_addr获取）
  * 设备ID （推荐以HTTP Header形式传递，默认名为Access-Device-Id）
  * 用户ID （推荐以HTTP Header形式传递，默认名为Access-User-Id）
* 需要风控系统或手动下发规则

二. 管理接口(Admin)设计
-----------
使用http API接口管理规则，采用Restful风格的设计理念，数据格式目前仅支持

* x-www-form-urlencoded

## 规则类型
目前内置三种规则类型

* 接口地址：/apis/httptables/  
* 权限：查看/更新
* 请求方法：GET/PATCH

| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| name    | 字符串    | 目前仅支持三种origin、device、user    |
| priority    | 整型    |  规则优先级相同时，执行顺序不确定   |
| lamda    | 字符串    |   有效的lua语句，定义怎样获取数据，目前不支持修改(可选)  |
| enable    | 整型    |   是否启用此类规则，0表示停用，1表示启用  |


## 来源规则
使用客户端IP定义

* 接口地址：/apis/httptables/origins  
* 权限：创建/更新/删除/查看 
* 请求方法：GET/POST/PUT/PATCH/DELETE


| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| ip    | ip地址    | 目前仅支持单IP，将来可以支持子网设置    |
| uri    | 字符串    | 请求地址，不包含query参数    |
| method    | 字符串    | 请求方法，多个值以逗号分隔    |
| ttl    | 整型    |  规则生效时间(秒)，0表示永久   |
| judge    | 字符串    |   目前仅支持reject、delay(毫秒)  |
| response    | json字符串    |   响应体内容，需要符合resthub规范(可选)  |

## 设备规则
每个设备需要生成全球唯一的设备ID

* 接口地址：/httptables/devices 
* 权限：创建/更新/删除/查看 
* 请求方法：GET/POST/PUT/PATCH/DELETE

| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| deviceid    | 字符串    | 有效的设备id    |
| uri    | 字符串    | 请求地址，不包含query参数    |
| method    | 字符串    | 请求方法，多个值以逗号分隔    |
| ttl    | 整型    |  规则生效时间(秒)，0表示永久   |
| judge    | 字符串    |   目前仅支持reject、delay(毫秒)  |
| response    | json字符串    |   响应体内容，需要符合resthub规范(可选) |
## 用户规则
每个用户需要生成全球唯一的用户ID

* 接口地址：/httptables/users 
* 权限：创建/更新/删除/查看 
* 请求方法：GET/POST/PUT/PATCH/DELETE

| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| userid    | 字符串    | 有效的用户id    |
| uri    | 字符串    | 请求地址，不包含query参数    |
| method    | 字符串    | 请求方法，多个值以逗号分隔    |
| ttl    | 整型    |  规则生效时间(秒)，0表示永久   |
| judge    | 字符串    |   目前仅支持reject、delay(毫秒)  |
| response    | json字符串    |   响应体内容，需要符合resthub规范(可选)  |

三. 规则引擎设计
-----------
略。
