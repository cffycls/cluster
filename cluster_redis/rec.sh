#!/bin/bash
docker stop clm1 clm2 clm3 cls1 cls2 cls3
docker rm clm1 clm2 clm3 cls1 cls2 cls3

docker run --name clm1 \
	--restart=always \
	--network=mybridge --ip=172.1.50.11 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6391/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6391/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:1.7 

docker run --name clm2 \
	--restart=always \
	--network=mybridge --ip=172.1.50.12 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6392/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6392/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:1.7 

docker run --name clm3 \
	--restart=always \
	--network=mybridge --ip=172.1.50.13 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6393/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6393/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:1.7 

docker run --name cls1 \
	--restart=always \
	--network=mybridge --ip=172.1.30.11 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6394/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6394/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:1.7 

docker run --name cls2 \
	--restart=always \
	--network=mybridge --ip=172.1.30.12 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6395/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6395/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:1.7 

docker run --name cls3 \
	--restart=always \
	--network=mybridge --ip=172.1.30.13 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6396/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6396/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:1.7 

