-- httptables startup

local _M = {}

local ngx = require "ngx"
local lib = require "lib"

function _M.init()
    ngx.log(ngx.INFO, "[Global] init")
    lib.set_center_version_counter(0)
end

function _M.init_worker()
    ngx.log(ngx.INFO, "[Global] init_worker")
end

return _M
