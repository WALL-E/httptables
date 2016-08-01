-- httptables startup

local _M = {}

local ngx = require "ngx"


function _M.init()
    ngx.log(ngx.INFO, "[Global] init")
end

function _M.init_worker()
    ngx.log(ngx.INFO, "[Global] init_worker")
end

return _M
