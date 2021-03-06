#!/bin/sh
docker stop clm4 cls4
docker rm clm4 cls4

docker run --name clm4 \
	--restart=always \
	--network=mybridge --ip=172.1.50.21 \
	-v /home/wwwroot/cluster/cluster_redis/6381/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis

docker run --name cls4 \
	--restart=always \
	--network=mybridge --ip=172.1.30.21 \
	-v /home/wwwroot/cluster/cluster_redis/6382/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis

