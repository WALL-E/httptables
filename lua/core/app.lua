
local ngx = require "ngx"


local method = ngx.req.get_method()

if method == "POST" then
    ngx.say("POST: Not allow")
    ngx.exit(ngx.HTTP_OK)
end
