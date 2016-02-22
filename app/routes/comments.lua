local pairs = pairs
local ipairs = ipairs
local utils = require("app.libs.utils")
local lor = require("lor.index")
local comment_model = require("app.model.comment")
local comments_router = lor:Router()


comments_router:get("/all", function(req, res, next)
    local page_no = req.query.page_no
    local topic_id = req.query.topic_id
    local page_size = 3

    local total_count = comment_model:get_total_count_of_topic(topic_id)
    local total_page = utils.total_page(total_count, page_size)
    local comments = comment_model:get_all_of_topic(topic_id, page_no, page_size)

  
    res:json({
        success = true,
        data = {
            totalCount = total_count,
            totalPage = total_page,
            currentPage = page_no,
            comments = comments,
            base = (page_no - 1) * page_size,
            current_user_id = tonumber(req.session.get("user").userid) or 0
        }
    })
end)


return comments_router
