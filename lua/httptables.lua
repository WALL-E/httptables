-- httptables startup

local _M = {}

local ngx = require "ngx"
local policy = require "policy"

function _M.init()
    ngx.log(ngx.INFO, "[Global] init")
    policy.set_center_version_counter(1)
end

function _M.init_worker()
    ngx.log(ngx.INFO, "[Global] init_worker")
end

return _M
