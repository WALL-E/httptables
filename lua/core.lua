
local ngx = require "ngx"
local meta = require "meta"
local cjson = require "cjson.safe"
local utils = require "utils"
local policy = require "policy"
local constants = require "constants"

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
        idx,_ = ngx.re.find(string.lower(v["method"]), string.lower(method))
        if idx then
            ngx.log(ngx.INFO, "XXXX 2, ", uri)
            -- 检查URI
            if uri == v["uri"] then
                ngx.log(ngx.INFO, "XXXX 3, ", v["type"], ",", v["mark"])
                -- 检查mark
                idx,_ = ngx.re.find(v["mark"], mark_funcions[v["type"]]())
                if idx then
                    if v["action"] == constants.ACTION.reject then
                        ngx.say(v["response"])
                        ngx.exit(ngx.HTTP_OK)
                    else if v["action"] == constants.ACTION.defer then
                        ngx.sleep(0.1)
                    else
                       ngx.log(ngx.ERR, string.format("illegal action:", v["action"]))
                    end
                    ngx.log(ngx.NOTICE, string.format("[%s judge] action:%s, uri:%s, method:%s, mark:%s", meta._NAME, v["action"], uri, method, v["mark"]))
                end
            end
        end
    end    
end

ngx.exit(ngx.OK)
