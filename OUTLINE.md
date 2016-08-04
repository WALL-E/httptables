软件防火墙设计文档
===============

版本: v0.4

日期: 2016年08月04日


# 一. 前置条件
本软件只在某些场景下适用

* 需要安装nginx, 并且需要支持lua, 推荐使用openresty套件
* 每一个URL对应唯一一个业务场景
* 用户定义
  * 来源IP （需要上游代理传递客户端来源IP，默认从ngx.remote_addr获取）
  * 设备ID （推荐以HTTP Header形式传递，默认名为X-Device-ID）
  * 用户ID （推荐以HTTP Header形式传递，默认名为X-User-ID）
* 需要风控系统或手动下发规则

# 二. 架构设计

* 数据流

   Nginx <-- Redis <-- MySQL <-- Restful(http server) <-- (各种风控系统)

* 事件流

  更新规则 -> 实时生效(需要主要触发事件)

  更新规则 -> 定时生效(cron触发)

* 三级缓存

  MySQL -> Redis -> LocalMem

  高延时 -----------------> 低延时


# 三. 数据库设计
涉及到4个数据库，表字段请查看 [Restful接口设计](#RestFul接口设计)

* role
* origin
* device
* user

# 四. RestFul接口设计
<span id = "RestFul设计">
使用http API接口管理规则，采用Restful风格的设计理念，数据格式目前仅支持
</span>

* x-www-form-urlencoded

## 规则类型
目前内置三种规则类型

* 接口地址：/apis/roles/
* 权限：查看/更新
* 请求方法：GET/PATCH

| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| name    | 字符串(64)    | 目前仅支持三种origin、device、user    |
| priority    | 整型    |  规则优先级相同时，执行顺序不确定   |
| lamda    | 字符串(1024)    |   有效的lua语句，定义怎样获取数据，目前不支持修改(可选)  |
| enable    | 整型    |   是否启用此类规则，0表示停用，1表示启用  |


## 来源规则
使用客户端IP定义

* 接口地址：/apis/roles/origins
* 权限：创建/更新/删除/查看 
* 请求方法：GET/POST/PUT/PATCH/DELETE


| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| ip    | ip地址(64)    | 目前仅支持单IP，多个IP使用逗号分隔    |
| uri    | 字符串(1024)    | 请求地址，不包含query参数    |
| method    | 字符串(64)    | 请求方法，多个值以逗号分隔    |
| createtime    | 整型    |  规则创建时间，0表示当前时间   |
| ttl    | 整型    |  规则生效时间(秒)，0表示永久   |
| judge    | 字符串(64)    |   目前仅支持reject、delay(毫秒)  |
| response    | json字符串(1024)    |   响应体内容，需要符合resthub规范(可选)  |

## 设备规则
每个设备需要生成全球唯一的设备ID

* 接口地址：/roles/devices
* 权限：创建/更新/删除/查看 
* 请求方法：GET/POST/PUT/PATCH/DELETE

| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| deviceid    | 字符串(64)    | 有效的设备id    |
| uri    | 字符串(1024)    | 请求地址，不包含query参数    |
| method    | 字符串(64)    | 请求方法，多个值以逗号分隔    |
| createtime    | 整型    |  规则创建时间，0表示当前时间(可选)   |
| ttl    | 整型    |  规则生效时间(秒)，0表示永久   |
| judge    | 字符串(64)    |   目前仅支持reject、delay(毫秒)  |
| response    | json字符串(1024)    |   响应体内容，需要符合resthub规范(可选) |
## 用户规则
每个用户需要生成全球唯一的用户ID

* 接口地址：/roles/users
* 权限：创建/更新/删除/查看 
* 请求方法：GET/POST/PUT/PATCH/DELETE

| 参数 | 类型 | 说明 |
| :-----|:----| :----|
| userid    | 字符串(64)    | 有效的用户id    |
| uri    | 字符串(1024)    | 请求地址，不包含query参数    |
| method    | 字符串(64)    | 请求方法，多个值以逗号分隔    |
| createtime    | 整型    |  规则创建时间，0表示当前时间(可选)   |
| ttl    | 整型    |  规则生效时间(秒)，0表示永久   |
| judge    | 字符串(64)    |   目前仅支持reject、delay(毫秒)  |
| response    | json字符串(1024)    |   响应体内容，需要符合resthub规范(可选)  |


# 五. 规则引擎设计
规则引擎使用Nginx+Lua实现

## 引擎逻辑
按照规则优先级，遍历所有类型的规则

## 管理接口
默认管理接口为10983

* 更新规则，立即从Redis获取最新配置
  * http://127.0.0.1:10983/admin/update
* 查看规则事件统计
  * http://127.0.0.1:10983/admin/status
