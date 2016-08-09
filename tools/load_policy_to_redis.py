#!/usr/bin/python

import redis
import json

role_types = [
	{
		"enable": 1,
		"name":"origin",
		"priority":3,
                "lamda": "return ngx.var.remote_addr"
	},
	{
		"enable":1,
		"name":"device",
		"priority":2,
                "lamda": "return ngx.req.get_headers()['X-Device-ID']"
        },
	{
		"enable":1,
		"name":"user",
		"priority":1,
                "lamda": "return ngx.req.get_headers()['X-User-ID']"
	}
]

roles = [
    {
        "response":'{"status":4001, "message":"illegal origin"}',
        "method":"get,post",
        "uri":"/test/origin",
        "action":"reject",
        "type":"origin",
        "expired":1480626687,
        "createtime":1470304637,
        "mark":"127.0.0.1"
    },
    {
    	"response":'{"status":4003, "message":"illegal device"}',
    	"method":"post",
    	"uri":"/test/device",
    	"action":"reject",
    	"type":"device",
    	"expired":1480626687,
    	"createtime":1470304637,
    	"mark":"device_1"
    },
    {
    	"response":'{"status":4002, "message":"illegal user"}',
    	"method":"get",
    	"uri":"/test/user",
    	"action":"reject",
    	"type":"user",
    	"expired":1480626687,
    	"createtime":1470304637,
    	"mark":"user_1"
    }
]


r = redis.Redis(host='localhost',port=10379,db=0)
r.hset('__httptables__', 'role_types', json.dumps(role_types))
r.hset('__httptables__', 'roles', json.dumps(roles))

