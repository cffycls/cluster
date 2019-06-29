#!/bin/bash
docker stop rm rs && docker rm rm rs

docker run --name rm -p 6379:6379 --restart=always -v /root/tmp/dk/redis/data:/data \
	-v /root/tmp/dk/redis/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis5:1.6 redis-server /etc/redis/redis.conf 
docker run --name rs -p 6381:6379 --restart=always -v /root/tmp/dk/redis_slave/data:/data \
	-v /root/tmp/dk/redis_slave/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis5:1.6 redis-server /etc/redis/redis.conf
