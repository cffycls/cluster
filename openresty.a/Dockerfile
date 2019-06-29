
FROM debian:stretch-slim

#MAINTAINER 维护者信息
MAINTAINER cffycls@foxmail.com
ENV RESOURCE "\
deb http://mirrors.163.com/debian/ stretch main non-free contrib \n\
deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib \n\
deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib \n\
deb-src http://mirrors.163.com/debian/ stretch main non-free contrib \n\
deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib \n\
deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib \n\
deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib \n\
deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib \
"
ENV VERSION 1.15.8.1

# ！！！注意字符串变量、转义自动解析
RUN echo $RESOURCE > /etc/apt/sources.list && cat /etc/apt/sources.list \
    && apt-get update \
    && apt-get install libpcre3-dev libssl-dev perl make build-essential curl libpq-dev \
        libpq-dev libperl-dev zlib1g-dev -y

COPY openresty-$VERSION.tar.gz /tmp/openresty.tar.gz
RUN groupadd -r openresty && useradd -r -g openresty openresty \
	# && curl  \
	&& mkdir -p /usr/src && cd /usr/src && mv /tmp/openresty.tar.gz ./ \
	&& tar -zxf openresty.tar.gz --strip-components 1 \
	&& ./configure \
	       --prefix=/usrl/ocal/openresty \
           --with-luajit \
           --without-http_redis2_module \
           --with-http_iconv_module \
           --with-http_postgres_module \
    \
    && make -j "$(nproc)" \
	&& make install \
	&& rm -rf /usr/src

VOLUME ["/usrl/ocal/openresty/nginx/conf","/usrl/ocal/openresty/nginx/html"]

EXPOSE 80
STOPSIGNAL SIGTERM
# 注意官方提示
CMD ["/usrl/ocal/openresty/nginx/sbin/nginx", "-g", "daemon off;"]