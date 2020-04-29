# cluster
2019-06-26 14:09:01创建  
  
搭建集群环境脚本
文章地址：https://segmentfault.com/u/canglangshui/articles 

[更新]2020.04.11 15:09  
=======
1、更新docker_php指定版本php7.3.16，去除imagick，添加sdebug(xdebug)、swoole-tracker扩展;  
2、启动hyperf测试swoole-tracker调用：  

[更新]2020.04.02 15:43  
=======
1、更新docker_php版本php7.4.4，更新swoole、event、memcached、redis扩展;  
2、测试docker-slim缩减，无法启动；  
3、标记环境192.168.1.111参数：  

```
port       	host/phpinfo.path 					cluster
8080/8082 	host:8080/a.php 					2nginx(n1,n2)+3php(权：p1,p2,p3)
8084/8085 	host:8084/a.php | https://host:8085/a.php 		1nginx(限流：n3)+3php(权：p1,p2,p3)
```


[更新]2020.04.29 20:47  
=======
1、更新redis_cluster部分5.0.8，测试注释源码，修改 cluster-announce-ip 为容器ip: 172.1.30.11解决一建集群的问题；
2、腾讯开发者手册：https://cloud.tencent.com/developer/section/1374001；  

[更新]2020.04.28 11:04  
=======
1、更新ignotify同步；

[更新]2020.01.06 15:09  
=======
1、更新docker_php版本，更新swoole，添加加Protobuf（rpc使用）扩展;

[更新]2020.01.04 11:20  
=======
1、MySQL技巧测试sql文件；  

[更新]2019.12.26 10:26  
=======
虚拟机无损搭建  
1、整体目录调整到/home/wwwroot/cluster;  
2、php镜像加入apcu扩展;  
3、spl测试代码;   

[更新]2019-06-29 15:56  
=======
[更新]2019-06-29 15:56:45  
注意：自定义网络环境的创建  
1、使用 rec.redis.sh ，搭配配置文件，直接能创建起 redis-5.05 的主从环境；  
2、依照使用 rec.mysql.sh ，搭配配置文件，可以建立 mysql-8.0 官方更新的主从环境；  
3、使用 rec.nginx.sh ，搭配配置文件，建立 openresty 官方更新的服务环境；  
4、使用 rec.php.sh . 搭配配置文件，构建 php7.3 的镜像环境；  
5、使用 cluster_redis/rec.sh ，搭配配置文件，创建 基于redis-5.05 的3对主从集群；  
6、debian系统docker自动安装：docker_install.sh，TDengine 安装后提示； 


