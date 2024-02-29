# https://hub.docker.com/r/codercom/code-server/tags?page=1&ordering=last_updated
FROM codercom/code-server

# 基础OS版本Debian GNU/Linux 10 (buster)
# dockerfile 强制使用bash
USER root
RUN chsh -s /bin/bash \
    && echo '\
deb http://mirrors.aliyun.com/debian/ buster main non-free contrib \n\
deb http://mirrors.aliyun.com/debian-security buster/updates main \n\
deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib \n\
deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib \n\
\n\
deb-src http://mirrors.aliyun.com/debian-security buster/updates main \n\
deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib \n\
deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib \n\
deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib \n\
'> /etc/apt/sources.list \
#    && echo '140.82.114.4 github.com \n' >> /etc/hosts \
#    && echo '185.199.108.133 raw.githubusercontent.com \n' >> /etc/hosts \
    && apt-get update

# 开始安装：pyenv + python3.9
ENV PASSWORD=123456 \
    HOME='/home/coder' \
    GOROOT='/usr/local/go'


ADD packages /tmp/packages
ADD shell /tmp/shell

RUN echo '开始安装基础软件包' \
    && set -ex \
    && apt-get install -y tree wget curl vim git gcc make cmake autoconf

RUN echo '**开始安装其它依赖' \
    && set -ex \
# python3依赖 zlib找不到，手动安装
    && mkdir -p /tmp/bulid/zlib && cd /tmp/bulid/zlib \
    && wget 'https://nchc.dl.sourceforge.net/project/libpng/zlib/1.2.11/zlib-1.2.11.tar.gz' \
    && tar -xvzf zlib-1.2.11.tar.gz --strip-components 1 \
    && ./configure && make -j2 && make install \
    && apt-get install -y zlib1g-dev libreadline-dev tk-dev libgdbm-dev libpcap-dev \
## php依赖 oniguruma->libonig-dev https://www.cnblogs.com/taoshihan/p/13196036.html
   libsqlite3-dev libcurl4-openssl-dev libonig-dev \
   libedit-dev libxml2-dev libgd-dev libfreetype6-dev libevent-dev librabbitmq-dev libpcre2-dev \
#   安装 yasd 在编译安装之前你需要安装boost库
   libboost-all-dev


# 1. 安装 python
RUN echo '1.开始安装：pyenv + python3.9' \
    && PYTHON_VERSION='3.9.3' \
    && set -ex \
    && rm -rf /home/coder/.pyenv && runuser -l coder /tmp/shell/pyenv-installer.sh \
    && chown coder:coder -R $HOME/.pyenv \
#    && wget "https://npm.taobao.org/mirrors/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz" -P ~/.pyenv/cache \
#    && runuser -l coder $HOME/.pyenv/bin/pyenv install $PYTHON_VERSION \
    && mkdir -p $HOME/.pip && echo '\
[global] \n\
index-url = http://mirrors.aliyun.com/pypi/simple/ \n\
\n\
[install] \n\
trusted-host=mirrors.aliyun.com \n\
'> $HOME/.pip/pip.conf \
    && chown coder:coder -R $HOME/.pip

# 2. go
RUN echo '2.开始安装：g + go' \
    && set -ex \
    && /tmp/shell/g-install.sh


## 3. php
RUN echo '3.开始安装：php' \
    && set -ex \
    && mkdir -p /usr/local/php8 \
    && mkdir -p /tmp/bulid/php8 && cd /tmp/bulid/php8 \
    && tar -zxvf /tmp/packages/php-8.0.3.tar.gz --strip-components 1 \
    && ./configure --prefix="/usr/local/php8" \
            --with-config-file-path="/usr/local/php8/etc" \
            --with-config-file-scan-dir="/usr/local/php8/etc/conf.d" \
            --enable-mbstring \
            --enable-mbregex \
            --enable-mysqlnd \
            --with-mysqli \
            --with-pdo-mysql \
            --enable-sysvmsg \
            --enable-ftp \
            --enable-exif \
            --enable-pcntl \
            --enable-sockets \
            --enable-sysvsem \
            --enable-xml \
            --enable-bcmath \
            --with-openssl \
            --with-curl \
            --with-libedit \
            --with-zlib \
            --with-pcre-jit \
            --with-pear \
            --with-libxml \
            --enable-gd \
            --with-jpeg \
            --with-xpm \
            --with-freetype \
            --with-gettext \
            --with-iconv \
            --disable-cgi \
        && make -j "$(nproc)" \
        && find -type f -name '*.a' -delete \
        && make install

RUN echo '3.1安装swoole及其他扩展' \
    && set -ex \
    && wget -O /tmp/packages/swoole.tar.gz "https://github.com/swoole/swoole-src/archive/master.tar.gz" \
    && mkdir -p /tmp/bulid/swoole && cd /tmp/bulid/swoole \
    && tar zxvf /tmp/packages/swoole.tar.gz --strip-components 1 \
    && /usr/local/php8/bin/phpize \
        && ./configure --with-php-config=/usr/local/php8/bin/php-config \
        --enable-openssl \
        --enable-mysqlnd \
        --enable-http2  \
        --enable-sockets --enable-swoole-curl --enable-swoole-json \
    && make && make install \
    && /usr/local/php8/bin/pecl channel-update pecl.php.net \
    && /usr/local/php8/bin/pecl install uuid igbinary event inotify apcu redis protobuf

#     amqp安装报错，暂不支持
RUN echo '3.2安装php调试yasd' \
    && set -ex \
#    [yasd] https://mp.weixin.qq.com/s/qw1nKd7hIPYiBqnewUE_gg
    && apt-get install -y gnutls-bin \
    && cd /tmp/bulid/ \
#       https://github.com/swoole/yasd.git
        && git clone https://gitee.com/jimmylau/yasd.git  && cd yasd \
        && /usr/local/php8/bin/phpize --clean && /usr/local/php8/bin/phpize \
        && ./configure --with-php-config=/usr/local/php8/bin/php-config \
        && make clean && make && make install \
    && echo '\
zend_extension=yasd \n\
yasd.debug_mode=remote \n\
yasd.remote_host=127.0.0.1 \n\
yasd.remote_port=9000 \n\
' >> /usr/local/php8/etc/php.ini \
    \
    && echo '安装composer' \
    && set -ex \
    && cp /tmp/shell/php.ini /usr/local/php8/etc/php.ini \
    # 脚本内部使用 php命令
    && ln -sf /usr/local/php8/bin/php /usr/bin/php \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/php8/bin/composer \
    && /usr/local/php8/bin/composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/


# 4.结尾. 使用体验优化
ADD vscode-docker /tmp/vscode-docker
RUN set -ex \
    && echo '4.使用体验优化：' \
    && apt-get install -y bash-completion expect \
    && echo '\
if [ -f /etc/bash_completion ]; then \n\
. /etc/bash_completion \n\
fi \n\
    '> /etc/bash.bashrc \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && sed -i "s/#alias ll='ls /alias ll='ls /" /root/.bashrc \
    && sed -i "s/#alias ll='ls /alias ll='ls /" $HOME/.bashrc \
    && mkdir /code \
    && chown -R coder:coder /code \
    \
    && echo '编辑器处理，ide添加插件包：' \
    && mkdir -p $HOME/.vscode/User \
    && echo '\
{ \n\
    "workbench.colorTheme": "Default Dark+", \n\
    "workbench.iconTheme": "vscode-icons" \n\
}' > $HOME/.vscode/User/settings.json \
    && mkdir -p $HOME/.vscode-extensions \
    && cd $HOME/.vscode-extensions && tar -zxf /tmp/vscode-docker/vscode-extensions.tar.gz --strip-components 1 \
# GitHub登陆脚本
    && cp /tmp/shell/cmd_setup_github.sh $HOME \
    && echo "$HOME/cmd_setup_github.sh 登陆脚本添加成功" \
#    && echo '\
#auth: password \n\
#password: $PASSWORD # This is randomly generated for each config.yaml \n\
#cert: false \n\
#    '>~/.config/code-server/config.yaml \
    && chown -R coder:coder $HOME

RUN set -ex \
    && echo '5.全局变量设置：' \
    && echo '\n\n# =============================' >> /etc/profile \
    && echo '# ===== 全局变量设置 =====' >> /etc/profile \
    && echo '# =============================' >> /etc/profile \
    \
    && echo '# ===== pyenv 环境变量设置 =====\n' >> /etc/profile \
    && echo 'export PATH="$PATH:/home/coder/.pyenv/bin"' >> /etc/profile \
    && echo 'eval "$(pyenv init -)"' >> /etc/profile \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> /etc/profile \
    && bash -i -c "source /etc/profile" && /home/coder/.pyenv/bin/pyenv -v \
    \
    && echo '\n# ===== php 环境变量设置 =====' >> /etc/profile \
    && echo 'export PATH="$PATH:/usr/local/php8/bin"' >> /etc/profile \
    && bash -i -c "source /etc/profile" && php -v && /usr/local/php8/bin/composer -V && php --ini \
    \
    && echo '\n\n# ===== go 环境变量设置（沿用g配置） =====' >> /etc/profile \
    && echo 'export G_MIRROR="https://golang.google.cn/dl/"' >> /etc/profile \
    && echo "export GOROOT=${HOME}/.g/go" >> /etc/profile \
    && echo "export GOBIN=$GOROOT/bin" >> /etc/profile \
    && echo "export GOPATH=$HOME/.go" >> /etc/profile \
    && echo "export GO111MODULE=on" >> /etc/profile \
    && echo "export GOPROXY=https://mirrors.aliyun.com/goproxy" >> /etc/profile \
    && echo 'export PATH="${HOME}/bin:${HOME}/.g/go/bin:$PATH"' >> /etc/profile \
    && bash -i -c "source /etc/profile" && $HOME/bin/g -v \
    && rm -rf /tmp/* \
    && chown coder:coder -R $HOME

# 启动配置
USER coder
WORKDIR /code
ENTRYPOINT ["code-server","--extensions-dir=/home/coder/.vscode-extensions","--auth=none","--bind-addr=0.0.0.0:8080","--user-data-dir=/home/coder/.vscode",">/home/coder/.vscode/runtime.log","2>&1","/code"]

# https://hub.docker.com/r/linuxserver/code-server
# docker build -t cffycls/webide-debian:go-php-python-v1.2 .

