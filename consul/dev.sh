#!/bin/bash

# 官方帮助 https://hub.docker.com/_/consul?tab=description
docker rm -f consul-s1 consul-c1
# 单个启动可以服务，默认-dev第一个无参数-ui访问启动
docker run -d --name consul-s1 \
    --network mybridge --ip 172.1.111.111 \
    -p 8500:8500 \
    -v /home/wwwroot/cluster/consul/data.s:/consul/data \
    -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' \
    consul
