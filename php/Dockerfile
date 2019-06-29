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
    && rm -rf /tmp/pear ~/.pearrc \
    && cd ../ && rm -rf php-$PHP_VERSION.tar.xz php-$PHP_VERSION

#======================================================================================================

#======================================================================================================
#测试

#swoole 需要对话参数，所以自定义安装
RUN set -ex && \
    mkdir -p ~/build/swoole && \
    cd ~/build/swoole && \
    wget -O swoole.tar.gz https://github.com/swoole/swoole-src/archive/master.tar.gz && \
    tar zxvf swoole.tar.gz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config \
    --enable-coroutine \
    --enable-openssl  \
    --enable-http2  \
    --enable-async-redis \
    --enable-sockets \
    --enable-mysqlnd && \
    make && make install && \
    cd ../ && rm -rf swoole*

#inotify
RUN set -ex && \
    mkdir -p ~/build/inotify && \
    cd ~/build/inotify && \
    wget -O inotify.tgz https://pecl.php.net/get/inotify-2.0.0.tgz && \
    tar -zxf inotify.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config --enable-inotify && \
    make && make install && \
    cd .. && rm -rf inotify*

#redis
RUN set -ex && \
    mkdir -p ~/build/redis && \
    cd ~/build/redis && \
    wget -O redis.tgz https://pecl.php.net/get/redis-4.3.0.tgz && \
    tar -zxf redis.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config --enable-redis && \
    make && make install && \
    cd .. && rm -rf redis*

#uuid
RUN set -ex && \
    mkdir -p ~/build/libuuid && \
    cd ~/build/libuuid && \
    wget -O libuuid.tgz "http://nchc.dl.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz" && \
    tar -zxf libuuid.tgz --strip-components 1 && \
    ./configure --prefix=/usr && \
    make && make install && \
    cd ../ && rm -rf libuuid* && \
    \
    wget -O uuid.tgz http://pecl.php.net/get/uuid-1.0.4.tgz && \
    tar zxf uuid.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd ../ && rm -rf uuid*

#memcached
RUN set -ex && \
    #测试命令：/usr/bin/memcached -d -m 1024 -u root -l 0.0.0.0 -p 11211 -c 1024 -P /tmp/memcached.pid 启动正常
    mkdir -p ~/build/memcached && \
    cd ~/build/memcached && \
    wget -O memcached.tgz "http://memcached.org/files/memcached-1.5.16.tar.gz" && \
    tar -zxf memcached.tgz --strip-components 1 && \
    ./configure --with-event-libevent-dir=/usr --prefix=/usr && \
    make && make install && \
    cd ../ && rm -rf memcached* && \
    \
    #需要libmemcached
    apk add libmemcached-dev && \
    \
    mkdir -p ~/build/memcached_p && \
    cd ~/build/memcached_p && \
    wget -O memcached.tgz "https://pecl.php.net/get/memcached-3.1.3.tgz" && \
    tar -zxf memcached.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd ../ && rm -rf memcached_p*

#编译使用，运行时共享 -v /your_real_path/ /usr/local/php/etc/
COPY config /usr/local/php/etc
VOLUME ["/usr/local/php/etc","/var/www/html"]

RUN set -ex \
    && /usr/local/php/bin/pecl channel-update pecl.php.net \
    && /usr/local/php/bin/pecl install igbinary event \
    && /usr/local/php/bin/php -m

RUN set -ex \
    && rm -rf /tmp/pear ~/.pearrc ~/build \
    && apk del $PHPIZE_DEPS \
    && /usr/local/php/bin/php -m

CMD ["/usr/local/php/etc/start.sh"]

#docker build -t cffycls/php7:v0.9 .