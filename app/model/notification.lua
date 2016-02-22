local DB = require("app.libs.db")
local db = DB:new()

local notification_model = {}


function notification_model:get_all(user_id, page_no, page_size)
	user_id = tonumber(user_id)
	page_no = tonumber(page_no)
	page_size = tonumber(page_size)
	if page_no < 1 then 
		page_no = 1
	end

	return db:query("select n.*, u.username as from_username, u.avatar as avatar from notification n " .. 
		" left join user u on n.from_id=u.id " ..
		" where n.user_id = ?" .. 
		" limit ?,?", {user_id, (page_no - 1) * page_size, page_size})
end

function notification_model:get_total_count(user_id)
	return db:query("select count(id) as count from notification where user_id =?", {tonumber(user_id)})
end


return notification_model