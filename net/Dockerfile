
# Base images 基础镜像+阿里源
FROM debian:buster-slim

#MAINTAINER 维护者信息
MAINTAINER yongqiang.wang

#https报错，用http
RUN cat /etc/issue \
    && echo "\
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释 \n\
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free \n\
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free\n\
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free \n\
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free\n\
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free \n\
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free\
deb http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free\n\
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
"  > /etc/apt/sources.list && cat /etc/apt/sources.list && apt-get update

RUN apt-get install -y autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c wget unzip \
    vim tcpdump net-tools inetutils-ping telnet iptables iproute2 iproute2-doc curl \
    traceroute mtr nmap netcat \
    && mkdir -p /tmp/build && cd /tmp/build \
#============================================== fping ========================================================
    && wget http://fping.org/dist/fping-4.2.tar.gz && tar -xf fping-4.2.tar.gz && cd fping-4.2 \
    && ./configure && make && make install \
    && cd .. && rm -rf fping-4.2 \
#============================================== hping ========================================================
    && wget https://codeload.github.com/antirez/hping/zip/master \
    && unzip master && cd hping-master/ \
    && apt-get install -y libpcap-dev tcl-dev && ln -sf /usr/include/pcap-bpf.h /usr/include/net/bpf.h \
    && ./configure && make && make install \
    && cd .. && rm -rf hping-master
