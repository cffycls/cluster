#!/bin/sh
#其他插件安装，可以下载源码编译，这里使用
apk add libuuid libmemcached libmemcached-dev && /usr/local/php/bin/pecl channel-update pecl.php.net \
    && /usr/local/php/bin/pecl install igbinary swoole event uuid inotify redis memcached \
    && rm -rf /tmp/pear ~/.pearrc \
    && /usr/local/php/bin/php -m
    