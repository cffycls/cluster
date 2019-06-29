#!/bin/bash
docker stop n1 n2 && docker rm n1 n2

docker run -itd --name n1 -p 80:80 -v /root/tmp/dk/openresty.a/conf:/usrl/local/openresty/nginx/conf \
	-v /root/tmp/dk/openrestya./html:/usr/local/openresty/nginx/html openresty/openresty
docker run -itd --name n2 -p 82:80 -v /root/tmp/dk/openresty.b/conf:/usrl/local/openresty/nginx/conf \
	-v /root/tmp/dk/openresty.b/html:/usr/local/openresty/nginx/html openresty/openresty
