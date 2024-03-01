## 1. 主包

使用参考

[https://github.com/swoole/docker-swoole](https://github.com/swoole/docker-swoole)

[https://github.com/hyperf/hyperf-docker](https://github.com/hyperf/hyperf-docker)


推荐使用： `hyperf/hyperf:8.1-alpine-v3.18-swoole` `hyperf/hyperf:8.2-alpine-vedge-swoole` `hyperf/hyperf:8.3-alpine-vedge-swoole`

查看扩展 `docker run --rm -it hyperf/hyperf:8.2-alpine-vedge-swoole php -m`

```shell
tag format:

8.1: php version, support 8.1/8.2/8.3, Recommend 8.1
alpine: base images, supoort alpine/ubuntu, recommend alpine
v3.18: alpine version, support alpine 3.16/3.17/3.18/edge, recommend 3.18
swoole: support base/dev/swoole/swow
v5.1.2: swoole/swow version
```
```shell
#    配置获取
docker run --rm -it hyperf/hyperf:8.2-alpine-vedge-swoole php --ini
docker run --rm -it hyperf/hyperf:8.2-alpine-vedge-swoole cat /etc/php82/php.ini |grep curl
```
- 其它选项说明

```shell
    && apk add --no-cache ghostscript libgomp 
#    libgomp.so.1 是 GNU OpenMP（Open Multi-Processing）库的一部分，用于支持并行计算。
#    ghostscript 是imagick一个解析pdf依赖
#    curl的TLS证书下载
# php手动sll证书 https://curl.se/docs/caextract.html
#    composer安装
# https://developer.aliyun.com/composer
    && wget -O /usr/local/bin/composer "https://mirrors.aliyun.com/composer/composer.phar" \
    && composer config -g repo.packagist composer "https://mirrors.aliyun.com/composer/" \
    && composer -V
```

