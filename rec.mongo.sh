#!/bin/bash

docker stop mg1 && docker rm mg1 
docker stop mg2 && docker rm mg2 
docker stop mg3 && docker rm mg3 

cp -f  mongodb/mongod.conf mongodb.a/mongod.conf && cp -f  mongodb/mongod.conf mongodb.b/mongod.conf

<<<<<<< HEAD
rm -rf /home/wwwroot/cluster/mongodb/data/* #&& echo ''>/home/wwwroot/cluster/mongodb/mongod.log
docker run --name mg1 \
	-p 27017:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /home/wwwroot/cluster/mongodb/mongod.conf:/etc/mongod.conf \
	-v /home/wwwroot/cluster/mongodb/mongod.log:/var/log/mongod.log \
	-v /home/wwwroot/cluster/mongodb/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf
	
rm -rf /home/wwwroot/cluster/mongodb.a/data/* #&& echo ''>/home/wwwroot/cluster/mongodb.a/mongod.log
docker run --name mg2 \
	-p 27018:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /home/wwwroot/cluster/mongodb.a/mongod.conf:/etc/mongod.conf \
	-v /home/wwwroot/cluster/mongodb.a/mongod.log:/var/log/mongod.log \
	-v /home/wwwroot/cluster/mongodb.a/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf
	
rm -rf /home/wwwroot/cluster/mongodb.b/data/* #&& echo ''>/home/wwwroot/cluster/mongodb.b/mongod.log
docker run --name mg3 \
	-p 27019:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /home/wwwroot/cluster/mongodb.b/mongod.conf:/etc/mongod.conf \
	-v /home/wwwroot/cluster/mongodb.b/mongod.log:/var/log/mongod.log \
	-v /home/wwwroot/cluster/mongodb.b/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf

=======
rm -rf /root/tmp/dk/mongodb/data/* #&& echo ''>/root/tmp/dk/mongodb/mongod.log
docker run --name mg1 \
	-p 27017:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /root/tmp/dk/mongodb/mongod.conf:/etc/mongod.conf \
	-v /root/tmp/dk/mongodb/mongod.log:/var/log/mongod.log \
	-v /root/tmp/dk/mongodb/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf
	
rm -rf /root/tmp/dk/mongodb.a/data/* #&& echo ''>/root/tmp/dk/mongodb.a/mongod.log
docker run --name mg2 \
	-p 27018:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /root/tmp/dk/mongodb.a/mongod.conf:/etc/mongod.conf \
	-v /root/tmp/dk/mongodb.a/mongod.log:/var/log/mongod.log \
	-v /root/tmp/dk/mongodb.a/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf
	
rm -rf /root/tmp/dk/mongodb.b/data/* #&& echo ''>/root/tmp/dk/mongodb.b/mongod.log
docker run --name mg3 \
	-p 27019:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /root/tmp/dk/mongodb.b/mongod.conf:/etc/mongod.conf \
	-v /root/tmp/dk/mongodb.b/mongod.log:/var/log/mongod.log \
	-v /root/tmp/dk/mongodb.b/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf


>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
