local pairs = pairs
local ipairs = ipairs
local lor = require("lor.index")
local topic_model = require("app.model.topic")
local comment_model = require("app.model.comment")
local comment_router = lor:Router()

comment_router:get("/:comment_id/delete", function(req, res, next)
    local comment_id = req.params.comment_id
    local userid = req.session.get("user").userid

    if not userid then
        return res:json({
            success = false,
            msg = "删除评论之前请先登录."
        })
    end

    if not comment_id then
        return res:json({
            success = false,
            msg = "参数错误."
        })
    end

    local result = comment_model:delete(userid, comment_id)

    if result then
        res:json({
            success = true,
            msg = "删除评论成功"
        })
    else
        res:json({
            success = false,
            msg = "删除评论失败"
        })
    end

end)

comment_router:post("/new", function(req, res, next)
    local topic_id = req.body.topic_id
    local content = req.body.content
    local user = req.session.get("user")
    local user_id = user.userid

    if not user_id then
        return res:json({
            success = false,
            msg = "操作之前请先登录."
        })
    end

    if not topic_id or not content or content == "" then
        res:json({
            success = false,
            msg = "参数不得为空."
        })
        return
    end

    local result, err = comment_model:new(topic_id, user_id, content)
    if not result or err then
        res:json({
            success = false,
            msg = "保存评论失败"
        })
    else
        local new_comment_id = result.insert_id
        comment_model:reset_topic_comment_num(topic_id)
        topic_model:reset_last_reply(topic_id, user_id, user.username) -- 更新最后回复人
        local new_comment =  comment_model:query(new_comment_id)
        res:json({
            success = true,
            msg = "保存评论成功",
            data = {
                c = new_comment
            }
        })
    end
end)


return comment_router
