#!/bin/sh
docker stop clm4 cls4
docker rm clm4 cls4

docker run --name clm4 \
	--restart=always \
	--network=mybridge --ip=172.1.50.21 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6381/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6381/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:cluster2 

docker run --name cls4 \
	--restart=always \
	--network=mybridge --ip=172.1.30.21 \
<<<<<<< HEAD
	-v /home/wwwroot/cluster/cluster_redis/6382/data:/data \
	-v /home/wwwroot/cluster/cluster_redis/redis.conf:/etc/redis/redis.conf \
=======
	-v /root/tmp/dk/cluster_redis/6382/data:/data \
	-v /root/tmp/dk/cluster_redis/redis.conf:/etc/redis/redis.conf \
>>>>>>> a1ba97448eb0591672e5fec47b8981de01bf6183
	-d cffycls/redis5:cluster2 
