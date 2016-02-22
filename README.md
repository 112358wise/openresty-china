# OpenResty China 

一个运行在[OpenResty](http://openresty.org)上的基于[lor](https://github.com/sumory/lor)编写的社区软件。

- 主要页面直接采用了[ruby-china](https://github.com/ruby-china/ruby-china)的样式
- 完全基于OpenResty，是入门OpenResty Web开发的良好范例
- 基于[Lor Framework](https://github.com/sumory/lor)，轻松简单的开发Sinatra风格的web应用
- 存储采用MySQL，文件本地落地存储



### 快速开始

- 首先安装OpenResty和[lor](https://github.com/sumory/lor)框架
- 将仓库中提供的sql文件导入到MySQL
- 修改配置文件`app/config/config.lua`为本地对应配置
- 执行sh start.sh即可启动
- 访问`http://localhost:8888`
- 有几个初始账户供体验: admin/sumory/momo，密码均为test


### roadmap

目前基本功能完成度在90%左右，还有一些边边角角需要完善，目前的版本仅供体验。


### 讨论交流

目前有一个QQ群用于在线讨论：[![QQ群522410959](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=b930a7ba4ac2ecac927cb51101ff26de1170c0d0a31c554b5383e9e8de004834) 522410959


### License

[MIT](./LICENSE)