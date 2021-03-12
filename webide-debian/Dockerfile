FROM codercom/code-server:3.9.1

# 基础OS版本Debian GNU/Linux 10 (buster)
# dockerfile 强制使用bash
USER root
ADD packages /tmp/packages
ADD shell /tmp/shell

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
    && echo '140.82.114.4 github.com \n' >> /etc/hosts \
    && echo '185.199.108.133 raw.githubusercontent.com \n' >> /etc/hosts \
    && apt-get update


# 开始安装：pyenv + python3.9
ENV PASSWORD=123456\
    JAVA_HOME='/usr/local/jdk15' \
    MAVEN_HOME='/usr/share/apache-maven-3.6.3' \
# PATH 不可加引号，解析不正常--注意
    PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH \
    HOME='/home/coder' \
    NODEJS_VERSION=15 \
    NVM_NODEJS_ORG_MIRROR='https://npm.taobao.org/mirrors/node' \
    GOROOT='/usr/local/go' \
    GOPATH='/usr/local/gopath'

RUN echo '开始安装基础软件包' \
    && set -ex \
    && apt-get install -y tree wget gcc make cmake curl vim git autoconf \
    \
# python3依赖
    zlib1g-dev libreadline-dev tk-dev libgdbm-dev libpcap-dev \
## php依赖 oniguruma->libonig-dev https://www.cnblogs.com/taoshihan/p/13196036.html
    libsqlite3-dev libcurl4-openssl-dev libonig-dev \
    libedit-dev libxml2-dev libgd-dev libfreetype6-dev libevent-dev librabbitmq-dev libpcre2-dev



# 1. 安装 python
RUN echo '开始安装: python3.9 + pip包管理' \
    && set -ex \
    && mkdir -p /usr/local/python3 \
    && mkdir -p /tmp/bulid/python3 && cd /tmp/bulid/python3 && tar -zxvf /tmp/packages/Python-3.9.2.tgz --strip-components 1 \
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


# 2. java + maven项目管理
# 配置java镜像源加速下载配置（使用阿里云的镜像源）'
# maven安装最新版本3.6.3（版本太低会导致vscode插件无法正常编译调试）
RUN echo '开始安装：java-15 + maven项目管理' \
    && set -ex \
    && mkdir -p /usr/local/jdk15 && cd /usr/local/jdk15 \
    && tar -zxvf /tmp/packages/jdk-15.0.2_linux-x64_bin.tar.gz --strip-components 1 \
    && echo 'export JAVA_HOME=/usr/local/jdk15' >> $HOME/.bashrc \
    && echo 'export CLASSPATH=.:$JAVA_HOME/lib' >> $HOME/.bashrc \
    && echo 'export export PATH=$PATH:$JAVA_HOME/bin' >> $HOME/.bashrc \
    && echo 'maven...' \
    && mkdir -p /usr/local/apache-maven && cd /usr/local/apache-maven \
    && tar -zxvf /tmp/packages/apache-maven-3.6.3-bin.tar.gz --strip-components 1 \
    && echo 'export MAVEN_HOME=/usr/local/apache-maven' >> $HOME/.bashrc \
    && echo 'export PATH=${PATH}:${MAVEN_HOME}/bin' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc" \
    && mkdir -p /home/coder/.m2/repository && chmod -R 0777 /home/coder/.m2
COPY maven/settings.xml /home/coder/.m2/settings.xml


# 3. nvm + nodejs
# 配置vscode的工程配置（常用配置和常用插件安装，确保java的开发体验与本地桌面开发体验类似）
# 如何在Dockerfile中安装nvm？ http://www.cocoachina.com/articles/61387 nvm找不到命令
RUN mkdir $HOME/.nvm && /tmp/shell/nvm-install.sh && chmod +x $HOME/.nvm/nvm.sh
RUN echo 'nvm安装并设置源' \
    && set -ex \
    && bash -i -c "\
    nvm install ${NODEJS_VERSION} && node -v \
    && nvm alias default ${NODEJS_VERSION} \
    && npm install -g cnpm --registry='https://registry.npm.taobao.org' \
    && npm install -g yarn \
    "

# 4. go
RUN echo '开始安装：go + g' \
    && set -ex \
    && mkdir -p /usr/local/go && cd /usr/local/go \
    && tar -zxvf /tmp/packages/go1.16.1.linux-amd64.tar.gz --strip-components 1 \
    && echo 'export GOROOT=$GOROOT' >> $HOME/.bashrc \
    && echo 'export PATH=$PATH:$GOROOT/bin' >> $HOME/.bashrc \
    \
    && echo 'export GOPATH=$GOPATH' >> $HOME/.bashrc \
    && echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && go version"

RUN echo '安装g' \
    && set -ex \
# https://github.com -> https://github.com.cnpmjs.org
    && /tmp/shell/g-install.sh \
    && echo 'export GOROOT="${HOME}/.g/go"' >> $HOME/.bashrc \
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

RUN echo '安装composer，swoole及其他扩展' \
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
    && bash -i -c "pecl install uuid igbinary event inotify apcu" \
    && cp /tmp/shell/php.ini /usr/local/php8/etc/php.ini \
    && bash -i -c "php -m \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/php8/bin/composer && composer -V \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/'\
    "



# 结尾. 使用体验优化
RUN set -ex && chown coder:coder -R $HOME \
    && sudo sed -i "s/#alias ll='ls -l'/alias ll='ls -l'/" /root/.bashrc

USER coder
COPY vscode-docker /tmp/vscode-docker
RUN bash -i -c "java --version \
    && python -V && pip -V && pyenv -v \
    && node -v \
    && go version && g version \
    && php -v && php -m && php --ri swoole" \
    \
    && set -ex \
    && sudo sed -i "s/#alias ll='ls -l'/alias ll='ls -l'/" $HOME/.bashrc \
    \
#     && sudo apt-get install -y zsh && sudo chsh -s /usr/bin/zsh && /usr/bin/zsh --version
# RUN bash -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    && sudo mkdir /code \
    && mkdir -p $HOME/.vscode/User \
    && mkdir -p $HOME/.vscode-extensions \
    && echo 'ide添加插件包：' \
    && cd $HOME/.vscode-extensions && tar zxf /tmp/vscode-docker/extensions.tar.gz --strip-components 1 \
    && cp /tmp/vscode-docker/settings.json $HOME/.vscode/User/ \
    && rm -rf /tmp/*

# 启动配置
WORKDIR /code
ENTRYPOINT ["code-server","--extensions-dir=/home/coder/.vscode-extensions","--auth=none","--bind-addr=0.0.0.0:8080","--user-data-dir=/home/coder/.vscode",">/home/coder/.vscode/runtime.log","2>&1","/code"]

# https://hub.docker.com/r/linuxserver/code-server
