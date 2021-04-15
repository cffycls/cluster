# V2Ray安装使用

参考：《 [2021最新V2Ray搭建图文教程，V2Ray一键搭建脚本！](https://www.itblogcn.com/article/406.html) 》

# 1.腾讯云-服务器部署

## a.购买域外服务器
如：香港云主机

## b.安装过程
```shell script
bash <(curl -s -L https://git.io/v2ray.sh)

v2ray url
```

## c.设置云主机防火墙
```shell script
# vmess 端口
iptables -I INPUT 5 -p tcp  --dport 60066 -j ACCEPT
# Shadowsocks 端口
iptables -I INPUT 5 -p tcp  --dport 31080 -j ACCEPT
```
并在腾讯云控制台添加相应端口。

# 2.客户端安装

## a. windows 平台 v2rayN

```shell script
下载v2ray core
下载地址：https://github.com/v2ray/v2ray-core/releases/latest

选择 v2ray-windows-64.zip 下载，如果你的系统是 32 位的那就选择 v2ray-windows-32.zip。
下载完成，解压。

下载 v2RayN
下载链接： https://github.com/2dust/v2rayN/releases/latest
然后选择 V2RayN.exe 下载
将下载完成后的 V2RayN.exe 复制到之前打开的 V2Ray 文件夹目录
```

## b. mac 平台 v2rayU

 [V2rayU.dmg](https://github-releases.githubusercontent.com/152742185/6ed49800-7af3-11eb-985d-66e462aae837?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20210414%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210414T031321Z&X-Amz-Expires=300&X-Amz-Signature=f22e41e8375aedadc758deab89714dc1581ae89819c98ea39198ffa78836fb46&X-Amz-SignedHeaders=host&actor_id=29082840&key_id=0&repo_id=152742185&response-content-disposition=attachment%3B%20filename%3DV2rayU.dmg&response-content-type=application%2Foctet-stream)

# 3.客户端使用

## a.导入配置链接并保存
```shell script
v2ray url
```
复制链接，从粘贴板导入。

保存，查看启动日志
```shell script
tail -f ~/.V2rayU/v2ray-core.log
```

## b.终端使用代理
软件中，选择->复制终端代理命令
```shell script
export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;
```
为当前终端使用代理
## c.浏览器使用代理
360极速版，直接使用系统代理
chrome浏览器，添加代理插件