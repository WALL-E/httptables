# httptables (just like Linux's iptables)
httptables is a based on the [OpenResty](https://openresty.org/en/), lightweight soft firewall for web application, can cooperate with the third party system(User behavior analysis system), to respond to a malicious request.


Design details please click [OUTLINE.md](doc/OUTLINE中文版.md)。

## Deployment diagram

* green: implemented [httptables-manager](https://github.com/WALL-E/httptables-manager)
* yellow: not implemented

![image](doc/httptables-infrastructure.png)

## World views 
In her world, each client has three separate identity, and each is unique

* `Origin` The source address of client
* `User`   The User ID
* `Device` The Device ID

## Features
Support the following features

* circuit breakers
  * **Reject** Blocking the user requests, return the response of custom content
* speed bump
  * **Defer** SLowing down of the request of the user

## Install
Please click [INSTALL.md](doc/INSTALL.md) to view the installation documentation


# Copyleft
Thank you for the following open source projects


* OpenResty

  <span id="OpenResty">[OpenResty](https://openresty.org/en/)™</span> is a full-fledged web platform by integrating the standard Nginx core, LuaJIT, many carefully written Lua libraries, lots of high quality 3rd-party Nginx modules, and most of their external dependencies. It is designed to help developers easily build scalable web applications, web services, and dynamic web gateways.

* Kong

  [Kong](http://www.getkong.org/) is a scalable, open source API Layer (also known as an API Gateway, or API Middleware). Kong runs in front of any RESTful API and is extended through Plugins, which provide extra functionalities and services beyond the core platform.

