#!/bin/bash

docker stop mg1 && docker rm mg1 
docker stop mg2 && docker rm mg2 
docker stop mg3 && docker rm mg3 

# mongodb/mongod.conf
# 内部 -p 27017:27017

# rm -rf /home/wwwroot/cluster/mongodb.a/data/* && echo ''>/home/wwwroot/cluster/mongodb.a/mongod.log
# rm -rf /home/wwwroot/cluster/mongodb.b/data/* && echo ''>/home/wwwroot/cluster/mongodb.b/mongod.log
# rm -rf /home/wwwroot/cluster/mongodb.c/data/* && echo ''>/home/wwwroot/cluster/mongodb.c/mongod.log
docker run --name mg1 \
  --network=mybridge --ip=172.1.12.11 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/mongodb.a/mongod.conf:/etc/mongod.conf \
	-v /home/wwwroot/cluster/mongodb.a/mongod.log:/var/log/mongod.log \
	-v /home/wwwroot/cluster/mongodb.a/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf

docker run --name mg2 \
  --network=mybridge --ip=172.1.12.12 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/mongodb.a/mongod.conf:/etc/mongod.conf \
	-v /home/wwwroot/cluster/mongodb.b/mongod.log:/var/log/mongod.log \
	-v /home/wwwroot/cluster/mongodb.b/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf

docker run --name mg3 \
  --network=mybridge --ip=172.1.12.13 \
	-e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/mongodb.a/mongod.conf:/etc/mongod.conf \
	-v /home/wwwroot/cluster/mongodb.c/mongod.log:/var/log/mongod.log \
	-v /home/wwwroot/cluster/mongodb.c/data:/data/db \
	-d mongo mongod --config /etc/mongod.conf
