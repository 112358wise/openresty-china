return {

	whitelist = {
		"^/index$",
		"^/ask$",
		"^/share$",
		"^/category/[0-9]+$",
		"^/topics/all$",
		"^/topic/[0-9]+/view$",
		"^/topic/[0-9]+/query$",

		"^/comments/all$",

		"^/user/[0-9a-zA-Z-_]+/index$",
		"^/user/[0-9a-zA-z-_]+/topics$",
		"^/user/[0-9a-zA-z-_]+/collects$",
		"^/user/[0-9a-zA-z-_]+/comments$",
		"^/user/[0-9a-zA-z-_]+/follows$",
		"^/user/[0-9a-zA-z-_]+/fans$",
		"^/user/[0-9a-zA-z-_]+/hot_topics$",
		"^/user/[0-9a-zA-z-_]+/like_topics$",
		
		"^/about$",
		"^/auth/login$", -- login page
		"^/auth/sign_up$", -- sign up page
		"^/error/$" -- error page
	},

	pwd_secret = "salt_secret_for_password", -- not used for now

	mysql = {
		timeout = 5000,
		connect_config = {
			host = "127.0.0.1",
	        port = 3306,
	        database = "blog",
	        user = "root",
	        password = "",
	        max_packet_size = 1024 * 1024
		},

		pool_config = {
			max_idle_timeout = 20000, -- 20s
        	pool_size = 50
		}
	},

	page_config = {
		index_topic_page_size = 10
	}

}