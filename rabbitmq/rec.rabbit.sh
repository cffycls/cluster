#!/bin/bash

docker stop rbt1 rbt2 && docker rm rbt1 rbt2
docker run --name rbt1 -p 15672:15672 \
	--network mybridge --ip=172.1.12.13 \
	--hostname rbt1 \
	-v /root/tmp/dk/rabbitmq/rabbitmq.conf \
	-v /root/tmp/dk/rabbitmq/data13:/var/lib/rabbitmq/mnesia \
	-e RABBITMQ_ERLANG_COOKIE='123456' \
	-e RABBITMQ_DEFAULT_USER=root -e RABBITMQ_DEFAULT_PASS=123456 \
	-d rabbitmq 
docker run --name rbt2 \
	--hostname rbt2 \
	--network mybridge --ip=172.1.12.14 \
	-v /root/tmp/dk/rabbitmq/rabbitmq.conf \
	-v /root/tmp/dk/rabbitmq/data14:/var/lib/rabbitmq/mnesia \
	-e RABBITMQ_ERLANG_COOKIE='123456' \
	-e RABBITMQ_DEFAULT_USER=root -e RABBITMQ_DEFAULT_PASS=123456 \
	-d rabbitmq
