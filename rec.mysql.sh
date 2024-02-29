#!/bin/bash
docker stop mm && docker rm mm
docker stop ms && docker rm ms

# 内部3306  -p 3308:3306 \
docker run --name mm \
  --restart=always \
  --network=mybridge --ip=172.1.11.11 \
  -v /etc/timezone:/etc/localtime \
  -v /home/wwwroot/cluster/mysql/data/:/var/lib/mysql/ \
  -v /home/wwwroot/cluster/mysql/config/:/etc/mysql/ \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -d mysql:8.0

docker run --name ms \
  --restart=always \
  --network=mybridge --ip=172.1.11.12 \
  -v /etc/timezone:/etc/localtime \
  -v /home/wwwroot/cluster/mysql_slave/data/:/var/lib/mysql/ \
  -v /home/wwwroot/cluster/mysql_slave/config/:/etc/mysql/ \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -d mysql:8.0

echo -e "\n镜像启动后如果 mater & slave 没有正确关联, 在MySQL的主机登录`SHOW MASTER STATUS`查看参数、从机的命令行执行： "
echo "change master to master_host='172.1.1.11',master_port=3306,master_user='repl',master_password='Ron_master_1',master_log_file='mysql-bin.000006',master_log_pos=155;"


# 在宿主机下ping你配置的容器的，只要是172.50.0.0 段的都可以ping通
docker network create mybridge --subnet=172.16.0.0/16
docker run --name mysql56  \
  --network=mybridge --ip=172.16.21.11 \
  -e MYSQL_ROOT_PASSWORD=root \
  -d mysql:5.6
docker run --name mysql5624  \
  --network=mybridge --ip=172.16.21.12 \
  -e MYSQL_ROOT_PASSWORD=root \
  -d mysql:5.6.24
CREATE TABLE `set_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` set('','0','1','2','3','4','5','6') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='set测试表';
