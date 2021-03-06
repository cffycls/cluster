#!/bin/bash
docker stop tool && docker rm tool
# --privileged: iptables需要; --ip-forward关闭转发，该容器没有sysctl
# docker network create others --subnet=111.0.0.0/8
docker run --privileged --name tool \
  --network=others --ip=111.111.111.111 \
	-v /etc/timezone:/etc/localtime \
	-v /home/wwwroot/cluster/mysql/data/:/mysql_files/ \
	-v /home/wwwroot/cluster/sql_test/:/sql_test/ \
	-it cffycls/buster
