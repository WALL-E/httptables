-- httptables startup

local _M = {}

local ngx = require "ngx"
local cjson = require "cjson"
local redis_api = require "redis_api"

shared_role_types = {}
shared_roles = {}
shared_version_counter = 0
shared_sync_pending = false

function _M.try_reload_policy()
    local center_version_counter = _M.get_center_version_counter()
    if _M.get_shared_version_counter() < center_version_counter and not shared_sync_pending then
        shared_sync_pending = true
        local ret = _M.load_policy_from_redis()
        if ret then
            _M.set_shared_version_counter(center_version_counter)
            ngx.log(ngx.INFO, "[try_reload_policy] shared_version_counte: ", _M.get_shared_version_counter(), 
                              ", center_version_counter:", _M.get_center_version_counter())
        end
        shared_sync_pending = false
    end
end

function _M.get_shared_version_counter(v)
    return shared_version_counter
end

function _M.set_shared_version_counter(v)
    shared_version_counter = v
end

function _M.increase_center_version_counter()
    local counter = _M.get_center_version_counter()
    counter = counter + 1
    _M.set_center_version_counter(counter)
end

function _M.set_center_version_counter(v)
    local data = ngx.shared.data
    data:set("center_version_counter", v)
end

function _M.get_center_version_counter()
    local data = ngx.shared.data
    return data:get("center_version_counter")
end

-- load config to lua_shared_dict from Redis
function _M.load_policy_from_redis()
    ngx.log(ngx.INFO, "[policy] load_policy_from_redis")
    local rds, err = redis_api.open_redis()
    if not rds then
        ngx.log(ngx.ERR, "connect redis failed")
        return false
    end

    local role_types_json, err = rds:hget("__httptables__", "role_types")
    if role_types_json == ngx.null or not role_types_json then
        ngx.log(ngx.ERR, "read [role_types] from redis failed")
        return false
    end

    local roles_json, err = rds:hget("__httptables__", "roles")
    if roles_json == ngx.null or not roles_json then
        ngx.log(ngx.ERR, "read [roles] from redis failed")
        return false
    end

    local data = ngx.shared.data
    shared_role_types = cjson.decode(role_types_json)
    shared_roles = cjson.decode(roles_json)
    return true
end

-- load config to woeker's var from lua_shared_dict
function _M.update_worker_policy()
    ngx.log(ngx.INFO, "[policy] update_woker_policy")

    local data = ngx.shared.data
    local role_types_json = data:get("role_types_json")
    local roles_json = data:get("roles_json")

    ngx.log(ngx.INFO, "role_types_josn: ", role_types_json)
    ngx.log(ngx.INFO, "roles_json: ", roles_json)

    shared_role_types = cjson.decode(role_types_json)
    shared_roles = cjson.decode(roles_json)
end

return _M
