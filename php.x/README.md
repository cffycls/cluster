# swoole debug
2019-06-26 14:09:01创建  
[info]  
swoole-tracker + sdbug(xdebug)  

### 1. swoole-tracker安装

https://github.com/hyperf/hyperf-docker

```
# download swoole tracker
ADD ./swoole-tracker-install.sh /tmp

RUN chmod +x /tmp/swoole-tracker-install.sh \
&& cd /tmp \
&& ./swoole-tracker-install.sh \
&& rm /tmp/swoole-tracker-install.sh \
# config php.ini手动
&& cp /tmp/swoole-tracker/swoole_tracker73.so /usr/local/php/lib/php/extensions/no-debug-non-zts-20180731/swoole_tracker.so \
# launch
&& printf '#!/bin/sh\n/opt/swoole/script/php/swoole_php /opt/swoole/node-agent/src/node.php' > /opt/swoole/entrypoint.sh \
&& chmod 755 /opt/swoole/entrypoint.sh
```

### 2. 配置docker启动

https://www.kancloud.cn/swoole-inc/ee-base-wiki/1214079#Agent_11

扩展中使用了默认权限不允许的系统调用，使用了docker默认seccomp配置不允许的系统调用，需要额外配置：

参考https://docs.docker.com/engine/security/seccomp/

对于权限配置，可以添加SYS_PTRACE cap，或者使用提升权限模式（不推荐）

对于seccomp，可以修改seccomp配置，或关闭seccomp配置（不推荐，这将导致docker内程序可以执行create_module，kexec_load等危险系统调用）

修改seccomp配置
修改seccomp配置文件（修改自默认文件)）:
```
--- a.json
+++ b.json
# 在.syscalls[0].names中加入"ptrace"，这将允许ptrace
@@ -359,7 +359,8 @@
                                "waitid",
                                "waitpid",
                                "write",
-                               "writev"
+                               "writev",
+                               "ptrace"
                        ],
                        "action": "SCMP_ACT_ALLOW",
                        "args": [],
# 如果你的docker较新，则它已经配置了ptrace在4.8以上内核可用
# 参考https://github.com/moby/moby/commit/1124543ca8071074a537a15db251af46a5189907
# 移除这段
@@ -369,18 +370,6 @@
                },
-                {
-                        "names": [
-                               "ptrace"
-                       ],
-                       "action": "SCMP_ACT_ALLOW",
-                       "args": null,
-                       "comment": "",
-                       "includes": {
-                               "minKernel": "4.8"
-                       },
-                       "excludes": {}
-               },
               {
                       "names": [
                                "personality"
                        ],
                        "action": "SCMP_ACT_ALLOW",
```
在docker run使用该seccomp并给予SYS_PTRACE权限：

```
docker run --other-arguments --cap-add=SYS_PTRACE --security-opt seccomp=/path/to/that/modified/profile.json ...
```
或docker-compose.yml中:
```
# 在docker-compose.yml中：
services:
  your-service:
    build:
      context: cgi-docker
      dockerfile: Dockerfile
    image: myphpfpm:1
    # 给予SYS_PTRACE权限
    cap_add:
      - "SYS_PTRACE"
    # 配置使用修改的seccomp
    security_opt:
      - "seccomp=/path/to/that/modified/profile.json"
```
这里使用 
```
--cap-add=SYS_PTRACE --security-opt seccomp=/home/wwwroot/cluster/php.x/config/profile.json
```
