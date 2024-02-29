#!/bin/sh

docker run -d --name consul-s1 \
    --network mybridge --ip 172.1.111.111 \
    -p 8500:8500 \
    -v /home/wwwroot/cluster/consul/data.s:/consul/data \
    -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' \
    consul agent -node="dc1" -server -bind=172.1.111.111 -bootstrap -bootstrap-expect=1

#-bootstrap
#-bootstrap-expect=3
#docker run -d --name consul-s2 \
#    --network mybridge --ip 172.1.111.112 \
#    -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' \
#    consul agent -node="dc2 -bind=172.1.111.112 -join=172.1.111.111
# 访问： http://127.0.0.1:8500/

docker run -d --name consul-c1 \
    --network mybridge --ip 172.1.111.222 \
    -v /home/wwwroot/cluster/consul/data.c:/consul/data \
    -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' \
    -e CONSUL_BIND_INTERFACE=eth0 \
    consul agent -node="c1" -client=172.1.111.222 -join=172.1.111.111