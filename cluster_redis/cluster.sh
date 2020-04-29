#!/bin/bash
docker stop clm31 clm32 clm33 cls51 cls52 cls53
docker rm clm31 clm32 clm33 cls51 cls52 cls53

docker run --name clm31 \
	--restart=always \
	--network=mybridge --ip=172.1.30.11 \
	-v /home/wwwroot/cluster/cluster_redis/6391/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/6391/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis

docker run --name clm32 \
	--restart=always \
	--network=mybridge --ip=172.1.30.12 \
	-v /home/wwwroot/cluster/cluster_redis/6392/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/6392/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis

docker run --name clm33 \
	--restart=always \
	--network=mybridge --ip=172.1.30.13 \
	-v /home/wwwroot/cluster/cluster_redis/6393/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/6393/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis


docker run --name cls51 \
	--restart=always \
	--network=mybridge --ip=172.1.50.11 \
	-v /home/wwwroot/cluster/cluster_redis/6394/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/6394/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis 

docker run --name cls52 \
	--restart=always \
	--network=mybridge --ip=172.1.50.12 \
	-v /home/wwwroot/cluster/cluster_redis/6395/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/6395/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis 

docker run --name cls53 \
	--restart=always \
	--network=mybridge --ip=172.1.50.13 \
	-v /home/wwwroot/cluster/cluster_redis/6396/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/6396/redis.conf:/etc/redis/redis.conf \
	-d cffycls/redis 
