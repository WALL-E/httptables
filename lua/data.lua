
local _M = {}

local tables = {
    {
        ["name"] = "origin",
        ["priority"] = 3,
        ["lamda"] = nil,
        ["enable"] = true
    },

    {
        ["name"] = "device",
        ["priority"] = 2,
        ["lamda"] = nil,
        ["enable"] = true
    },

    {
        ["name"] = "user",
        ["priority"] = 1,
        ["lamda"] = nil,
        ["enable"] = true
    },
}

local roles = {
    {
        ["type"] = "origin",
        ["mark"] = "127.0.0.1",
        ["uri"] = "/test/origin",
        ["method"] = "get,post",
        ["ttl"] = 360000,
        ["createtime"] = 1470304637,
        ["judge"] = "reject",
        ["response"] = '{"status":4001, "message":"illegal origin"}',
    },

    {
        ["type"] = "device",
        ["mark"] = "device_1",
        ["uri"] = "/test/device",
        ["method"] = "post",
        ["ttl"] = 360000,
        ["createtime"] = 1470304637,
        ["judge"] = "reject",
        ["response"] = '{"status":4003, "message":"illegal device"}',
    },

    {
        ["type"] = "user",
        ["mark"] = "user_1",
        ["uri"] = "/test/user",
        ["method"] = "get",
        ["ttl"] = 360000,
        ["createtime"] = 1470304637,
        ["judge"] = "reject",
        ["response"] = '{"status":4002, "message":"illegal user"}',
    },


}



_M.tables = tables
_M.roles = roles

return _M
