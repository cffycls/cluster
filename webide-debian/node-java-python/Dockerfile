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
ENV HOME='/home/coder' \
    PASSWORD='123456' \
    JAVA_HOME='/usr/local/jdk16' \
    MAVEN_HOME='/usr/share/apache-maven-3.6.3' \
# PATH 不可加引号，解析不正常--注意
    PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH \
    NODEJS_VERSION=15 \
    NVM_NODEJS_ORG_MIRROR='https://npm.taobao.org/mirrors/node' \
    GOROOT='/usr/local/go' \
    GOPATH='/usr/local/gopath'

ADD packages /tmp/packages
ADD shell /tmp/shell
ADD maven /tmp/maven
ADD vscode-docker /tmp/vscode-docker

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
    && apt-get install -y zlib1g-dev libreadline-dev tk-dev libgdbm-dev libpcap-dev

# 1. 安装 python
RUN echo '开始安装: python3.9 + pip包管理' \
    && set -ex \
    && mkdir -p /usr/local/python3 \
    && mkdir -p /tmp/bulid/python3 && cd /tmp/bulid/python3 && tar -zxvf /tmp/packages/Python-3.9.4.tgz --strip-components 1 \
    && ./configure --prefix=/usr/local/python3 --enable-shared --enable-optimizations \
    && make -j2 && make install \
    && ln -sf /usr/local/python3/lib/libpython3.9.so.1.0 /usr/lib/ \
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
    && rm -rf $HOME/.pyenv && chown -R coder:coder $HOME \
    && runuser -l coder /tmp/shell/pyenv-installer.sh \
    && echo 'export PATH="/home/coder/.pyenv/bin:$PATH"' >> $HOME/.bashrc \
    && echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && pyenv -v"


# 2. java + maven项目管理
# 配置java镜像源加速下载配置（使用阿里云的镜像源）'
# maven安装最新版本3.6.3（版本太低会导致vscode插件无法正常编译调试）
RUN echo '开始安装：java-16 + maven项目管理' \
    && echo "环境变量路径：$HOME/.bashrc" \
    && set -ex \
    && mkdir -p /usr/local/jdk16 && cd /usr/local/jdk16 \
    && tar -zxvf /tmp/packages/jdk-16_linux-x64_bin.tar.gz --strip-components 1 \
    && echo 'export JAVA_HOME=/usr/local/jdk16' >> $HOME/.bashrc \
    && echo 'export CLASSPATH=.:$JAVA_HOME/lib' >> $HOME/.bashrc \
    && echo 'export export PATH=$PATH:$JAVA_HOME/bin' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && java --version" \
    && echo '开始安装maven...' \
    && mkdir -p /usr/local/apache-maven && cd /usr/local/apache-maven \
    && tar -zxvf /tmp/packages/apache-maven-3.6.3-bin.tar.gz --strip-components 1 \
    && echo 'export MAVEN_HOME=/usr/local/apache-maven' >> $HOME/.bashrc \
    && echo 'export PATH=${PATH}:${MAVEN_HOME}/bin' >> $HOME/.bashrc \
    && bash -i -c "source $HOME/.bashrc && mvn --version" \
    && mkdir -p /home/coder/.m2/repository && chown -R coder:coder $HOME/.m2 \
    && cp /tmp/maven/settings.xml /home/coder/.m2/settings.xml


# 3. nvm + nodejs
# 配置vscode的工程配置（常用配置和常用插件安装）
# 如何在Dockerfile中安装nvm？ http://www.cocoachina.com/articles/61387 nvm找不到命令
RUN echo 'nvm安装并设置源' \
    && set -x \
    && mkdir $HOME/.nvm && chown -R coder:coder $HOME/.nvm \
    && runuser -l coder /tmp/shell/nvm-install.sh \
    && echo '安装nodejs' \
    && set -ex \
    && bash -i -c "\
    nvm install ${NODEJS_VERSION} && node -v \
    && nvm alias default ${NODEJS_VERSION} \
    && npm install -g cnpm --registry='https://registry.npm.taobao.org' \
    && npm install -g yarn \
    "

RUN set -ex \
    && sudo apt-get install bash-completion \
    && echo '\
if [ -f /etc/bash_completion ]; then \n\
. /etc/bash_completion \n\
fi \n\
    '> /etc/bash.bashrc \
    && sudo apt-get clean && sudo apt-get autoclean && sudo apt-get autoremove

# 结尾. 使用体验优化
RUN set -ex && chown coder:coder -R $HOME \
    && sed -i "s/#alias ll='ls /alias ll='ls /" /root/.bashrc \
    && sed -i "s/#alias ll='ls /alias ll='ls /" $HOME/.bashrc

RUN set -ex \
# RUN bash -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    && mkdir /code \
    && mkdir -p $HOME/.vscode/User \
    && mkdir -p $HOME/.vscode-extensions \
    && echo 'ide添加插件包：' \
    && cd $HOME/.vscode-extensions && tar zxf /tmp/vscode-docker/extensions.tar.gz --strip-components 1 \
    && cp /tmp/vscode-docker/settings.json $HOME/.vscode/User/ \
    && rm -rf /tmp/* \
    && chown -R coder:coder $HOME && chown -R coder:coder /code


# 启动配置
USER coder
WORKDIR /code
ENTRYPOINT ["code-server","--extensions-dir=/home/coder/.vscode-extensions","--auth=none","--bind-addr=0.0.0.0:8080","--user-data-dir=/home/coder/.vscode",">/home/coder/.vscode/runtime.log","2>&1","/code"]

# https://hub.docker.com/r/linuxserver/code-server
