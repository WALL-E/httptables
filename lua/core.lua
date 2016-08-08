
local ngx = require "ngx"
local cjson = require "cjson.safe"
local utils = require "utils"

ngx.log(ngx.INFO, "shared_role_types: ", cjson.encode(shared_role_types))
ngx.log(ngx.INFO, "shared_roles: ", cjson.encode(shared_roles))

local sorted_role_types = utils.deep_copy(shared_role_types)

local marks = {}
marks.origin = ngx.var.remote_addr
marks.device = ngx.req.get_headers()["X-Device-ID"]
marks.user = ngx.req.get_headers()["X-User-ID"]
ngx.log(ngx.INFO, "marks: ", cjson.encode(marks))

local uri = ngx.var.uri
local method = ngx.req.get_method()
local timestamp = ngx.now()
local idx


function comps(a, b)
    return a.priority < b.priority
end
table.sort(sorted_role_types, comps)
ngx.log(ngx.INFO, "sorted_role_types: ", cjson.encode(sorted_role_types))

if not marks.device then
    ngx.log(ngx.INFO, "device_id is nil")
    ngx.exit(ngx.OK)
end

if not marks.user then
    ngx.log(ngx.INFO, "user_id is nil")
    ngx.exit(ngx.OK)
end

ngx.log(ngx.INFO, "XXXXXX")
-- origins
for _,v  in pairs(shared_roles) do
    ngx.log(ngx.INFO, "XXXX 0")
    -- 检查规则有效期
    if v["expired"] > timestamp then
        ngx.log(ngx.INFO, "XXXX 1,", method)
        -- 检查请求方法
        idx,_ = ngx.re.find(v["method"], string.lower(method))
        if idx then
            ngx.log(ngx.INFO, "XXXX 2, ", uri)
            -- 检查URI
            if uri == v["uri"] then
                ngx.log(ngx.INFO, "XXXX 3, ", v["type"], ",", v["mark"])
                -- 检查mark
                idx,_ = ngx.re.find(v["mark"], marks[v["type"]])
                if idx then
                    ngx.log(ngx.INFO, "XXXX 4")
                    ngx.say(v["response"])
                    ngx.exit(ngx.HTTP_OK)
                end
            end
        end
    end    
end

ngx.exit(ngx.OK)
