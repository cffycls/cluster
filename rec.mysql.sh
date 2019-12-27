#!/bin/bash
docker stop mm ms && docker rm mm ms 
<<<<<<< HEAD
docker run --name mm --restart=always -p 3307:3306 \
	 --network=mybridge --ip=172.1.11.11 \
	-v /home/wwwroot/cluster/mysql/data:/var/lib/mysql \
	-v /home/wwwroot/cluster/mysql/config:/etc/mysql \
=======
docker run --name mm --restart=always -p 3306:3306 \
	 --network=mybridge --ip=172.1.11.11 \
	-v /root/tmp/dk/mysql/data:/var/lib/mysql \
	-v /root/tmp/dk/mysql/config:/etc/mysql \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-e MYSQL_ROOT_PASSWORD=123456 \
	-d mysql:8.0
docker run --name ms --restart=always -p 3308:3306 \
	 --network=mybridge --ip=172.1.11.12 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/mysql_slave/data:/var/lib/mysql \
	-v /home/wwwroot/cluster/mysql_slave/config:/etc/mysql \
=======
	-v /root/tmp/dk/mysql_slave/data:/var/lib/mysql \
	-v /root/tmp/dk/mysql_slave/config:/etc/mysql \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-e MYSQL_ROOT_PASSWORD=123456 \
	-d mysql:8.0

echo -e '\nTo associate mater & slave, you should exec sentence like this in mysql command interface of the slave:'
echo 'change master to master_host='172.1.1.11',master_port=3306,master_user='repl',\
       	master_password='Ron_master_1',master_log_file='mysql-bin.000006',master_log_pos=155;'
<<<<<<< HEAD

=======
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
