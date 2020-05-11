#!/bin/bash
#docker network create mybridge --subnet=172.1.0.0/16
docker stop px && docker rm px
docker run --name px --network=mybridge --ip=172.1.1.14 \
  -p 9603:9603 \
  -p 8086:9501 \
	-v /home/wwwroot/cluster/php.x/config:/usr/local/php/etc \
	-v /home/wwwroot/cluster/php.x/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-v /home/wwwroot/default/:/var/www/html/ \
	--cap-add=SYS_PTRACE --security-opt seccomp=/home/wwwroot/cluster/php.x/profile.json \
	-itd cffycls/php:debug sh -f "/usr/local/php/etc/start.sh"
