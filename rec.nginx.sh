#!/bin/bash
docker stop n1 n2 && docker rm n1 n2

docker run -itd --name n1 -p 80:80 -v /root/tmp/dk/openresty/conf:/usrl/local/openresty/nginx/conf \
	-v /root/tmp/dk/openresty/html:/usr/local/openresty/nginx/html openresty/openresty
docker run -itd --name n2 -p 82:80 -v /root/tmp/dk/openresty/conf:/usrl/local/openresty/nginx/conf \
	-v /root/tmp/dk/openresty/html:/usr/local/openresty/nginx/html openresty/openresty
