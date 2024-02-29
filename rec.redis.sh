#!/bin/bash
docker stop rm rs && docker rm rm rs

docker run --name rm \
	--restart=always \
	--network=mybridge --ip=172.1.13.11 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/redis/data:/data \
	-v /home/wwwroot/cluster/redis/sentinel:/sentinel \
	-v /home/wwwroot/cluster/redis/redis.conf:/etc/redis/redis.conf \
	-v /home/wwwroot/cluster/redis/sentinel.conf:/etc/redis/sentinel.conf \
	-d cffycls/redis

docker run --name rs \
  --restart=always \
	--network=mybridge --ip=172.1.13.12 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/redis_slave/data:/data \
	-v /home/wwwroot/cluster/redis_slave/sentinel:/sentinel \
	-v /home/wwwroot/cluster/redis_slave/redis.conf:/etc/redis/redis.conf \
	-v /home/wwwroot/cluster/redis_slave/sentinel.conf:/etc/redis/sentinel.conf \
	-d cffycls/redis
