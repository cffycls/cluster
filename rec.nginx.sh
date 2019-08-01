#!/bin/bash
docker stop n1 n2 && docker rm n1 n2

#--privileged=true 容器内root权限运行
docker run -itd --name n1 -p 8080:80 --network=mybridge \
	--privileged=true \
	-v /root/tmp/dk/openresty.a/conf:/usr/local/openresty/nginx/conf \
	-v /root/tmp/dk/openresty.a/logs:/usr/local/openresty/nginx/logs \
	-v /root/tmp/dk/html:/usr/local/openresty/nginx/html openresty/openresty:stretch 
docker run -itd --name n2 -p 8082:80 --network=mybridge \
	--privileged=true \
	-v /root/tmp/dk/openresty.b/conf:/usr/local/openresty/nginx/conf \
	-v /root/tmp/dk/openresty.b/logs:/usr/local/openresty/nginx/logs \
	-v /root/tmp/dk/html:/usr/local/openresty/nginx/html openresty/openresty:stretch
