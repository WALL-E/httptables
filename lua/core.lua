
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
--ngx.log(ngx.INFO, "sorted_role_types: ", cjson.encode(sorted_role_types))

-- origins
for _,v  in pairs(shared_roles) do
    -- 检查规则有效期
    ngx.log(ngx.INFO, "check expired")
    if v["expired"] > timestamp then
        -- 检查请求方法
        ngx.log(ngx.INFO, "check method")
        idx,_ = ngx.re.find(string.lower(v["method"]), string.lower(method))
        if idx then
            -- 检查URI
            ngx.log(ngx.INFO, "check uri")
            if uri == v["uri"] then
                -- 检查mark
                ngx.log(ngx.INFO, string.format("check mark: %s", v["type"]))
                local ret, mark = pcall(mark_funcions[v["type"]])
                if not ret then
                    ngx.log(ngx.ERR, string.format("pcall: %s", mark))
                    mark = nil
                end
                ngx.log(ngx.INFO, string.format("[%s behaviour] action:%s, uri:%s, method:%s, mark:%s", meta._NAME, v["action"], uri, method, v["mark"]))
                if not mark or mark == "" or type(mark) ~= "string" then
                    idx = false
                else
                    idx,_ = ngx.re.find(v["mark"], mark)
                end
                if idx then
                    ngx.log(ngx.NOTICE, string.format("[%s judge] action:%s, uri:%s, method:%s, mark:%s", meta._NAME, v["action"], uri, method, v["mark"]))
                    if v["action"] == constants.ACTION.reject then
                        ngx.say(v["response"])
                        ngx.exit(ngx.HTTP_OK)
                    elseif v["action"] == constants.ACTION.defer then
                        ngx.sleep(0.1)
                    else
                       ngx.log(ngx.ERR, string.format("illegal action:", v["action"]))
                    end
                end
            end
        end
    end    
end

ngx.exit(ngx.OK)
