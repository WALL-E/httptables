
local _M = {}

local httptables = {
    ["origin"] = {
        ["priority"] = 1,
        ["lamda"] = nil,
        ["enable"] = true
    },

    ["device"] = {
        ["priority"] = 2,
        ["lamda"] = nil,
        ["enable"] = true
    },

    ["user"] = {
        ["priority"] = 3,
        ["lamda"] = nil,
        ["enable"] = true
    }
}

local origins = {
    {
        ["origin"] = "1.1.1.1,2.2.2.2",
        ["uri"] = "a/b/c/d",
        ["method"] = "get,post",
        ["ttl"] = "get,post",
        ["createtime"] = 1470282769,
        ["judge"] = "reject",
        ["reaponse"] = '{"status:400, "message":"illegal device"}',
    },
}

local users = {
    {
        ["deviceid"] = "100",
        ["uri"] = "a/b/c/d",
        ["method"] = "get,post",
        ["ttl"] = "get,post",
        ["createtime"] = 1470282769,
        ["judge"] = "reject",
        ["reaponse"] = '{"status:400, "message":"illegal device"}',
    },
}

local devices = {
    {
        ["deviceid"] = "100",
        ["uri"] = "a/b/c/d",
        ["method"] = "get,post",
        ["ttl"] = "get,post",
        ["createtime"] = 1470282769,
        ["judge"] = "reject",
        ["reaponse"] = '{"status:400, "message":"illegal device"}',
    },
}



_M.httptables = httptables
_M.origins = origins
_M.users = users
_M.devices = devices

return _M
