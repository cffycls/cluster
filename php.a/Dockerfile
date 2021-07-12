# php8.03; 2021.04 link: https://github.com/docker-library/php/blob/master/8.0/alpine3.14/cli/Dockerfile
# Base images 基础镜像+阿里源
FROM alpine:3.14

#MAINTAINER 维护者信息: +fileinfo
MAINTAINER cffycls@foxmail.com

# dependencies required for running "phpize" 2020.4.26组件更新
ENV PHP_VERSION=8.0.8 \
    PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c " \
    PHP_DEVS="argon2-dev coreutils curl-dev libedit-dev libsodium-dev libxml2-dev openssl-dev sqlite-dev \
        libjpeg-turbo-dev libxpm-dev gd-dev gettext-dev freetype-dev libevent-dev rabbitmq-c-dev pcre2-dev \
        oniguruma oniguruma-dev"

COPY packages/ /tmp

RUN echo '安装环境依赖' \
    && set -ex \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    \
    && echo "use local '/tmp/*' packages..." && ls -l /tmp \
    && apk update \
    \
    #编译工具
    && apk add --no-cache \
        curl \
        tar \
        xz \
        openssl \
        wget \
		$PHPIZE_DEPS $PHP_DEVS

RUN echo '编译安装php' \
    && set -ex \
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
        --disable-cgi \
    && make -j "$(nproc)" \
    && find -type f -name '*.a' -delete \
    && make install \
    && ln -s /usr/local/php/bin/* /usr/local/bin/ \
    && rm -rf /tmp/pear ~/.pearrc \
    && cd ../ && rm -rf php

#======================================================================================================
#======================================================================================================
#测试 -- 需要对话参数，所以自定义安装
RUN echo '编译安装swoole及其它扩展' \
    && set -ex \
	# swoole
#    && mkdir -p ~/build/swoole && cd ~/build/swoole \
#    && wget -O /tmp/swoole.tar.gz "https://github.com/swoole/swoole-src/archive/master.tar.gz" \
#    && tar zxvf /tmp/swoole.tar.gz --strip-components 1 \
    && apk add git \
    && git clone https://gitee.com/swoole/swoole.git && cd swoole \
    && apk del git \
    && /usr/local/php/bin/phpize && ./configure \
        --with-php-config=/usr/local/php/bin/php-config \
        --enable-openssl --enable-http2 --enable-swoole-curl --enable-swoole-json \
	\
    && make && make install && \
    cd ../ && rm -rf swoole \
	\
	\
	#inotify 2.+
    #&& \
    #mkdir -p ~/build/inotify && cd ~/build/inotify && \
    #tar -zxf /tmp/inotify.tgz --strip-components 1 && \
    #/usr/local/php/bin/phpize && \
    #./configure \
    #    --with-php-config=/usr/local/php/bin/php-config \
    #    --enable-inotify \
    #    && \
    #make && make install && \
    #cd .. && rm -rf inotify \
	#\
	#\
    #redis 5.+
    #&& \
    #mkdir -p ~/build/redis && cd ~/build/redis && \
    #tar -zxf /tmp/redis.tgz --strip-components 1 && \
    #/usr/local/php/bin/phpize && \
    #./configure \
    #    --with-php-config=/usr/local/php/bin/php-config \
    #    --enable-redis \
    #    && \
    #make && make install && \
    #cd .. && rm -rf redis \
	#\
	#\
    #uuid 1.0.4 (libuuid-1.0.3)
    && \
    mkdir -p ~/build/libuuid && cd ~/build/libuuid && \
    tar -zxf /tmp/libuuid.tgz --strip-components 1 && \
    ./configure --prefix=/usr && \
    make && make install && \
    cd ../ && rm -rf libuuid \
    #&& \
    #mkdir -p ~/build/uuid && cd ~/build/uuid && \
    #tar -zxf /tmp/uuid.tgz --strip-components 1 && \
    #/usr/local/php/bin/phpize && \
    #./configure --with-php-config=/usr/local/php/bin/php-config && \
    #make && make install && \
    #cd ../ && rm -rf uuid \
    #\
    #\
    #memcached 3.+ 需要libmemcached
    #&& \
    #apk add libmemcached-dev && \
    #mkdir -p ~/build/memcached_p && cd ~/build/memcached_p && \
    #tar -zxf /tmp/memcached.tgz --strip-components 1 && \
    #/usr/local/php/bin/phpize && \
    #./configure --with-php-config=/usr/local/php/bin/php-config && \
    #make && make install && \
    #cd ../ && rm -rf memcached_p \
    #\
    #\
    #event 2.+
    #&& \
    #mkdir -p ~/build/event && cd ~/build/event && \
    #tar -zxf /tmp/event.tgz --strip-components 1 && \
    #/usr/local/php/bin/phpize && \
    #./configure \
    #    --with-php-config=/usr/local/php/bin/php-config \
    #    --with-event-libevent-dir=/usr \
    #    && \
    #make && make install && \
    #cd ../ && rm -rf event \
    #\
    # imagick-3.+ 需要imagemagick
    #&& \
    #mkdir -p ~/build/imagemagick && cd ~/build/imagemagick && \
    #tar -zxf /tmp/imagemagick.tgz --strip-components 1 && \
    #./configure && \
    #make && make install && \
    #cd ../ && rm -rf imagemagick && \
    #\
    #mkdir -p ~/build/imagick && cd ~/build/imagick && \
    #tar -zxf /tmp/imagick.tgz --strip-components 1 && \
    #/usr/local/php/bin/phpize && \
    #./configure --with-php-config=/usr/local/php/bin/php-config && \
    #make && make install && \
    #cd ../ && rm -rf imagick \
    \
#======================================================================================================
    \
#======================================================================================================
    \
    && pecl channel-update pecl.php.net \
#    && pecl install igbinary amqp apcu protobuf redis uuid inotify event \
    && pecl install uuid igbinary event inotify apcu redis protobuf \
    #&& pecl install memcache memcached  \ 只占用内存移除
    && rm -rf /tmp/* ~/.pearrc ~/build \
    && apk del $PHPIZE_DEPS \
    && php -m

EXPOSE 9000
CMD ["php", "-a"]
# docker build -t cffycls/php .
