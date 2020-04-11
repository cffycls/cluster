#!/bin/sh
# ;extension=imagick去掉了 2020.04.11

#/usr/local/php/etc/swoole-tracker/deploy_env.sh http://www.swoole-cloud.com:29666 浏览器
# 自动运行下面的： &后台运挂起行必须，继续执行
php /var/www/html/hyperf/bin/hyperf.php start &
/opt/swoole/entrypoint.sh