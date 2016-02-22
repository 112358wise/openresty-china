# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.15)
# Database: blog
# Generation Time: 2016-02-22 16:36:01 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;

INSERT INTO `category` (`id`, `name`, `create_time`)
VALUES
	(1,'分享','2016-02-17 16:22:04'),
	(2,'问答','2016-02-17 16:22:04');

/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table collect
# ------------------------------------------------------------

DROP TABLE IF EXISTS `collect`;

CREATE TABLE `collect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `topic_id` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_topic` (`user_id`,`topic_id`),
  KEY `index_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;

INSERT INTO `collect` (`id`, `user_id`, `topic_id`, `create_time`)
VALUES
	(35,7,32,'2016-02-23 00:02:05'),
	(36,6,37,'2016-02-23 00:18:33'),
	(37,2,38,'2016-02-23 00:23:18');

/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` varchar(3000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `index_topic_id` (`topic_id`),
  KEY `index_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;

INSERT INTO `comment` (`id`, `topic_id`, `user_id`, `create_time`, `content`)
VALUES
	(65,25,2,'2016-02-23 00:13:08',':smile: :smile:'),
	(66,33,2,'2016-02-23 00:13:27','入门必读，:smile:');

/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table follow
# ------------------------------------------------------------

DROP TABLE IF EXISTS `follow`;

CREATE TABLE `follow` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_relation` (`from_id`,`to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;

INSERT INTO `follow` (`id`, `from_id`, `to_id`, `create_time`)
VALUES
	(1,1,2,'2016-02-17 16:08:30'),
	(3,3,2,'2016-02-17 16:53:18'),
	(4,4,2,'2016-02-17 23:08:42'),
	(5,5,2,'2016-02-17 23:09:07'),
	(79,2,3,'2016-02-21 01:44:53');

/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table like
# ------------------------------------------------------------

DROP TABLE IF EXISTS `like`;

CREATE TABLE `like` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `topic_id` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_topic` (`user_id`,`topic_id`),
  KEY `index_user_id` (`user_id`),
  KEY `index_topic_id` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `like` WRITE;
/*!40000 ALTER TABLE `like` DISABLE KEYS */;

INSERT INTO `like` (`id`, `user_id`, `topic_id`, `create_time`)
VALUES
	(34,7,32,'2016-02-23 00:02:04'),
	(35,6,37,'2016-02-23 00:18:31'),
	(36,2,38,'2016-02-23 00:23:12');

/*!40000 ALTER TABLE `like` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table notification
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '1已读，0未读',
  `from_id` int(11) NOT NULL DEFAULT '0' COMMENT '来自用户的id',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型：',
  `content` varchar(2000) NOT NULL COMMENT '内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table topic
# ------------------------------------------------------------

DROP TABLE IF EXISTS `topic`;

CREATE TABLE `topic` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` varchar(5000) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '创建者用户名',
  `like_num` int(11) NOT NULL DEFAULT '0' COMMENT '赞个数',
  `collect_num` int(11) NOT NULL DEFAULT '0' COMMENT '收藏数',
  `reply_num` int(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `follow` int(11) NOT NULL DEFAULT '0' COMMENT '关注数',
  `view_num` int(11) NOT NULL DEFAULT '0' COMMENT '阅读数',
  `last_reply_id` int(11) NOT NULL DEFAULT '0' COMMENT '最后回复者id',
  `last_reply_name` varchar(255) NOT NULL DEFAULT '' COMMENT '最后回复者用户名',
  `last_reply_time` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属类',
  `is_good` int(11) NOT NULL DEFAULT '0' COMMENT '1精华帖，0普通帖',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;

INSERT INTO `topic` (`id`, `title`, `content`, `user_id`, `create_time`, `update_time`, `user_name`, `like_num`, `collect_num`, `reply_num`, `follow`, `view_num`, `last_reply_id`, `last_reply_name`, `last_reply_time`, `category_id`, `is_good`)
VALUES
	(31,'Hello World! Hello OpenResty China!','Hello World! Hello OpenResty China!',1,'2016-02-21 20:27:00','2016-02-23 00:28:28','sumory',0,0,0,0,1,0,'','2000-01-01 00:00:00',1,0),
	(32,'Lor Framework','\nA fast and minimalist web framework based on [OpenResty](http://openresty.org).\n\n[![https://travis-ci.org/sumory/lor.svg?branch=master](https://travis-ci.org/sumory/lor.svg?branch=master)](https://travis-ci.org/sumory/lor) [![Issue Stats](http://issuestats.com/github/sumory/lor/badge/pr)](http://issuestats.com/github/sumory/lor) [![Issue Stats](http://issuestats.com/github/sumory/lor/badge/issue)](http://issuestats.com/github/sumory/lor)\n\n\n\n```lua\nlocal lor = require(\"lor.index\")\nlocal app = lor()\n\napp:get(\"/\", function(req, res, next)\n    res:send(\"hello world!\")\nend)\n\napp:run()\n```\n\n\n\n## Installation\n\n\n```\ngit clone https://github.com/sumory/lor\ncd lor\nsh install.sh /path/to/your/lor \n```\n\n\n\n## Features\n\n- Routing like [Sinatra](http://www.sinatrarb.com/) which is a famous Ruby framework\n- Similar API with [Express](http://expressjs.com), good experience for Node.js or Javascript developers\n- Middleware support\n- Group router support\n- Session/Cookie/Views supported and could be redefined with `Middleware`\n- Easy to build HTTP APIs, web site, or single page applications\n\n\n\n## Docs & Community\n\n- [Website and Documentation](http://lor.sumory.com).\n- [Github Organization](https://github.com/lorlabs) for Official Middleware & Modules.\n\n\n\n\n## Quick Start\n\nA quick way to get started with lor is to utilize the executable cli tool `lord` to generate an scaffold application.\n\n`lord` is installed with `lor` framework. it looks like:\n\n```bash\n$ lord -h\nlor ${version}, a Lua web framework based on OpenResty.\n\nUsage: lor COMMAND [OPTIONS]\n\nCommands:\n new [name]             Create a new application\n start                  Starts the server\n stop                   Stops the server\n restart                Restart the server\n version                Show version of lor\n help                   Show help tips\n```\n\nCreate the app:\n\n```\n$ lord new lor_demo\n```\n\nStart the server:\n\n```\n$ cd lor_demo & lord start\n```\n\nVisit [http://localhost:8888](http://localhost:8888).\n\n\n\n## Tests\n\nInstall [busted](http://olivinelabs.com/busted/), then run test\n\n```\nbusted test/*.test.lua\n```\n\n\n\n## License\n\n[MIT](./LICENSE)',2,'2016-02-22 23:57:19','2016-02-23 00:02:08','admin',1,1,0,0,4,0,'','2000-01-01 00:00:00',1,0),
	(33,'OpenResty最佳实践','详见[https://moonbingbing.gitbooks.io/openresty-best-practices/content/](https://moonbingbing.gitbooks.io/openresty-best-practices/content/)',7,'2016-02-23 00:02:45','2016-02-23 00:13:27','momo',0,0,1,0,2,33,'admin','2016-02-23 00:13:27',1,0),
	(34,'Lua语言简单介绍','这一章我们简要地介绍 Lua 语言的基础知识，特别地，我们会有意将讨论放置于 OpenResty 的上下文中。同时，我们并不会回避 LuaJIT 独有的新特性；当然，在遇到这样的独有特性时，我们都会予以说明。我们会关注各个语言结构和标准库函数对性能的潜在影响。在讨论性能相关的问题时，我们只会关心 LuaJIT 实现。\n\n\n## Lua 是什么?\n\n1993 年在巴西里约热内卢天主教大学(Pontifical Catholic University of Rio de Janeiro in Brazil)诞生了一门编程语言，发明者是该校的三位研究人员，他们给这门语言取了个浪漫的名字——Lua，在葡萄牙语里代表美丽的月亮。\n\n事实证明她没有糟蹋这个优美的单词，Lua 语言正如它名字所预示的那样成长为一门简洁、优雅且富有乐趣的语言。\n\nLua 从一开始就是作为一门方便嵌入(其它应用程序)并可扩展的轻量级脚本语言来设计的，因此她一直遵从着简单、小巧、可移植、快速的原则，官方实现完全采用 ANSI C 编写，能以 C 程序库的形式嵌入到宿主程序中。LuaJIT 2 和标准 Lua 5.1 解释器采用的是著名的 MIT 许可协议。正由于上述特点，所以 Lua 在游戏开发、机器人控制、分布式应用、图像处理、生物信息学等各种各样的领域中得到了越来越广泛的应用。其中尤以游戏开发为最，许多著名的游戏，比如 Escape from Monkey Island、World of Warcraft、大话西游，都采用了 Lua 来配合引擎完成数据描述、配置管理和逻辑控制等任务。即使像 Redis 这样中性的内存键值数据库也提供了内嵌用户 Lua 脚本的官方支持。\n\n## 特性\n\n变量名没有类型，值才有类型，变量名在运行时可与任何类型的值绑定;\n语言只提供唯一一种数据结构，称为表(table)，它混合了数组、哈希，可以用任何类型的值作为 key 和 value。提供了一致且富有表达力的表构造语法，使得 Lua 很适合描述复杂的数据;\n函数是一等类型，支持匿名函数和正则尾递归(proper tail recursion);\n支持词法定界(lexical scoping)和闭包(closure);\n提供 thread 类型和结构化的协程(coroutine)机制，在此基础上可方便实现协作式多任务;\n运行期能编译字符串形式的程序文本并载入虚拟机执行;\n通过元表(metatable)和元方法(metamethod)提供动态元机制(dynamic meta-mechanism)，从而允许程序运行时根据需要改变或扩充语法设施的内定语义;\n能方便地利用表和动态元机制实现基于原型(prototype-based)的面向对象模型;\n从 5.1 版开始提供了完善的模块机制，从而更好地支持开发大型的应用程序;\n\n## Lua 和 LuaJIT 的区别\n\nLua 非常高效，它运行得比许多其它脚本(如Perl、Python、Ruby)都快，这点在第三方的独立测评中得到了证实。尽管如此，仍然会有人不满足，他们总觉得“嗯，还不够快!”。LuaJIT 就是一个为了再榨出一些速度的尝试，它利用即时编译（Just-in Time）技术把 Lua 代码编译成本地机器码后交由 CPU 直接执行。LuaJIT 2 的测评报告表明，在数值运算、循环与函数调用、协程切换、字符串操作等许多方面它的加速效果都很显著。',1,'2016-02-23 00:04:05','2016-02-23 00:29:14','sumory',0,0,0,0,3,0,'','2000-01-01 00:00:00',1,0),
	(35,'关于OpenResty China','这里是 OpenResty 中文社区\n\n - 分享OpenResty相关技术\n - 欢迎原创文章，也欢迎各种技术交流\n - 本站基于Lor Framework构建，Lor是一个基于OpenResty的开发框架\n\nOpenResty相对于其它语言或是平台来说，它的社区规模还较小，不过已在高速发展中。本社区致力于推广和普及OpenResty相关技术，并提供给开发者一个好用的技术交流平台。',2,'2016-02-23 00:12:30','2016-02-23 00:12:30','admin',0,0,0,0,1,0,'','2000-01-01 00:00:00',2,0),
	(36,'如何基于OpenResty构建一个Blog应用','请参考本站代码：\n\n[OpenResty China](https://github.com/sumory/openresty-china)',6,'2016-02-23 00:16:29','2016-02-23 00:16:41','jerry',0,0,0,0,2,0,'','2000-01-01 00:00:00',1,0),
	(37,'Lor的中文介绍','**Lor**是一个运行在[OpenResty](http://openresty.org)上的基于Lua编写的Web框架. \n\n- 路由采用[Sinatra](http://www.sinatrarb.com/)风格，Sinatra是Ruby小而精的web框架.\n- API基本采用了[Express](http://expressjs.com)的思路和设计，Node.js跨界开发者可以很快上手.\n- 支持插件(middleware)，路由可分组，路由匹配支持string/正则模式.\n- lor以后会保持核心足够精简，扩展功能依赖`middleware`来实现. `lor`本身也是基于`middleware`构建的.\n- 推荐使用lor作为HTTP API Server，lor也已支持session/cookie/html template等功能.\n- 框架文档在[这里](http://lor.sumory.com)，正在逐步完善.\n- 框架示例项目[lor-example](https://github.com/lorlabs/lor-example)\n\n当前版本：v0.0.8\n\n\n### 快速开始\n\n在使用lor之前请首先确保OpenResty和luajit已安装.\n\n一个简单示例，更复杂的示例或项目模板请使用`lord`命令生成：\n\n```lua\nlocal lor = require(\"lor.index\")\nlocal app = lor()\n\napp:get(\"/\", function(req, res, next)\n    res:send(\"hello world!\")\nend)\n\n-- 路由示例: 匹配/query/123?foo=bar\napp:get(\"/query/:id\", function(req, res, next)\n    local foo = req.query.foo -- 从url queryString取值：\"bar\"\n    local path_id = req.params.id -- 从path取值：\"123\"\n    res:json({\n        foo = foo,\n        id = path_id\n    })\nend)\n\n-- 404 error\napp:use(function(req, res, next)\n    if req:is_found() ~= true then\n        res:status(404):send(\"sorry, not found.\")\n    end\nend)\n\n-- 错误处理插件，可根据需要定义多个\napp:erroruse(function(err, req, res, next)\n    -- err是错误对象\n    res:status(500):send(\"服务器内发生未知错误\")\nend)\n```\n\n### 安装\n\n\n使用install.sh安装lor框架\n\n```\n#如把lor安装到/opt/lua/lor目录下\nsh install.sh /opt/lua/lor  #不加路径参数则默认安装到/usr/local/lor\n```\n\n执行以上命令后lor的命令行工具`lord`就被安装在了`/usr/local/bin`下, 通过`which lord`查看:\n\n```\n$ which lord\n/usr/local/bin/lord\n```\n\n`lor`的运行时包安装在了`/opt/lua/lor`下, 通过`ll /opt/lua/lor`查看:\n\n```\n$ ll /opt/lua/lor\ntotal 56\ndrwxr-xr-x  14 root  wheel   476B  1 22 01:18 .\ndrwxrwxrwt  14 root  wheel   476B  1 22 01:18 ..\n-rw-r--r--   1 root  wheel     0B  1 19 23:48 CHANGELOG.md\n-rw-r--r--   1 root  wheel   1.0K  1 19 23:48 LICENSE\n-rw-r--r--   1 root  wheel     0B  1 19 23:48 Makefile\n-rw-r--r--   1 root  wheel   1.9K  1 21 20:59 README-zh.md\n-rw-r--r--   1 root  wheel   870B  1 21 20:59 README.md\ndrwxr-xr-x   4 root  wheel   136B  1 22 00:06 bin\n-rw-r--r--   1 root  wheel   1.6K  1 19 23:48 install.md\n-rw-r--r--   1 root  wheel   1.0K  1 21 22:37 install.sh\ndrwxr-xr-x   4 root  wheel   136B  1 21 22:40 lor\ndrwxr-xr-x  13 root  wheel   442B  1 22 01:17 test\n```\n\n至此， `lor`框架已经安装完毕，接下来使用`lord`命令行工具快速开始一个项目.\n\n\n\n\n### 使用\n\n```\n$ lord -h\nlor v0.0.6, a Lua web framework based on OpenResty.\n\nUsage: lor COMMAND [OPTIONS]\n\nCommands:\n new [name]             Create a new application\n start                  Starts the server\n stop                   Stops the server\n restart                Restart the server\n version                Show version of lor\n help                   Show help tips\n```\n\n执行`lord new lor_demo`，则会生成一个名为lor_demo的示例项目，然后执行：\n\n```shell\ncd lor_demo\nlord start\n```\n\n之后访问http://localhost:8888/, 即可。\n\n更多使用方法，请参考[test](./test)测试用例。\n\n\n### 讨论交流\n\n目前有一个QQ群用于在线讨论：[![QQ群522410959](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=b930a7ba4ac2ecac927cb51101ff26de1170c0d0a31c554b5383e9e8de004834) 522410959\n\n\n### License\n\nMIT',6,'2016-02-23 00:17:35','2016-02-23 00:18:33','jerry',1,1,0,0,2,0,'','2000-01-01 00:00:00',1,0),
	(38,'如何实现一个Upload中间件','OpenResty上传文件可以使用官方提供的lua-resty-upload，[lor](https://github.com/sumory/lor)提供了灵活的中间件机制，在lor上实现上传的中间件实现如下：\n\n```lua\nlocal upload = require(\"resty.upload\")\nlocal uuid = require(\"app.libs.uuid.uuid\")\n\nlocal sfind = string.find\nlocal match = string.match\nlocal ngx_var = ngx.var\nlocal get_headers = ngx.req.get_headers()\n\n\nlocal function getextension(filename)\n	return filename:match(\".+%.(%w+)$\")\nend\n\n\nlocal function _multipart_formdata(config)\n	local form, err = upload:new(config.chunk_size)\n	if not form then\n		ngx.log(ngx.ERR, \"failed to new upload: \", err)\n		ngx.exit(500)\n	end\n	form:set_timeout(config.recieve_timeout)\n\n	local unique_name = uuid()\n	local file, origin_filename, filename, path, extname\n	while true do\n		local typ, res, err = form:read()\n\n		if not typ then\n			ngx.log(ngx.ERR, \"failed to read: \", err)\n			ngx.exit(500)\n		end\n\n		if typ == \"header\" then\n			if res[1] == \"Content-Disposition\" then\n				key = match(res[2], \"name=\\\"(.-)\\\"\")\n				origin_filename = match(res[2], \"filename=\\\"(.-)\\\"\")\n			elseif res[1] == \"Content-Type\" then\n				filetype = res[2]\n			end\n\n			if origin_filename and filetype then\n				if not extname then\n					extname = getextension(origin_filename)\n				end\n\n				filename = unique_name .. \".\" .. extname\n				path = config.dir.. \"/\" .. filename\n				\n				file = io.open(path, \"w+\")\n			end\n	\n		elseif typ == \"body\" then\n			if file then\n				file:write(res)\n			else\n				ngx.log(ngxERR, path, \" not exist\")\n			end\n		elseif typ == \"part_end\" then\n            file:close()\n            file = nil\n		elseif typ == \"eof\" then\n			break\n		else\n			-- do nothing\n		end\n	end\n\n	return filename, extname, path, unique_name .. \".\" .. extname\nend\n\nlocal function _check_post(config)\n	local filename = nil\n	local extname = nil\n	local path = nil\n\n\n	if ngx_var.request_method == \"POST\" then\n		local header = get_headers[\'Content-Type\']\n		local is_multipart = sfind(header, \"multipart\")\n		if is_multipart and is_multipart>0 then\n			origin_filename, extname, path, filename= _multipart_formdata(config)\n		end\n	end\n\n\n	return origin_filename, extname, path, filename\nend\n\nlocal function uploader(config)\n	config = config or {}\n	config.dir = config.dir or \"/tmp\"\n	config.chunk_size = config.chunk_size or 4096\n	config.recieve_timeout = config.recieve_timeout or 20000 -- 20s\n\n	return function(req, res, next)\n		local origin_filename, extname, path, filename = _check_post(config)\n		req.file = req.file or {}\n		req.file.origin_filename = origin_filename\n		req.file.extname = extname\n		req.file.path = path\n		req.file.filename = filename\n		next()\n	end\nend\n\nreturn uploader\n```\n\n使用该中间件的方式也非常简单：\n\n```lua\napp:use(uploader_middleware({\n	dir = \"app/static/avatar\"\n}))\n```\n\n然后在后续的处理路由中，即可通过req.file对象来获取已经上传的文件信息。\n',2,'2016-02-23 00:22:45','2016-02-23 00:23:18','admin',1,1,0,0,1,0,'','2000-01-01 00:00:00',2,0),
	(39,'markdown语法说明','# Guide\n\n这是一篇讲解如何正确使用 Ruby China 的 **Markdown** 的排版示例，学会这个很有必要，能让你的文章有更佳清晰的排版。\n\n> 引用文本：Markdown is a text formatting syntax inspired\n\n## 语法指导\n\n### 普通内容\n\n这段内容展示了在内容里面一些小的格式，比如：\n\n- **加粗** - `**加粗**`\n- *倾斜* - `*倾斜*`\n- ~~删除线~~ - `~~删除线~~`\n- `Code 标记` - ``Code 标记``\n- [超级链接](http://github.com) - `[超级链接](http://github.com)`\n- [huacnlee@gmail.com](mailto:huacnlee@gmail.com) - `[huacnlee@gmail.com](mailto:huacnlee@gmail.com)`\n\n### 提及用户\n\n@huacnlee @rei @lgn21st ... 通过 @ 可以在发帖和回帖里面提及用户，信息提交以后，被提及的用户将会收到系统通知。以便让他来关注这个帖子或回帖。\n\n### 表情符号 Emoji\n\nRuby China 支持表情符号，你可以用系统默认的 Emoji 符号（无法支持 Chrome 以及 Windows 用户）。\n也可以用图片的表情，输入 `:` 将会出现智能提示。\n\n#### 一些表情例子\n\n:smile: :laughing: :dizzy_face: :sob: :cold_sweat: :sweat_smile:  :cry: :triumph: :heart_eyes:  :satisfied: :relaxed: :sunglasses: :weary:\n\n:+1: :-1: :100: :clap: :bell: :gift: :question: :bomb: :heart: :coffee: :cyclone: :bow: :kiss: :pray: :shit: :sweat_drops: :exclamation: :anger:\n\n更多表情请访问：[http://www.emoji-cheat-sheet.com](http://www.emoji-cheat-sheet.com)\n\n### 大标题 - Heading 3\n\n你可以选择使用 H2 至 H6，使用 ##(N) 打头，H1 不能使用，会自动转换成 H2。\n\n> NOTE: 别忘了 # 后面需要有空格！\n\n#### Heading 4\n\n##### Heading 5\n\n###### Heading 6\n\n### 代码块\n\n#### 普通\n\n```\n*emphasize*    **strong**\n_emphasize_    __strong__\n@a = 1\n```\n\n#### 语法高亮支持\n\n如果在 ``` 后面更随语言名称，可以有语法高亮的效果哦，比如:\n\n##### 演示 Ruby 代码高亮\n\n```ruby\nclass PostController < ApplicationController\n  def index\n    @posts = Post.desc(\"id).limit(10)\n  end\nend\n```\n\n##### 演示 Rails View 高亮\n\n```erb\n<= @posts.each do |post| >\n<div class=\"post\"></div>\n< end >\n```\n\n##### 演示 YAML 文件\n\n```yml\nzh-CN:\n  name: 姓名\n  age: 年龄\n```\n\n> Tip: 语言名称支持下面这些: `ruby`, `python`, `js`, `html`, `erb`, `css`, `coffee`, `bash`, `json`, `yml`, `xml` ...\n\n### 有序、无序列表\n\n#### 无序列表\n\n- Ruby\n  - Rails\n    - ActiveRecord\n- Go\n  - Gofmt\n  - Revel\n- Node.js\n  - Koa\n  - Express\n\n#### 有序列表\n\n1. Node.js\n  1. Express\n  2. Koa\n  3. Sails\n2. Ruby\n  1. Rails\n  2. Sinatra\n3. Go\n\n### 表格\n\n如果需要展示数据什么的，可以选择使用表格哦\n\n| header 1 | header 3 |\n| -------- | -------- |\n| cell 1   | cell 2   |\n| cell 3   | cell 4   |\n| cell 5   | cell 6   |\n\n### 段落\n\n留空白的换行，将会被自动转换成一个段落，会有一定的段落间距，便于阅读。\n\n请注意后面 Markdown 源代码的换行留空情况。',7,'2016-02-21 22:03:42','2016-02-23 00:29:16','momo',0,0,1,0,69,25,'admin','2016-02-23 00:13:08',1,1);

/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `avatar` varchar(500) NOT NULL DEFAULT '' COMMENT '头像',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `city` varchar(11) NOT NULL DEFAULT '',
  `website` varchar(255) NOT NULL DEFAULT '',
  `company` varchar(100) NOT NULL DEFAULT '',
  `sign` varchar(255) NOT NULL DEFAULT '',
  `github` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(200) NOT NULL DEFAULT '',
  `email_public` int(11) NOT NULL DEFAULT '0' COMMENT '1公开，0私密',
  `is_admin` int(11) DEFAULT '0' COMMENT '1管理员，0普通用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `username`, `password`, `avatar`, `create_time`, `city`, `website`, `company`, `sign`, `github`, `email`, `email_public`, `is_admin`)
VALUES
	(1,'sumory','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','1.png','2016-01-01 00:08:00','北京','http://sumory.com','here.cn','这就是一条签名','sumory','sumory.wu@gmail.com',0,1),
	(2,'admin','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','2.png','2016-02-19 19:08:00','北京','http://sumory.com','sumory.com','nothing at all.','sumory','sumory.wu@gmail.com',1,1),
	(3,'adver','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','3.png','2016-02-17 16:54:03','','','','','','',0,0),
	(4,'sunny','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','4.png','2016-02-17 23:08:30','','','','','','',0,0),
	(5,'tom','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','5.png','2016-02-17 23:08:59','','','','','','',0,0),
	(6,'jerry','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','6.png','2016-01-23 00:01:19','','','','','','',0,0),
	(7,'momo','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','7.png','2016-02-23 00:01:40','','','','','','',0,0);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
