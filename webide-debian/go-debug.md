# go语言vs-code调试

# 1.调试工具安装
### vs-code官方相关文档 
[https://code.visualstudio.com/docs/languages/go#_debugging](https://code.visualstudio.com/docs/languages/go#_debugging)

- [go-delve文档](https://github.com/go-delve/delve/blob/master/Documentation/installation/README.md)

克隆git仓库并构建：
```shell script
git clone https://github.com/go-delve/delve
cd delve
go install github.com/go-delve/delve/cmd/dlv
```

在Go版本1.16或更高版本上，此命令也将起作用：
```shell script
go install github.com/go-delve/delve/cmd/dlv@latest
```
- 初始化 init.sh
```shell script
#!/bin/bash

mkdir -p $HOME/.go
export GOROOT=/usr/local/go
export GOBIN=$GOROOT/bin
export GOPATH=$HOME/.go
export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/

sudo chown coder:coder -R /usr/local/go
go install github.com/go-delve/delve/cmd/dlv@latest
```

# 2.环境准备GOPATH
```shell script
docker rm -f g3; docker run -itd --name g3 -v ~/workdir/coder-server/code:/code -p 8080:8080 cffycls/webide-debian:go-php-python-v1.2

echo '\
export GOROOT=/usr/local/go
export GOBIN=$GOROOT/bin
export GOPATH=$HOME/.go
export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/
'>> /etc/profile \
```
按 Ctrl+Shift+P ，选择 Go: Install/Update Tools, 选择 dlv, 点击 ok



