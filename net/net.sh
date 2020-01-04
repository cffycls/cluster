#!/bin/bash
docker stop nt1 nt2 nt3 && docker rm nt1 nt2 nt3
#--privileged: iptables需要; --ip-forward关闭转发，该容器没有sysctl
docker run --privileged --name nt1 --network=mynet1 --ip=111.111.111.111 \
	-itd cffycls/net
docker run --privileged --name nt2 --network=mynet1 --ip=111.111.222.222 \
	-itd cffycls/net
docker run --privileged --name nt3 --network=mynet2 --ip=222.222.222.222 \
	-itd cffycls/net

