# php7.3; 2021.07 link: https://github.com/docker-library/php/blob/master/7.3/alpine3.14/fpm/Dockerfile
# Base images 基础镜像+阿里源
FROM alpine:3.14

#MAINTAINER 维护者信息: +fileinfo
MAINTAINER cffycls@foxmail.com

# dependencies required for running "phpize" 2020.4.26组件更新
ENV PHP_VERSION=7.3.29 \
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
        --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data \
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
    && ln -s /usr/local/php/bin/* /usr/bin/ \
    && ln -s /usr/local/php/sbin/* /usr/sbin/ \
    && rm -rf /tmp/pear ~/.pearrc \
    && cd ../ && rm -rf php \
    && pecl channel-update pecl.php.net \
#    && pecl install igbinary amqp apcu protobuf redis uuid inotify event \
    && pecl install apcu redis xdebug \
    #&& pecl install memcache memcached  \ 只占用内存移除
    && rm -rf /tmp/* ~/.pearrc ~/build \
    && apk del $PHPIZE_DEPS \
    && php -m

RUN set -eux; \
    adduser -u 82 -D -S -G www-data www-data; \
	[ ! -d /var/www/html ]; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 777 /var/www/html; \
	cd /usr/local/php/etc; \
    	if [ -d php-fpm.d ]; then \
    		# for some reason, upstream's php-fpm.conf.default has "include=NONE/etc/php-fpm.d/*.conf"
    		sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
    		cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
    	else \
    		# PHP 5.x doesn't use "include=" by default, so we'll create our own simple config that mimics PHP 7+ for consistency
    		mkdir php-fpm.d; \
    		cp php-fpm.conf.default php-fpm.d/www.conf; \
    		{ \
    			echo '[global]'; \
    			echo 'include=etc/php-fpm.d/*.conf'; \
    		} | tee php-fpm.conf; \
    	fi; \
    	{ \
    		echo '[global]'; \
    		echo 'error_log = /proc/self/fd/2'; \
    		echo; echo '; https://github.com/docker-library/php/pull/725#issuecomment-443540114'; echo 'log_limit = 8192'; \
    		echo; \
    		echo '[www]'; \
    		echo '; if we send this to /proc/self/fd/1, it never appears'; \
    		echo 'access.log = /proc/self/fd/2'; \
    		echo; \
    		echo 'clear_env = no'; \
    		echo; \
    		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
    		echo 'catch_workers_output = yes'; \
    		echo 'decorate_workers_output = no'; \
    	} | tee php-fpm.d/docker.conf; \
    	{ \
    		echo '[global]'; \
    		echo 'daemonize = no'; \
    		echo; \
    		echo '[www]'; \
    		echo 'listen = 9000'; \
    	} | tee php-fpm.d/zz-docker.conf

EXPOSE 9000
CMD ["php-fpm",  "-c", "/usr/local/php/etc/php.ini", "-y", "/usr/local/php/etc/php-fpm.conf"]
# docker build -t cffycls/php73 .
# docker rm -f p73; docker run -itd --name p73 cffycls/php73
# docker-compose build
