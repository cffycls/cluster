# php8.03; 2021.04 link: https://github.com/docker-library/php/blob/master/8.0/alpine3.14/cli/Dockerfile
# php8.3; 2024.03 link: https://github.com/swoole/docker-swoole/blob/master/dockerfiles/5.1.2/php8.3/alpine/Dockerfile
# Base images 基础镜像hyperf/hyperf+阿里源
FROM hyperf/hyperf:8.2-alpine-vedge-swoole

#MAINTAINER 维护者信息: +fileinfo
MAINTAINER cffycls@foxmail.com

RUN echo '安装环境依赖' \
    && set -ex \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update

RUN echo '编译安装imagick扩展' \
    && set -ex \
    && apk add --no-cache ghostscript libgomp \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS wget \
    && pecl channel-update pecl.php.net \
    \
    && wget -O /usr/lib/php82/cacert.pem "https://curl.se/ca/cacert.pem" \
    && sed -i 's/;curl.cainfo =/curl.cainfo = \/usr\/lib\/php82\/cacert.pem/' /etc/php82/php.ini \
    \
    && wget -O /tmp/imagemagick.tgz "https://www.imagemagick.org/download/ImageMagick.tar.gz" \
        && mkdir -p ~/build/imagemagick && cd ~/build/imagemagick \
        && tar -zxf /tmp/imagemagick.tgz --strip-components 1 \
        && ./configure && make && make install \
    \
    && pecl install imagick \
    && echo "extension=imagick.so" > /etc/php82/conf.d/imagick.ini \
    \
#======================================================================================================
    \
#    && pecl install igbinary amqp apcu protobuf redis uuid inotify event \
#    && pecl install apcu \
    && rm -rf /tmp/* ~/.pearrc ~/build \
    && apk del .build-deps $PHPIZE_DEPS wget \
    && php -m

EXPOSE 9000
CMD ["php", "-a"]
# docker build -t cffycls/phpswoole:imagick .
# docker run --rm -it cffycls/phpswoole:imagick php --ri imagick
