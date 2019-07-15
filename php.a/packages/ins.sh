#!/bin/sh
addgroup -g 82 -S www-data && adduser -u 82 -D -S -G www-data www-data

sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    \
    && echo "use local '/tmp/*' packages..." && ls -l /tmp \
    && apk update \
    && mkdir -p "/usr/local/etc/php/conf.d" && mkdir -p "/var/www/html" \
    && chown www-data:www-data /var/www/html && chmod 777 /var/www/html \
    \
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
	\
    \
    \
    \
    && \
    mkdir -p ~/build/swoole && cd ~/build/swoole && \
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
    && \
    mkdir -p ~/build/inotify && cd ~/build/inotify && \
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
    && \
    mkdir -p ~/build/redis && cd ~/build/redis && \
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
    && \
    mkdir -p ~/build/libuuid && cd ~/build/libuuid && \
    tar -zxf /tmp/libuuid.tgz --strip-components 1 && \
    ./configure --prefix=/usr && \
    make && make install && \
    cd ../ && rm -rf libuuid && \
    \
    mkdir -p ~/build/uuid && cd ~/build/uuid && \
    tar -zxf /tmp/uuid.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd ../ && rm -rf uuid \
	\
	\
    && \
    apk add libmemcached-dev && \
    mkdir -p ~/build/memcached_p && cd ~/build/memcached_p && \
    tar -zxf /tmp/memcached.tgz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd ../ && rm -rf memcached_p \
	\
	\
    && \
    mkdir -p ~/build/event && cd ~/build/event && \
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
    \
    && /usr/local/php/bin/pecl channel-update pecl.php.net \
    && /usr/local/php/bin/pecl install igbinary \
    && rm  ~/.pearrc ~/build \
    && apk del $PHPIZE_DEPS \
	&& ln -s /usr/local/php/bin/php /usr/bin/php \
	&& ln -s /usr/local/php/bin/pecl /usr/bin/pecl \
	&& ln -s /usr/local/php/sbin/php-fpm /usr/bin/php-fpm \
    && php -m
