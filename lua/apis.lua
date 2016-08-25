
local meta = require "meta"
local ngx = require "ngx"
local cjson = require "cjson.safe"
cjson.encode_sparse_array(true)
local policy = require "policy"
local pretty = require "prettycjson"

_G._HTTPTABLES = {
  _NAME = meta._NAME,
  _VERSION = meta._VERSION
}

local function say(json)
    ngx.say(pretty(cjson.decode(json)))
end

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
    local response = string.format('{"status":200, "message":"ok", "name": "%s", "version": "%s"}', meta._NAME, meta._VERSION)
    say(response)
end

function _M.roles()
    local response = string.format('{"status":200, "message":"ok", "result":%s}', cjson.encode(shared_roles))
    say(response)
end

function _M.role_types()
    local response = string.format('{"status":200, "message":"ok", "result":%s}', cjson.encode(shared_role_types))
    say(response)
end

function _M.sorted_role_types()
    local response = string.format('{"status":200, "message":"ok", "result":%s}', cjson.encode(sorted_role_types))
    say(response)
end

function _M.notify()
    policy.increase_center_version_counter()
    local response = string.format('{"status":200, "message":"ok", "result": {"center_version_counter": %s}}', policy.get_center_version_counter())
    say(response)
end

function _M.status()
    local status = {
        ["center_version_counter"] = policy.get_center_version_counter(),
        ["shared_version_counter"] = shared_version_counter,
    }
    local response = string.format('{"status":200, "message":"ok", "result": %s}', cjson.encode(status))
    say(response)
end

function _M.lamda()
    ngx.req.read_body()
    local post_args, err = ngx.req.get_post_args()
    if not post_args then
        ngx.say("not found post data")
    else
        local lamda = post_args.lamda
        if not lamda then
            ngx.say("not found lamda from post data")
        else
            local f = loadstring(lamda)
            ngx.say(f())
        end
    end
end

return _M
