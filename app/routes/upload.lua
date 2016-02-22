local pairs = pairs
local ipairs = ipairs
local utils = require("app.libs.utils")
local lor = require("lor.index")
local user_model = require("app.model.user")
local topic_model = require("app.model.topic")
local upload_router = lor:Router()


upload_router:post("/avatar", function(req, res, next)
    local file = req.file or {}
    if file.filename then 
        local userid = req.session.get("user").userid;
        user_model:update_avatar(userid, file.filename)
    end

    res:json({
        originFilename = file.origin_filename,
        filename = file.filename
    })
end)


return upload_router
