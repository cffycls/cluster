# php7.3.5; Feb 7, 2019 link: https://github.com/docker-library/php/blob/master/7.4/alpine3.11/cli/Dockerfile
# Base images 基础镜像+阿里源
FROM alpine:3.11

#MAINTAINER 维护者信息: +fileinfo
MAINTAINER cffycls@foxmail.com

# dependencies required for running "phpize" 2020.4.10组件更新
ENV PHP_VERSION 7.4.5

ADD packages /tmp/
###
# download.sh
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
            libxpm-dev \
           	gd-dev \
       		gettext-dev \
       		freetype-dev \
       		libevent-dev \
       		rabbitmq-c-dev \
            pcre2-dev \
## oniguruma: 安装php7.4的过程中，mbstring的正则表达式处理功能对这个包有依赖性
            oniguruma \
            oniguruma-dev \
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
        --enable-mbstring \
        ## 正则表达式函数中多字节字符的支持
        --enable-mbregex \
        --enable-mysqlnd \
        --with-mysqli \
        --with-pdo-mysql \
        --enable-sysvmsg \
        --enable-ftp \
        ## 操作图像元数据，配合gd
        --enable-exif \
        ## 信号处理的回调
        --enable-pcntl \
        --enable-sockets \
        --enable-sysvsem \
        --enable-xml \
        ## 高精度运算的函数库
        --enable-bcmath \
        --with-openssl \
        --with-curl \
        ## 命令行交互的库
        --with-libedit \
        --with-zlib \
        ## pcre动态编译
        --with-pcre-jit \
        --with-pear \
        --with-libxml \
        ## gd图片库
        --enable-gd \
        --with-jpeg \
        --with-xpm \
        --with-freetype \
        ## 国际化语言扩展
        --with-gettext \
        ## 字符集转换
        --with-iconv \
        \
        --enable-fpm \
        --with-fpm-user=www-data \
        --with-fpm-group=www-data \
        --disable-cgi \
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
	# swoole
    && \
    mkdir -p ~/build/swoole && cd ~/build/swoole && \
    tar zxvf /tmp/swoole.tar.gz --strip-components 1 && \
    /usr/local/php/bin/phpize && \
    ./configure \
        --with-php-config=/usr/local/php/bin/php-config \
		--enable-openssl  \
		--enable-http2  \
		--enable-sockets \
		&& \
	\
    make && make install && \
    cd ../ && rm -rf swoole \
	\
	\
    #uuid 1.0.4 (libuuid-1.0.3)
    && \
    mkdir -p ~/build/libuuid && cd ~/build/libuuid && \
    tar -zxf /tmp/libuuid.tgz --strip-components 1 && \
    ./configure --prefix=/usr && \
    make && make install && \
    cd ../ && rm -rf libuuid \
    \
    # swoole_tracker74
    && mv /tmp/swoole-tracker/swoole_tracker74.so /usr/local/php/lib/php/extensions/no-debug-non-zts-20190902/swoole_tracker.so \
    \
    # sdebug
    #&& cd /tmp/ && git clone https://github.com/mabu233/sdebug.git && cd sdebug \
    ##&& pwd && ls rebuild.sh -lh && ./rebuild.sh \ bash无
    #&& phpize && ./configure && make clean && make all && make install \
    \
#======================================================================================================
    \
#======================================================================================================
    \
    && ln -s /usr/local/php/bin/* /usr/local/bin/ \
    && ln -s /usr/local/php/sbin/php-fpm /usr/local/bin \
    && pecl channel-update pecl.php.net \
    && pecl install igbinary amqp apcu protobuf redis uuid inotify event \
    && rm -rf /tmp/* ~/.pearrc ~/build \
    && apk del $PHPIZE_DEPS \
    && php -m

# 部署node-agent
#参考：https://github.com/hyperf/hyperf-docker - swoole tracker
ADD packages/swoole-tracker-install.sh /tmp/
RUN chmod +x /tmp/swoole-tracker-install.sh && cd /tmp/ && \
    ./swoole-tracker-install.sh && \
    rm -rf /tmp/*

# 添加entrypoint脚本
RUN printf '#!/bin/sh\n/opt/swoole/script/php/swoole_php /opt/swoole/node-agent/src/node.php &\nphp-fpm $@' > /opt/swoole/entrypoint.sh && \
    chmod 755 /opt/swoole/entrypoint.sh

# 启用entrypoint脚本（-x方便调试， 可以去掉）
ENTRYPOINT [ "sh", "-x", "/opt/swoole/entrypoint.sh" ]
# docker build -t cffycls/php:debug .