#!/bin/bash

# github的mac客户端开发环境安装配置脚本（解决繁琐的github客户端手动配置问题）

# curl https://bxjs.github.io/cmd_setup_mac_github.sh | sh -s -- -u 老储 -m 2903710916@qq.com
# 更新github的ssh的本地配置密钥，-u更改为自己的昵称，-m更改为自己的github注册邮箱。

# TODO 使用注意事项（改进实现文件名全部小写，自动转换为驼峰类的定义方式，规避文件名的大小写问题）
# git mv app/src/service/network.ts app/src/service/Network.ts
# -------------------
# git 改文件名大小写无法手动更改，需要用这个命令修改，git才能进行版本管理

#用法提示
usage() {
    echo "Usage:"
    echo "  cmd_setup_github.sh -u USERNAME -m USERMAIL"
    echo "Description:"
    echo "    USERNAME, 用户昵称（填写团队中的花名或姓名），例如填写花名：老储"
    echo "    USERMAIL, GITHUB账号注册的邮箱，建议使用QQ邮箱，例如填写：2903710916@qq.com"
    exit -1
}

# 获取脚本执行时的选项
while getopts "u:m:" option
do
    case "${option}"  in
        u)
            USERNAME=${OPTARG}
        ;;
        m)
            USERMAIL=${OPTARG}
        ;;
        ?)
            usage
        ;;
    esac
done

echo "INPUT USERNAME=$USERNAME"
echo "INPUT USERMAIL=$USERMAIL"
if [ "$USERNAME" == "" ] || [ "$USERMAIL" == "" ]; then
    usage
fi

## 全局依赖包安装
if [ ! -e `which yarn` ]; then
    npm install -g yarn@^1.0.0 --registry=https://registry.npm.taobao.org
fi

## GIT全局配置初始化
git config --global user.name   $USERNAME
git config --global user.email  $USERMAIL

generate_ssh_key(){
    /usr/bin/expect <<EOF
        set time 30
        spawn ssh-keygen -t rsa -C "$USERMAIL"
        expect {
            "Enter file*" { send "$HOME/.ssh/github\r"; exp_continue }
            "Enter passphrase*:" { send "\r"; exp_continue }
            "Enter same*:" { send "\r" }
        }
        expect eof
EOF
}

## GITHUB仓库的密钥生成以及半自动配置
config_github_ssh_key(){
    mkdir -p $HOME/.ssh
    cd $HOME/.ssh
    rm -rf ./known_hosts
    touch ./config
    rm -f ./github ./github.pub
    generate_ssh_key
    # 删除已经存在的GITHUB历史配置项
    sed -i "" "/^#[ ]*github.*/d" ./config
    sed -i "" "/^Host[ ]*github.com.*/,/^IdentityFile.*/d" ./config
    sed -i "" "/^Host[ ]*hub.fastgit.org.*/,/^IdentityFile.*/d" ./config
    # cat $HOME/.ssh/config
    # 将密钥写入到配置文件中增加一个配置项（支持两个默认的GITHUB代理配置）
    echo "# github proxy" >> ./config
    echo "Host hub.fastgit.org" >> ./config
    echo "User $USERMAIL" >> ./config
    echo "PreferredAuthentications publickey" >> ./config
    echo "IdentityFile $HOME/.ssh/github" >> ./config

    echo "# github proxy" >> ./config
    echo "Host github.com.cnpmjs.org" >> ./config
    echo "User $USERMAIL" >> ./config
    echo "PreferredAuthentications publickey" >> ./config
    echo "IdentityFile $HOME/.ssh/github" >> ./config

    echo "# github" >> ./config
    echo "Host github.com" >> ./config
    echo "User $USERMAIL" >> ./config
    echo "PreferredAuthentications publickey" >> ./config
    echo "IdentityFile $HOME/.ssh/github" >> ./config
    # 更改ssh目录的访问权限
    chmod 0700 ../.ssh
    chmod 0644 ./config
    # 服务器提前验证（兼容一下以前用过的老的GIT仓库后续全部废弃掉统一使用GITHUB）
    ssh-keyscan -t rsa github.com > $HOME/.ssh/known_hosts
    ssh-keyscan -t rsa code.aliyun.com >> $HOME/.ssh/known_hosts
    ssh-keyscan -t rsa gitee.com >> $HOME/.ssh/known_hosts
    echo '======================================='
    echo '======copy public key to github========'
    echo '======================================='
    cat ./github.pub
    echo '======================================='
    # 打开github的密钥
    echo "访问GITHUB公钥配置地址，手动拷贝上面的公钥内容并确认添加即可。"
    echo "https://github.com/settings/ssh/new"
    sleep 3
    open https://github.com/settings/ssh/new
}
config_github_ssh_key

