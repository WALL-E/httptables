
local meta = require "meta"

_G._HTTPTABLES = {
  _NAME = meta._NAME,
  _VERSION = meta._VERSION
}

local ngx = require "ngx"

local cjson = require "cjson.safe"
cjson.encode_sparse_array(true)


ngx.header["Access-Control-Allow-Origin"] = "*"
if ngx.req.get_method() == "OPTIONS" then
    ngx.header["Access-Control-Allow-Methods"] = "GET,HEAD,PUT,PATCH,POST,DELETE"
    ngx.header["Access-Control-Allow-Headers"] = "Content-Type"
    ngx.exit(204)
end

ngx.say("Restful admin apis")
