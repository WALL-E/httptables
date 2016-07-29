-- httptables startup

local P = {}

local ngx = require "ngx"


local function init()
    ngx.log(ngx.INFO, "[Global] init")
end

local function init_worker()
    ngx.log(ngx.INFO, "[Global] init_worker")
end

local function access()
    ngx.log(ngx.INFO, "[Global] access")
end

P.init = init
P.init_worker = init_worker
P.access = access

return P
