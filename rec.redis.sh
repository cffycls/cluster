#!/bin/bash
docker stop rm rs && docker rm rm rs

docker run --name rm \
       	--restart=always \
	--network=mybridge --ip=172.1.13.11 \
	-v /root/tmp/dk/redis/data:/data \
	-v /root/tmp/dk/redis/redis.conf:/etc/redis/redis.conf \
	-v /root/tmp/dk/redis/sentinel.conf:/etc/redis/sentinel.conf \
	-d cffycls/redis5:1.7  
docker run --name rs \
	--restart=always \
	--network=mybridge --ip=172.1.13.12 \
	-v /root/tmp/dk/redis_slave/data:/data \
	-v /root/tmp/dk/redis_slave/redis.conf:/etc/redis/redis.conf \
	-v /root/tmp/dk/redis_slave/sentinel.conf:/etc/redis/sentinel.conf \
	-d cffycls/redis5:1.7  
