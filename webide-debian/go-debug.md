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
- 初始化
```shell script
# init.sh
#!/bin/bash

mkdir -p $HOME/.go
export GOBIN=/usr/local/go/bin/
export GOPATH=$HOME/.go
export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/

go get -u github.com/derekparker/delve/cmd/dlv
```

