#!/bin/bash
docker stop mm ms && docker rm mm ms 
docker run --name mm --restart=always -p 3306:3306 -v /root/tmp/dk/mysql/data:/var/lib/mysql \
	-v /root/tmp/dk/mysql/config:/etc/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8.0
docker run --name ms --restart=always -p 3308:3306 -v /root/tmp/dk/mysql_slave/data:/var/lib/mysql \
	-v /root/tmp/dk/mysql_slave/config:/etc/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8.0

echo -e '\nTo associate mater & slave, you should exec sentence like this in mysql command interface of the slave:'
echo 'change master to master_host='192.168.0.4',master_port=3306,master_user='repl',\
       	master_password='Ron_master_1',master_log_file='mysql-bin.000006',master_log_pos=155;'
