#!/bin/bash

docker stop cs && docker rm cs
# docker network create --subnet=172.10.1.0/24 consultNet
# 单个启动可以服务
docker run -itd --name cs --network consultNet --ip 172.10.1.11 \
   -p 8500:8500 \
   -v data.s:/consul/data -v inits:/inits consul

docker exec -it cs /bin/sh inits
# 可以访问了： http://127.0.0.1:8500/


docker stop cc && docker rm cc
docker run -itd --name cc --network consultNet --ip 172.10.1.22 \
   -v data.c:/consul/data -v initc:/initc consul

docker exec -it cc /bin/sh initc
