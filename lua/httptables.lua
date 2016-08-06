-- httptables startup

local _M = {}

local ngx = require "ngx"
local cjson = require "cjson"
local policy = require "policy"

share_role_types = nil
share_roles = nil


function _M.init()
    ngx.log(ngx.INFO, "[Global] init")
    
    local data = ngx.shared.data
    data:set("role_types_json", policy.role_types_json)
    data:set("roles_json", policy.roles_json)
end

function _M.init_worker()
    ngx.log(ngx.INFO, "[Global] init_worker")

    local data = ngx.shared.data
    local role_types_json = data:get("role_types_json")
    local roles_json = data:get("roles_json")

    ngx.log(ngx.INFO, "role_types_josn: ", role_types_json)
    ngx.log(ngx.INFO, "roles_json: ", roles_json)
end

return _M
