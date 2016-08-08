
local _M = {}

_M.role_types_json = [==[
[
	{
		"enable": 1,
		"name":"origin",
		"priority":3
	},
	{
		"enable":1,
		"name":"device",
		"priority":2},
	{
		"enable":1,
		"name":"user",
		"priority":1
	}
]
]==]

_M.roles_json = [==[
[
    {
	    "response":"{\"status\":4001, \"message\":\"illegal origin\"}",
	    "method":"get,post",
	    "uri":"\/test\/origin",
	    "judge":"reject",
	    "type":"origin",
	    "ttl":360000,
	    "createtime":1470304637,
	    "mark":"127.0.0.1"
    },
    {
    	"response":"{\"status\":4003, \"message\":\"illegal device\"}",
    	"method":"post",
    	"uri":"\/test\/device",
    	"judge":"reject",
    	"type":"device",
    	"ttl":360000,
    	"createtime":1470304637,
    	"mark":"device_1"
    },
    {
    	"response":"{\"status\":4002, \"message\":\"illegal user\"}",
    	"method":"get",
    	"uri":"\/test\/user",
    	"judge":"reject",
    	"type":"user",
    	"ttl":360000,
    	"createtime":1470304637,
    	"mark":"user_1"
    }
]
]==]

return _M
