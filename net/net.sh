#!/bin/bash
# docker stop nt && docker rm nt
# --privileged: iptables需要; --ip-forward关闭转发，该容器没有sysctl
docker run --privileged --name nt --network=mynet1 --ip=111.111.111.111 \
	-it --rm cffycls/net

