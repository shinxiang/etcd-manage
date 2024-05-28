# Etcd manage

Fork From： [https://github.com/etcd-manage](https://github.com/etcd-manage)


## 功能介绍

etcd-manage 是一个用go编写的etcd管理工具，具有友好的界面(类似阿里云后台)，管理key就像管理本地文件一样方便。支持简单权限管理区分只读和读写权限。


## 使用
```
# 1. /data/sql数据导入到mysql数据库

# 2. 设置代理
go env -w GO111MODULE=on
go env GOPROXY=https://goproxy.cn,direct

# 3. 打包、运行
go mod tidy
go mod download
go build .

./etcd-manage
```

运行后看到输出：

```shell

Start HTTP the service: 0.0.0.0:10280

```

执行完 NOTES 中提示命令的命令即可在浏览器中访问 `http://127.0.0.1:10280/ui` 查看。注意url端口后边路径为/ui

默认用户名密码 admin/123456


**参数介绍**

| 参数名 | 简述 | 示例 |
| ----- | ----- | ---|
|  database.address | mysql数据库地址 | 192.168.1.88 |
|  database.port | mysql数据库端口 | 3306 |
|  database.user | mysql用户名 | root |
|  database.passwd | mysql用户密码 | 123456 |
|  database.db_name | 导入etcd-manage.sql的数据库 | etcd-manage |


## 效果演示

etcd服务列表管理

![](https://raw.githubusercontent.com/cloudnativeapp/charts/master/submitted/etcd-manage/imgs/etcd-server.png)

key 管理

![](https://raw.githubusercontent.com/cloudnativeapp/charts/master/submitted/etcd-manage/imgs/keys.png)

key 编辑

![](https://raw.githubusercontent.com/cloudnativeapp/charts/master/submitted/etcd-manage/imgs/key-edit.png)

key 查看

![](https://raw.githubusercontent.com/cloudnativeapp/charts/master/submitted/etcd-manage/imgs/key-show.png)

用户管理

![](https://raw.githubusercontent.com/cloudnativeapp/charts/master/submitted/etcd-manage/imgs/user.png)
