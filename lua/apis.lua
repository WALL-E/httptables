
local meta = require "meta"
local ngx = require "ngx"
local cjson = require "cjson.safe"
cjson.encode_sparse_array(true)

_G._HTTPTABLES = {
  _NAME = meta._NAME,
  _VERSION = meta._VERSION
}

local _M = {}

function _M.cors() 
    ngx.header["Access-Control-Allow-Origin"] = "*"
    if ngx.req.get_method() == "OPTIONS" then
        ngx.header["Access-Control-Allow-Methods"] = "GET,HEAD,PUT,PATCH,POST,DELETE"
        ngx.header["Access-Control-Allow-Headers"] = "Content-Type"
        ngx.exit(204)
    end
end

function _M.default() 
    ngx.say("Restful admin apis")
end

function _M.roles()
    local reponse = string.format('{"status":200, "message":"ok", result:%s}', cjson.encode(shared_roles))
    ngx.say(reponse)
end

function _M.role_types()
    local reponse = string.format('{"status":200, "message":"ok", result:%s}', cjson.encode(shared_role_types))
    ngx.say(reponse)
end

return _M
