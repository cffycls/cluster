#!/bin/sh
/usr/local/php/bin/pecl channel-update pecl.php.net

/uo yes | /usr/local/php/bin/pecl install igbinary swoole event uuid inotify redis memcached

