
local ngx = require "ngx"
local meta = require "meta"
local cjson = require "cjson.safe"
local utils = require "utils"
local policy = require "policy"
local constants = require "constants"

policy.try_reload_policy()

local mark_funcions = policy.get_shared_mark_functions()

local uri = ngx.var.uri
local method = ngx.req.get_method()
local timestamp = ngx.now()
local idx

local sorted_role_types = policy.get_sorted_role_types()

-- origins
for _,role_type in pairs(sorted_role_types) do
    local ret, mark = pcall(mark_funcions[role_type.name])
    if not ret then
        ngx.log(ngx.ERR, string.format("pcall: %s", mark))
        mark = nil
    end

    if role_type.enable == 0 then
        mark = nil
        ngx.log(ngx.INFO, string.format("%s is disable", role_type.name))
    end

    local role = mark and role_type.hash and role_type.hash[mark]
    if role then
        -- 检查规则有效期
        ngx.log(ngx.INFO, "check expired")
        if role.expired > timestamp then
            -- 检查请求方法
            ngx.log(ngx.INFO, "check method")
            idx,_ = ngx.re.find(string.lower(role.method), string.lower(method))
            if idx then
                -- 检查URI
                ngx.log(ngx.INFO, "check uri")
                if uri == role.uri then
                    -- 检查mark
                    ngx.log(ngx.INFO, string.format("check mark: %s", role.type))
                    ngx.log(ngx.INFO, string.format("[%s behaviour]action:%s, uri:%s, method:%s, mark:%s", meta._NAME, role.action, uri, method, role.mark))
                    if  mark == "" or type(mark) ~= "string" then
                        idx = false
                    else
                        idx,_ = ngx.re.find(role.mark, mark)
                    end
                    if idx then
                        ngx.log(ngx.NOTICE, string.format("[%s judge]action:%s, uri:%s, method:%s, mark:%s", meta._NAME, role.action, uri, method, role.mark))
                        if role["action"] == constants.ACTION.reject then
                            ngx.say(role["response"])
                            ngx.exit(ngx.HTTP_OK)
                        elseif role["action"] == constants.ACTION.defer then
                            ngx.sleep(role["duration"]/1000)
                        else
                            ngx.log(ngx.ERR, string.format("illegal action:", role["action"]))
                        end
                    end
                end
            end
        end    
    end
end

ngx.exit(ngx.OK)
