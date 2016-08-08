-- httptables startup

local _M = {}

local ngx = require "ngx"
local cjson = require "cjson"
local policy = require "policy"

shared_role_types = nil
shared_roles = nil
shared_version_counter = 0

function _M.increase_version_counter()
    local data = ngx.shared.data

    local version_counter = data:get("version_counter")
    if not version_counter then
        version_counter = 1
    else
        version_counter = version_counter + 1
    end

    data:set("version_counter", version_counter)
    ngx.log(ngx.INFO, "[lib:increase_version_counter] version_counter 2: ", version_counter)
end

function _M.get_version_counter()
    local data = ngx.shared.data
    return data:get("version_counter")
end


-- load config to lua_shared_dict
function _M.load_policy_from_lua()
    ngx.log(ngx.INFO, "[lib] load_policy_from_lua")
    local data = ngx.shared.data
    _M.increase_version_counter()
    data:set("role_types_json", policy.role_types_json)
    data:set("roles_json", policy.roles_json)
end

-- load config to woeker's var from lua_shared_dict
function _M.update_worker_policy()
    ngx.log(ngx.INFO, "[lib] update_woker_policy")

    local data = ngx.shared.data
    local role_types_json = data:get("role_types_json")
    local roles_json = data:get("roles_json")

    ngx.log(ngx.INFO, "role_types_josn: ", role_types_json)
    ngx.log(ngx.INFO, "roles_json: ", roles_json)

    shared_role_types = cjson.decode(role_types_json)
    shared_roles = cjson.decode(roles_json)
end

return _M
