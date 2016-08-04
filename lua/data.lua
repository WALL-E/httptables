
local _M = {}

local tables = {
    {
        ["name"] = "origin",
        ["priority"] = 5,
        ["lamda"] = nil,
        ["enable"] = true
    },

    {
        ["name"] = "device",
        ["priority"] = 1,
        ["lamda"] = nil,
        ["enable"] = true
    },

    {
        ["name"] = "user",
        ["priority"] = 5,
        ["lamda"] = nil,
        ["enable"] = true
    },
}

local roles = {
    {
        ["type"] = "origin",
        ["mark"] = "127.0.0.1",
        ["uri"] = "/test",
        ["method"] = "get,post",
        ["ttl"] = 3600,
        ["createtime"] = 1470304637,
        ["judge"] = "reject",
        ["reaponse"] = '{"status:400, "message":"illegal origin"}',
    },

    {
        ["type"] = "user",
        ["mark"] = "abcd",
        ["uri"] = "/test",
        ["method"] = "get",
        ["ttl"] = 3600,
        ["createtime"] = 1470304637,
        ["judge"] = "reject",
        ["reaponse"] = '{"status:400, "message":"illegal user"}',
    },

    {
        ["type"] = "device",
        ["mark"] = "100",
        ["uri"] = "/test",
        ["method"] = "post",
        ["ttl"] = 3600,
        ["createtime"] = 1470304637,
        ["judge"] = "reject",
        ["reaponse"] = '{"status:400, "message":"illegal device"}',
    },
}



_M.tables = tables
_M.roles = roles

return _M
