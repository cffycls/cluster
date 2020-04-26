#!/bin/bash
#2020.4.1

wget -O packages/php.tar.xz "https://secure.php.net/get/php-7.4.5.tar.xz/from/this/mirror" && \
	wget -O packages/swoole.tar.gz "https://github.com/swoole/swoole-src/archive/master.tar.gz" && \
	wget -O packages/inotify.tgz "https://pecl.php.net/get/inotify-2.0.0.tgz" && \
	wget -O packages/redis.tgz "https://pecl.php.net/get/redis-5.2.1.tgz" && \
	wget -O packages/libuuid.tgz "http://nchc.dl.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz" && \
	wget -O packages/uuid.tgz "http://pecl.php.net/get/uuid-1.1.0.tgz" && \
	wget -O packages/memcached.tgz "https://pecl.php.net/get/memcached-3.1.5.tgz" && \
	wget -O packages/event.tgz "http://pecl.php.net/get/event-2.5.4.tgz"
	wget -O packages/pthreads.zip "https://codeload.github.com/krakjoe/pthreads/zip/master" && \
	wget -O imagemagick.tgz "https://www.imagemagick.org/download/ImageMagick.tar.gz" && \
	wget -O imagick.tgz "https://pecl.php.net/get/imagick-3.4.4.tgz" 
