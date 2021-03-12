#!/bin/bash

# https://oinuvuzu.mirror.aliyuncs.com
# docker pull codercom/code-server:3.9.0

if [ ! -e "./apache-maven-3.6.3-bin.tar.gz" ]; then
    url='http://mirror.bit.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz'
    curl $url -O 
    if [ ! -e "./apache-maven-3.6.3-bin.tar.gz" ]; then
        echo '请使用迅雷下载文件:' $url
        exit
    fi
fi

echo '开始构建...'
docker-compose build

docker_login_aliyun(){
    USERNAME=oneserverless
    PASSWORD="xx"
    EMAIL=xx@qq.com
    # mac os
    /usr/bin/expect <<EOF
        set time 30
        spawn docker login --username=$USERNAME registry.cn-hangzhou.aliyuncs.com
        expect {
            "*Password:" { send "$PASSWORD\r" }
        }
        expect eof
EOF
}


# docker_login_aliyun
# docker rm -f n3 && docker run --name n3 -p 8095:8080 -v $PWD:/code -itd node-java-python-for-one
# docker rm -f n3 && docker run --name n3 -p 8095:8080 -v ～/workdir:/code -itd node-java-python-for-one

