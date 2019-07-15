#!/bin/bash
#docker network create mybridge --subnet=172.1.0.0/16
docker stop p1 p2 p3 && docker rm p1 p2 p3

docker run --name p1 --network=mybridge --ip=172.1.1.11 \
	-v /root/tmp/dk/php.a/config:/usr/local/php/etc \
	-v /root/tmp/dk/php.a/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-v /root/tmp/dk/html:/var/www/html \
	-itd cffycls/php7:1.8

docker run --name p2 --network=mybridge --ip=172.1.1.12 \
	-v /root/tmp/dk/php.b/config:/usr/local/php/etc \
	-v /root/tmp/dk/php.b/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-v /root/tmp/dk/html:/var/www/html \
	-itd cffycls/php7:1.8

docker run --name p3 --network=mybridge --ip=172.1.1.13 \
	-v /root/tmp/dk/php.c/config:/usr/local/php/etc \
	-v /root/tmp/dk/html:/var/www/html \
	-v /root/tmp/dk/php.c/fpm.log:/usr/local/php/var/log/php-fpm.log \
	-itd cffycls/php7:1.8
