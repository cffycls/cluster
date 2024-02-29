#!/bin/bash
docker stop mc1
docker rm mc1

# 内部 -p 11211:11211
docker run --name mc1 \
  --network=mybridge --ip=172.1.14.11 \
	-v /etc/timezone:/etc/localtime \
  -d memcached memcached -m 64
