#/bin/bash

#1、清理所有已经停止的容器
# docker rm $(docker ps -a -q)

#2、清理所有镜像
# docker rmi $(docker images -q)

#3、强制清理所有镜像
# docker rmi -f $(docker images -q)

#4、删除不运行的容器
#ocker container prune

#5、清理过滤出来的镜像
#ocker rmi $(docker images | grep "none" | awk '{print $3}')

#6、自动清理命令
docker system prune 
<<COMMENT
可对空间进行自动清理。
该命令所清理的对象如下：

已停止的容器
未被任何容器使用的卷
未被任何容器所关联的网络
所有悬空的镜像
COMMENT
