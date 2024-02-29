
# Base images 基础镜像+多源
FROM debian:buster-slim

#MAINTAINER 维护者信息
MAINTAINER cffycls@foxmail.com

#https报错，用http
RUN cat /etc/issue \
    && mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo "\
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释 \n\
deb http://mirrors.ustc.edu.cn/debian/ buster main \n\
deb-src http://mirrors.ustc.edu.cn/debian/ buster main \n\
 \n\
deb http://security.debian.org/debian-security buster/updates main \n\
deb-src http://security.debian.org/debian-security buster/updates main \n\
 \n\
# buster-updates, previously known as 'volatile' \n\
deb http://mirrors.ustc.edu.cn/debian/ buster-updates main \n\
deb-src http://mirrors.ustc.edu.cn/debian/ buster-updates main \n\
 \n\
deb http://mirrors.ustc.edu.cn/debian/ buster-backports main non-free contrib \n\
deb-src http://mirrors.ustc.edu.cn/debian/ buster-backports main non-free contrib \n\
"  > /etc/apt/sources.list && cat /etc/apt/sources.list && apt-get update \
    && apt update && apt list --upgradable

# --assume-yes apt-utils 默认是
RUN apt-get install --assume-yes apt-utils \
    autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c wget unzip \
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
    && apt-get install --assume-yes libpcap-dev tcl-dev && ln -sf /usr/include/pcap-bpf.h /usr/include/net/bpf.h \
    && ./configure && make && make install \
    && cd .. && rm -rf hping-master && hping -v

RUN apt-get install --assume-yes percona-toolkit pmm-client mariadb-client \
    && pt-query-digest --version && mysql -V

#    && apt --fix-broken install && apt-get install percona-toolkit -y \
# docker build -t cffycls/buster .