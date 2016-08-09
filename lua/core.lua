
local ngx = require "ngx"
local cjson = require "cjson.safe"
local utils = require "utils"
local policy = require "policy"

policy.try_reload_policy()

--ngx.log(ngx.INFO, "shared_role_types: ", cjson.encode(shared_role_types))
--ngx.log(ngx.INFO, "shared_roles: ", cjson.encode(shared_roles))

local sorted_role_types = utils.deep_copy(shared_role_types)

local mark_funcions = {}
for _,v  in pairs(shared_role_types) do
    mark_funcions[v.name] = loadstring(v.lamda)
end

local uri = ngx.var.uri
local method = ngx.req.get_method()
local timestamp = ngx.now()
local idx


function comps(a, b)
    return a.priority < b.priority
end
table.sort(sorted_role_types, comps)
ngx.log(ngx.INFO, "sorted_role_types: ", cjson.encode(sorted_role_types))

for name,f in pairs(mark_funcions) do
    if not f() then
        ngx.log(ngx.INFO, string.format("mark[%s] is nil", name))
        ngx.exit(ngx.OK)
    end
end

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
                idx,_ = ngx.re.find(v["mark"], mark_funcions[v["type"]]())
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
