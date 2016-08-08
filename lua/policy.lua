
local _M = {}

_M.role_types_json = [==[
[
	{
		"enable": 1,
		"name":"origin",
		"priority":3
                "lamda": "function () {return ngx.var.remote_addr}"
	},
	{
		"enable":1,
		"name":"device",
		"priority":2},
                "lamda": "function () {return ngx.req.get_headers()[\"X-Device-ID\"]}"
	{
		"enable":1,
		"name":"user",
		"priority":1
                "lamda": "function () {return ngx.req.get_headers()[\"X-User-ID\"]}"
	}
]
]==]

_M.roles_json = [==[
[
    {
	    "response":"{\"status\":4001, \"message\":\"illegal origin\"}",
	    "method":"get,post",
	    "uri":"\/test\/origin",
	    "action":"reject",
	    "type":"origin",
	    "expired":1480626687,
	    "createtime":1470304637,
	    "mark":"127.0.0.1"
    },
    {
    	"response":"{\"status\":4003, \"message\":\"illegal device\"}",
    	"method":"post",
    	"uri":"\/test\/device",
    	"action":"reject",
    	"type":"device",
    	"expired":1480626687,
    	"createtime":1470304637,
    	"mark":"device_1"
    },
    {
    	"response":"{\"status\":4002, \"message\":\"illegal user\"}",
    	"method":"get",
    	"uri":"\/test\/user",
    	"action":"reject",
    	"type":"user",
    	"expired":1480626687,
    	"createtime":1470304637,
    	"mark":"user_1"
    }
]
]==]

return _M
