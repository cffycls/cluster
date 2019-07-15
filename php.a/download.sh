#!/bin/bash

wget -O packages/php.tar.xz "https://secure.php.net/get/php-7.3.7.tar.xz/from/this/mirror" && \
	wget -O packages/swoole.tar.gz "https://github.com/swoole/swoole-src/archive/master.tar.gz" && \
	wget -O packages/inotify.tgz "https://pecl.php.net/get/inotify-2.0.0.tgz" && \
	wget -O packages/redis.tgz "https://pecl.php.net/get/redis-5.0.0.tgz" && \
	wget -O packages/libuuid.tgz "http://nchc.dl.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz" && \
	wget -O packages/uuid.tgz "http://pecl.php.net/get/uuid-1.0.4.tgz" && \
	wget -O packages/memcached.tgz "https://pecl.php.net/get/memcached-3.1.3.tgz" && \
	wget -O packages/event.tgz "http://pecl.php.net/get/event-2.5.3.tgz"
