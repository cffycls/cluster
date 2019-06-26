# php7.3.5; Feb 7, 2019 link: https://github.com/docker-library/php/blob/master/7.3/alpine3.9/fpm/Dockerfile
# Base images 基础镜像+阿里源
FROM alpine:3.9

#MAINTAINER 维护者信息
MAINTAINER cffycls@foxmail.com

# dependencies required for running "phpize"
ENV PHP_VERSION 7.3.6
ENV PHP_URL https://secure.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror
ENV PHPIZE_DEPS \
        autoconf \
        dpkg-dev dpkg \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c
ENV PHPIZE_DEVS \
		argon2-dev \
		coreutils \
		curl-dev \
		libedit-dev \
		libsodium-dev \
		libxml2-dev \
		openssl-dev \
		sqlite-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		gd-dev \
		gettext-dev \
		freetype-dev \
		libxpm-dev \
		libevent-dev

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    && mkdir -p "/usr/local/etc/php/conf.d" && mkdir -p "/var/www/html" \
    && chown www-data:www-data /var/www/html && chmod 777 /var/www/html \
    && apk add --no-cache\
        curl \
        tar \
        xz \
        openssl \
        wget 

COPY php.tar.xz php.tar.xz
RUN set -eux; \
		apk add $PHPIZE_DEPS $PHPIZE_DEVS \
			
        # && wget -O php.tar.xz "$PHP_URL" \
        && tar -Jxf php.tar.xz && cd php-$PHP_VERSION && ./configure \
        --prefix="/usr/local/php" \
        --with-config-file-path="/usr/local/php/etc" \
        --with-config-file-scan-dir="/usr/local/php/etc/conf.d" \
        \
        --enable-option-checking=fatal \
        --with-mhash \
        \
        --enable-ftp \
        --enable-exif \
        --enable-mbregex \
        --enable-mbstring \
        --enable-mysqlnd \
        --enable-sysvmsg \
        --enable-opcache \
        --enable-pcntl \
        --enable-sockets \
        --enable-sysvsem \
        --enable-xml \
        --with-curl \
        --with-libedit \
        --with-openssl \
        --with-zlib \
        --with-pcre-regex \
        --with-pear \
        --with-libxml-dir=/usr \
        --with-jpeg-dir \
        --with-freetype-dir \
        --with-xpm-dir \
        --with-png-dir \
        --with-gettext \
        --with-mhash \
        --with-iconv \
        --disable-fileinfo \
        \
        --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --disable-cgi \
    && make -j "$(nproc)" \
    && find -type f -name '*.a' -delete \
    && make install \
#    && make clean \
    && cd ../ && rm -rf php-$PHP_VERSION.tar.xz php-$PHP_VERSION 
