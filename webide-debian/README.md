# 1.文件预先下载 
```shell script
 /tmp/bulid/python3/python', '-c', '\nimport runpy\nimport sys\nsys.path = [\'/tmp/tmpcacs1xc3/setuptools-49.2.1-py3-none-any.whl\', \'/tmp/tmpcacs1xc3/pip-20.2.3-py2.py3-none-any.whl\'] + sys.path\nsys.argv[1:] = [\'install\', \'--no-cache-dir\', \'--no-index\', \'--find-links\', \'/tmp/tmpcacs1xc3\', \'--root\', \'/\', \'--upgrade\', \'setuptools\', \'pip\']\nrunpy.run_module("pip", run_name="__main__", alter_sys=True)\n']' returned non-zero exit status 1. 
#11 379.6 make: *** [Makefile:1255: install] Error 1 
``` 
```shell script 
python -c \nimport runpy\nimport sys\nsys.path = [
    \'/tmp/tmpcacs1xc3/setuptools-49.2.1-py3-none-any.whl\', 
    \'/tmp/tmpcacs1xc3/pip-20.2.3-py2.py3-none-any.whl\'] + sys.path\nsys.argv[1:
] = 'install --no-cache-dir --no-index --find-links /tmp/tmpcacs1xc3 --root / --upgrade setuptools pip\']\nrunpy.run_module("pip", run_name="__main__", alter_sys=True)\n']' returned non-zero exit status 1. 
``` 

docker rm -f n3 && docker run  -itd --name n3 -p 8095:8080 cffycls/webide:node-java-python
docker exec -it njp bash
docker-compose build

# 2.构建测试

- shell/pyenv-installer.sh 更换了源
```shell script
USE_GIT_URI=1
```
- set -ex
```shell script
-e 脚本中的命令一旦运行失败就终止脚本的执行 -x 用于显示出命令与其执行结果(默认shell脚本中只显示执行结果)

```
- docker build 时出现no space left on device解决方法
查看并清理空间
```shell script
docker system df
docker system prune -a
```

# 3.hub.docker.com设置
```shell script

# 使用环境

- 示例映射目录：D:\workdir\MyProject  
export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;

# win10.powershell命令行
docker rm -f n3; docker run --name n3 -p 8080:8080 -v  D:\workdir\MyProject:\code -itd cffycls/webide-debian
docker rm -f g3; docker run -itd --name g3 -v ~/workdir/coder-server/code:/code -p 8080:8080 cffycls/webide-debian:go-php-python-v1.2
# -v ~/workdir/coder-server/user-home:/home/coder

```

# 4. git ssl问题
```shell script
# git_2.29.2测试
sudo apt-get -y install build-essential fakeroot dpkg-dev libcurl4-openssl-dev
sudo apt-get build-dep git -y
mkdir ~/git-openssl && cd ~/git-openssl
apt-get source git && mv *.orig.tar.xz git.tar.xz $GOROOT
tar -Jxvf git.tar.xz && mv git-* git && cd git
./configure --with-openssl 
sudo make && sudo make install 

```
给docker-desktop取消代理可用

/usr/local/bin/sshpass -p 123456 /usr/bin/rsync -aPur ~/Documents/workdir/my-github/cluster/webide-debian/* edz@edzdeiMac-3.local.:/Users/edz/workdir/webide-debian/
