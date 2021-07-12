#/bin/bash
# 1. pecl报错尝试uninstall，再装
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
&& pecl channel-update pecl.php.net \
&& pecl install igbinary \
&& pecl install amqp \
&& rm -rf /tmp/* ~/.pearrc ~/build \
&& php -m
