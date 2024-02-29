#!/bin/bash
#docker network create mybridge --subnet=172.1.0.0/16
docker stop p1 p2 p3 && docker rm p1 p2 p3

# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
docker run --name p1 \
	--restart=always \
  --network=mybridge --ip=172.1.1.11 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/php.a/config:/usr/local/php/etc \
	-v /home/wwwroot/cluster/php.a/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-v /home/wwwroot/cluster/html:/var/www/html \
	-itd cffycls/php

docker run --name p2 \
	--restart=always \
  --network=mybridge --ip=172.1.1.12 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/php.a/config:/usr/local/php/etc \
	-v /home/wwwroot/cluster/php.b/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-v /home/wwwroot/cluster/html:/var/www/html \
	-itd cffycls/php

docker run --name p3 \
	--restart=always \
	--network=mybridge --ip=172.1.1.13 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/php.a/config:/usr/local/php/etc \
	-v /home/wwwroot/cluster/html:/var/www/html \
	-v /home/wwwroot/cluster/php.c/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-itd cffycls/php
