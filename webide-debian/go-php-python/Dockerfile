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
#ADD vscode-docker /tmp/vscode-docker

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
RUN echo '开始安装: python3.9 + pip包管理' \
    && set -ex \
    && mkdir -p /usr/local/python3 \
    && mkdir -p /tmp/bulid/python3 && cd /tmp/bulid/python3 && tar -zxvf /tmp/packages/Python-3.9.4.tgz --strip-components 1 \
    && ./configure --prefix=/usr/local/python3 --enable-optimizations \
    && make && make install \
    && ln -sf /usr/local/python3/bin/python3 /usr/bin/python && python -V \
    && ln -sf /usr/local/python3/bin/pip3 /usr/bin/pip && pip -V \
    && mkdir -p /home/coder/.pip && echo '\
[global] \n\
index-url = http://mirrors.aliyun.com/pypi/simple/ \n\
\n\
[install] \n\
trusted-host=mirrors.aliyun.com \n\
'> /home/coder/.pip/pip.conf

RUN echo '开始安装：pyenv' \
    && set -ex \
# https://github.com -> https://github.com.cnpmjs.org
    && rm -rf /home/coder/.pyenv && runuser -l coder /tmp/shell/pyenv-installer.sh \
    && echo 'export PATH="/home/coder/.pyenv/bin:$PATH"' >> $HOME/.bashrc \
    && echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && pyenv -v"

# 4. go
RUN echo '开始安装：go + g' \
    && set -ex \
    && mkdir -p /usr/local/go && cd /usr/local/go \
    && tar -zxvf /tmp/packages/go1.16.1.linux-amd64.tar.gz --strip-components 1 \
    && echo 'export GOROOT=$GOROOT' >> $HOME/.bashrc \
    && echo 'export PATH=$PATH:$GOROOT/bin' >> $HOME/.bashrc \
    \
#    && echo 'export GOPATH=$GOPATH' >> $HOME/.bashrc \
#    && echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && go version"

RUN echo '安装g' \
    && set -ex \
# https://github.com -> https://github.com.cnpmjs.org
    && /tmp/shell/g-install.sh \
    && mkdir -p ${HOME}/.g/go \
    && echo 'export GOROOT="${GOROOT}"' >> $HOME/.bashrc \
    && echo 'export PATH="${HOME}/.g/go/bin:$PATH"' >> $HOME/.bashrc \
    && echo 'export G_MIRROR=https://golang.google.cn/dl/' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && g -v"


## 5. php
RUN echo '开始安装：php + composer + swoole' \
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
        && make install \
    && echo 'export PATH=$PATH:/usr/local/php8/bin' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && php -v"

RUN echo '安装swoole及其他扩展' \
    && set -ex \
    && wget -O /tmp/packages/swoole.tar.gz "https://github.com/swoole/swoole-src/archive/master.tar.gz" \
    && mkdir -p /tmp/build/swoole && cd /tmp/build/swoole \
        && tar zxvf /tmp/packages/swoole.tar.gz --strip-components 1 \
        && /usr/local/php8/bin/phpize && \
            ./configure --with-php-config=/usr/local/php8/bin/php-config \
            --enable-openssl \
            --enable-http2  \
            --enable-sockets \
        && make && make install \
    && bash -i -c "\
    pecl channel-update pecl.php.net \
    && pecl install uuid igbinary event inotify apcu redis protobuf \
    "\
#     amqp安装报错，暂不支持
    \
#    [yasd] https://mp.weixin.qq.com/s/qw1nKd7hIPYiBqnewUE_gg
    && mkdir -p /tmp/build/yasd && cd /tmp/build/yasd \
        && git clone https://github.com/swoole/yasd.git \
        && cd yasd && phpize --clean && phpize && ./configure \
        && make clean && make && make install \
    && echo '\
zend_extension=yasd \n\
yasd.debug_mode=remote \n\
yasd.remote_host=127.0.0.1 \n\
yasd.remote_port=9000 \n\
' >> /usr/local/php8/etc/php.ini


RUN echo '安装composer' \
    && set -ex \
    && cp /tmp/shell/php.ini /usr/local/php8/etc/php.ini \
    && bash -i -c "php -m \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/php8/bin/composer && composer -V \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    "


# 结尾. 使用体验优化
RUN set -ex \
    && sudo apt-get install bash-completion \
    && echo '\
if [ -f /etc/bash_completion ]; then \n\
. /etc/bash_completion \n\
fi \n\
    '> /etc/bash.bashrc \
    && sudo apt-get clean && sudo apt-get autoclean && sudo apt-get autoremove
RUN set -ex \
    && sed -i "s/#alias ll='ls /alias ll='ls /" /root/.bashrc \
    && sed -i "s/#alias ll='ls /alias ll='ls /" $HOME/.bashrc \
    && mkdir /code \
    && mkdir -p $HOME/.vscode/User \
    && mkdir -p $HOME/.vscode-extensions \
    && echo 'ide添加插件包：' \
#    code-server --install-extension <extension id>
#    && cd $HOME/.vscode-extensions && tar zxf /tmp/vscode-docker/extensions.tar.gz --strip-components 1 \
#     VS Code 的中文（简体）语言包
    && code-server --install-extension ms-ceintl.vscode-language-pack-zh-hans \
#     vscode-icons
    && code-server --install-extension vscode-icons-team.vscode-icons \
#     Go for Visual Studio Code
    && code-server --install-extension golang.go \
#     Icon Fonts for Visual Studio Code
    && code-server --install-extension idleberg.icon-fonts \
#     Python extension for Visual Studio Code
    && code-server --install-extension ms-python.python \
#     PHP Debug Adapter for Visual Studio Code
    && code-server --install-extension felixfbecker.php-debug \
    && cp /tmp/vscode-docker/settings.json $HOME/.vscode/User/ \
    && rm -rf /tmp/* \
#    && echo '\
#auth: password \n\
#password: $PASSWORD # This is randomly generated for each config.yaml \n\
#cert: false \n\
#    '>~/.config/code-server/config.yaml \
    && chown -R coder:coder $HOME && chown -R coder:coder /code


# 启动配置
USER coder
WORKDIR /code
ENTRYPOINT ["code-server","--extensions-dir=/home/coder/.vscode-extensions","--auth=none","--bind-addr=0.0.0.0:8080","--user-data-dir=/home/coder/.vscode",">/home/coder/.vscode/runtime.log","2>&1","/code"]

# https://hub.docker.com/r/linuxserver/code-server
