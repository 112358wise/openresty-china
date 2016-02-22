local pairs = pairs
local ipairs = ipairs
local cjson = require("cjson")
local utils = require("app.libs.utils")
local lor = require("lor.index")
local user_model = require("app.model.user")
local auth_router = lor:Router()


auth_router:get("/login", function(req, res, next)
    res:render("login")
end)


auth_router:get("/sign_up", function(req, res, next)
    res:render("sign_up")
end)

auth_router:post("/login", function(req, res, next)
    local username = req.body.username 
    local password = req.body.password

    if not username or not password or username == "" or password == "" then
        res:render("error", {
            errMsg = "username or password should not be empty."
        })
        return
    end

    local isExist = false
    local userid = 0

    password = utils.encode(password)
    local result, err = user_model:query(username, password)

    local user = {}
    if result and not err then
        if result and #result == 1 then
            isExist = true
            user = result[1] 
            userid = user.id
        end
    else
        isExist = false
    end

    if isExist == true then
        req.session.set("user", {
            username = username,
            userid = userid,
            create_time = user.create_time or ""
        })
        res:redirect("/index")
    else
        res:redirect("/error/",{
            errMsg = "Wrong username or password! Please check."
        })
    end
end)


auth_router:get("/logout", function(req, res, next)
    res.locals.login = false
    res.locals.username = ""
    res.locals.userid = 0
    res.locals.create_time = ""
    req.session.destroy()
    res:redirect("/index")
end)


return auth_router

