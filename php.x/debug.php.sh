#!/bin/bash
#docker network create mybridge --subnet=172.1.0.0/16
docker stop p4 && docker rm p4
docker run --name p4 --network=mybridge --ip=172.1.1.14 \
  -p 8086:9501 \
	-v /home/wwwroot/cluster/php.x/config:/usr/local/php/etc \
	-v /home/wwwroot/cluster/php.x/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-v /home/wwwroot/cluster/html:/var/www/html \
	--cap-add=SYS_PTRACE --security-opt seccomp=/home/wwwroot/cluster/php.x/profile.json \
	-itd cffycls/php:debug sh -f "/usr/local/php/etc/start.sh"

#docker stop n4 && docker rm n4
#docker run -itd --name n4 -p 8086:80 --network=mybridge \
#	--privileged=true \
#	-v /home/wwwroot/cluster/openresty.x/conf:/usr/local/openresty/nginx/conf \
#	-v /home/wwwroot/cluster/openresty.x/logs:/usr/local/openresty/nginx/logs \
#	-v /home/wwwroot/cluster/html:/usr/local/openresty/nginx/html openresty/openresty:stretch
