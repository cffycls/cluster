# cluster
2019-06-26 14:09:01创建  
  
搭建集群环境脚本
文章地址：https://segmentfault.com/u/canglangshui/articles 

<<<<<<< HEAD
[更新]2019.12.26 10:26
虚拟机无损搭建  
1、整体目录调整到/home/wwwroot/cluster;  
2、php镜像加入apcu扩展;  
3、spl测试代码;   

[更新]2019-06-29 15:56  
=======
[更新]2019-06-29 15:56:45  
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
注意：自定义网络环境的创建  
1、使用 rec.redis.sh ，搭配配置文件，直接能创建起 redis-5.05 的主从环境；  
2、依照使用 rec.mysql.sh ，搭配配置文件，可以建立 mysql-8.0 官方更新的主从环境；  
3、使用 rec.nginx.sh ，搭配配置文件，建立 openresty 官方更新的服务环境；  
4、使用 rec.php.sh . 搭配配置文件，构建 php7.3 的镜像环境；  
5、使用 cluster_redis/rec.sh ，搭配配置文件，创建 基于redis-5.05 的3对主从集群；  
6、debian系统docker自动安装：docker_install.sh，TDengine 安装后提示； 


