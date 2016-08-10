
local _M = {}

-- Redis
_M.redis = {}
_M.redis.host = "127.0.0.1"
_M.redis.port = "10379"

_M.http_endpoint = {}
_M.http_endpoint.role_types = "http://172.28.32.105:9000/apis/role_types"
_M.http_endpoint.roles = "http://172.28.32.105:9000/apis/roles"

return _M
