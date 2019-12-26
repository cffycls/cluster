# php7.3.5; Feb 7, 2019 link: https://github.com/docker-library/php/blob/master/7.3/alpine3.9/fpm/Dockerfile
# Base images 基础镜像+阿里源
FROM alpine:3.9

#MAINTAINER 维护者信息
MAINTAINER cffycls@foxmail.com

# dependencies required for running "phpize"
ENV PHP_VERSION 7.3.13

COPY packages /tmp
###
# wget -O packages/php.tar.xz "https://secure.php.net/get/php-7.3.13.tar.xz/from/this/mirror &&\
# wget -O packages/swoole.tar.gz "https://github.com/swoole/swoole-src/archive/master.tar.gz" && \
# wget -O packages/inotify.tgz "https://pecl.php.net/get/inotify-2.0.0.tgz" && \
# wget -O packages/redis.tgz "https://pecl.php.net/get/redis-5.0.0.tgz" && \
# wget -O packages/libuuid.tgz "http://nchc.dl.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz" && \
# wget -O packages/uuid.tgz "http://pecl.php.net/get/uuid-1.0.4.tgz" && \
# wget -O packages/memcached.tgz "https://pecl.php.net/get/memcached-3.1.3.tgz" && \
# wget -O packages/event.tgz "http://pecl.php.net/get/event-2.5.3.tgz" && \
# wget -O imagemagick.tgz "https://www.imagemagick.org/download/ImageMagick.tar.gz" && \
# wget -O imagick.tgz "https://pecl.php.net/get/imagick-3.4.4.tgz"
###
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    \
    && echo "use local '/tmp/*' packages..." && ls -l /tmp \
    && apk update \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    && mkdir -p "/usr/local/etc/php/conf.d" && mkdir -p "/var/www/html" \
    && chown www-data:www-data /var/www/html && chmod 777 /var/www/html \
    \
    #编译工具
    && PHPIZE_DEPS="\
            autoconf \
         dpkg-dev dpkg \
            file \
            g++ \
            gcc \
            libc-dev \
            make \
            pkgconf \
            re2c \
            " \
    #安装依赖
    && PHP_DEVS="\
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
       		libevent-dev \
       		rabbitmq-c-dev \
       		" \
    && apk add --no-cache \
        curl \
        tar \
        xz \
        openssl \
        wget \
		$PHPIZE_DEPS $PHP_DEVS \
    \
    && mkdir -p ~/bulid/php && cd ~/bulid/php \
    # && wget -O /tmp/php.tar.xz "https://secure.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror" \
    && tar -Jxf /tmp/php.tar.xz --strip-components 1 \
	&& ./configure \
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
        --with-pdo-mysql \
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
    && cd ../ && rm -rf php \
    #--enable-maintainer-zts \ #pthreads报错不用
	\
#======================================================================================================
    \
#======================================================================================================
#测试 -- 需要对话参数，所以自定义安装
    \
    \
	#swoole
    && \
    mkdir -p ~/build/swoole && cd ~/build/swoole && \
    # wget -O /tmp/swoole.tar.gz "https://github.com/swoole/swoole-src/archive/master.tar.gz" && \
    tar zxvf /tmp/swoole.tar.gz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure \
        --with-php-config=/usr/local/php/bin/php-config \
		--enable-coroutine \
		--enable-openssl  \
		--enable-http2  \
		--enable-async-redis \
		--enable-sockets \
		--enable-mysqlnd \
		&& \
	\
    make && make install && \
    cd ../ && rm -rf swoole \
	\
	\
	#inotify 2.0.0
    && \
    mkdir -p ~/build/inotify && cd ~/build/inotify && \
    # wget -O /tmp/inotify.tgz "https://pecl.php.net/get/inotify-2.0.0.tgz" && \
    tar -zxf /tmp/inotify.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure \
        --with-php-config=/usr/local/php/bin/php-config \
        --enable-inotify \
        && \
    make && make install && \
    cd .. && rm -rf inotify \
	\
	\
    #redis 5.0.0
    && \
    mkdir -p ~/build/redis && cd ~/build/redis && \
    # wget -O /tmp/redis.tgz "https://pecl.php.net/get/redis-5.0.0.tgz" && \
    tar -zxf /tmp/redis.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure \
        --with-php-config=/usr/local/php/bin/php-config \
        --enable-redis \
        && \
    make && make install && \
    cd .. && rm -rf redis \
	\
	\
    #uuid 1.0.4 (libuuid-1.0.3)
    && \
    mkdir -p ~/build/libuuid && cd ~/build/libuuid && \
    # wget -O /tmp/libuuid.tgz "http://nchc.dl.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz" && \
    tar -zxf /tmp/libuuid.tgz --strip-components 1 && \
    ./configure --prefix=/usr && \
    make && make install && \
    cd ../ && rm -rf libuuid && \
    \
    mkdir -p ~/build/uuid && cd ~/build/uuid && \
    # wget -O /tmp/uuid.tgz "http://pecl.php.net/get/uuid-1.0.4.tgz" && \
    tar -zxf /tmp/uuid.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd ../ && rm -rf uuid \
    \
    \
    #memcached 3.1.3 需要libmemcached
    && \
    apk add libmemcached-dev && \
    mkdir -p ~/build/memcached_p && cd ~/build/memcached_p && \
    # wget -O /tmp/memcached.tgz "https://pecl.php.net/get/memcached-3.1.3.tgz" && \
    tar -zxf /tmp/memcached.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd ../ && rm -rf memcached_p \
    \
    \
    #event 2.5.3
    && \
    mkdir -p ~/build/event && cd ~/build/event && \
    # wget -O /tmp/event.tgz "http://pecl.php.net/get/event-2.5.3.tgz" && \
    tar -zxf /tmp/event.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure \
        --with-php-config=/usr/local/php/bin/php-config \
        --with-event-libevent-dir=/usr \
        && \
    make && make install && \
    cd ../ && rm -rf event \
    \
    \
    #pthreads -->Segmentation fault 分段错误
    #&& \
    #mkdir -p ~/build/pthreads && cd ~/build/pthreads && \
    #unzip /tmp/pthreads.zip && cd pthreads-master \
    #/usr/local/php/bin/phpize && \
    #./configure --with-php-config=/usr/local/php/bin/php-config && \
    #make && make install && \
    #cd ../../ && rm -rf pthreads \
    #\
    \
    # imagick-3.4.4 需要imagemagick
    && \
    mkdir -p ~/build/imagemagick && cd ~/build/imagemagick && \
    tar -zxf /tmp/imagemagick.tgz --strip-components 1 && \
    ./configure && \
    make && make install && \
    cd ../ && rm -rf imagemagick && \
    \
    mkdir -p ~/build/imagick && cd ~/build/imagick && \
    tar -zxf /tmp/imagick.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd ../ && rm -rf imagick \
    \
#======================================================================================================
    \
#======================================================================================================
    \
    && ln -s /usr/local/php/bin/* /usr/local/bin && ln -s /usr/local/php/sbin/php-fpm /usr/local/bin \
    && pecl channel-update pecl.php.net \
    && pecl install igbinary \
    && pecl install amqp \
    && pecl install apcu \
    && rm -rf /tmp/* ~/.pearrc ~/build \
    && apk del $PHPIZE_DEPS \
    && php -m

EXPOSE 9000
CMD ["php-fpm"]

#docker build -t cffycls/php7:v1.10 .
