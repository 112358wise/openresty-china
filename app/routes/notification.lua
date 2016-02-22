local pairs = pairs
local ipairs = ipairs
local lor = require("lor.index")
local notification_model = require("app.model.notification")
local notification_router = lor:Router()


notification_router:get("/", function(req, res, next)
    res:render("user/notification")
end)


notification_router:get("/all", function(req, res, next)
    local page_no = req.query.page_no
    local page_size = req.query.page_size
    local user_id = req.session.get("user").userid

    if not user_id then
    	return res:json({
    		success = false,
    		msg = "not login before query."
    	})
    end

    local total_count = notification_model:get_total_count(user_id)
    if not total_count then
        total_count = 0
    end


    local result, err = notification_model:get_all(user_id, page_no, page_size)
    if not result or err or type(result) ~= "table" then
        return res:json( {
            success = false,
            msg = "error to find notifications."
        })
    else
        res:json({
            success = true,
            data = {
                total_count = tonumber(total_count[1].count),
                notifications = result
            }
        })
    end
end)


return notification_router