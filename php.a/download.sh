#!/bin/bash
#2020.5.21

wget -O packages/php.tar.xz "https://www.php.net/distributions/php-8.0.8.tar.xz" && \
    # wget -O packages/inotify.tgz "https://pecl.php.net/get/inotify-2.0.0.tgz" && \
    # wget -O packages/redis.tgz "https://pecl.php.net/get/redis-5.2.1.tgz" && \
    wget -O packages/libuuid.tgz "http://nchc.dl.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz" #&& \
    # wget -O packages/uuid.tgz "http://pecl.php.net/get/uuid-1.1.0.tgz" && \
    # wget -O packages/memcached.tgz "https://pecl.php.net/get/memcached-3.1.5.tgz" && \
    # wget -O packages/event.tgz "http://pecl.php.net/get/event-2.5.4.tgz"
    # wget -O packages/pthreads.zip "https://codeload.github.com/krakjoe/pthreads/zip/master" && \
#     wget -O imagemagick.tgz "https://www.imagemagick.org/download/ImageMagick.tar.gz" && \
#     wget -O imagick.tgz "https://pecl.php.net/get/imagick-3.5.1.tgz"


# macOS
wget -O imagemagick.tgz "https://www.imagemagick.org/download/ImageMagick.tar.gz" && \
wget -O imagick.tgz "https://pecl.php.net/get/imagick-3.5.1.tgz" && \
mkdir -p build/imagemagick && cd build/imagemagick && \
tar -zxf ../../imagemagick.tgz --strip-components 1 && \
./configure && \
make && make install && \
cd ../ && rm -rf imagemagick && \
\
mkdir -p build/imagick && cd build/imagick && \
tar -zxf ../../imagick.tgz --strip-components 1 && \
/usr/local/php/bin/phpize && \
./configure --with-php-config=/usr/local/php/bin/php-config && \
make && make install && \
cd ../ && rm -rf imagick \