# httptables
httptables是一个基于OpenResty的软防火墙，可以配合风控系统针对HTTP请求做不同的处理，目前计划支持两种响应方式，一种是reject，一种是delay。
设计细节请查看OUTLINE.md。

## 依赖环境
目前仅对Centos做安装说明

```
sh depends.sh
```

## 安装openresty
源码包编译安装

```
wget https://openresty.org/download/openresty-1.9.15.1.tar.gz
tar zxvf openresty-1.9.15.1.tar.gz
cd openresty-1.9.15.1/
./configure --prefix=/apps/httptables && gmake && gmake install
```


## 安装httptables
下载后，直接运行startup.sh即可
