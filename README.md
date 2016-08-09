# httptables (just like Linux's iptables)
httptables是一个基于OpenResty，面向web应用的轻量级（Lightweight）软防火墙，可以配合第三方系统（用户行为分析系统）针对符合特定条件的HTTP请求做不同的处理。


Design details please click [OUTLINE.md](OUTLINE.md)。

## World views 
httptables的世界里，每个客户端有三种独立身份，并且每种身份都是唯一标识

* `Origin` 来源IP地址
* `User`   用户ID
* `Device` 设备ID

## Features
本软件支持以下功能点

* 熔断(circuit breakers)
  * **Reject** 阻断用户访问，返回自定义内容响应体
* 减速带(speed bump)
  * **Defer** 放慢用户的请求速度

## Install
安装请点击[INSTALL.md](doc/INSTALL.md)。

# Copyleft
Thank you for the following open source projects


* OpenResty

  [OpenResty](https://openresty.org/en/) OpenResty ™ is a full-fledged web platform by integrating the standard Nginx core, LuaJIT, many carefully written Lua libraries, lots of high quality 3rd-party Nginx modules, and most of their external dependencies. It is designed to help developers easily build scalable web applications, web services, and dynamic web gateways.

* Kong

  [Kong](http://www.getkong.org/) is a scalable, open source API Layer (also known as an API Gateway, or API Middleware). Kong runs in front of any RESTful API and is extended through Plugins, which provide extra functionalities and services beyond the core platform.

