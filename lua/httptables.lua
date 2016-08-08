-- httptables startup

local _M = {}

local ngx = require "ngx"
local lib = require "lib"

function _M.init()
    ngx.log(ngx.INFO, "[Global] init")
    lib.load_policy_from_lua()    
end

function _M.init_worker()
    ngx.log(ngx.INFO, "[Global] init_worker")
    lib.update_worker_policy()
end

return _M
