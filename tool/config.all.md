环境IP配置
====
### 数据库类: 11.xx-13.xx
----
mysql:
```markdown
[rec.mysql.sh: ] mm ms [主从]
172.1.11.11-172.1.11.12 [default]3306 [外]3308
root//123456
```

mongodb:
```markdown
[rec.mongo.sh: ]
mg1 mg2 mg3
172.1.12.11-172.1.12.12-172.1.12.13 [default]27017
root//123456
```

redis:
```markdown
[rec.redis.sh: ] rm rs [主从]
172.1.13.11-172.1.13.12 [default]6379
//[无]
[cluster_redis/cluster.sh: ]
clm31 clm32 clm33 cls51 cls52 cls53 [3+3集群主从] [default]6379
172.1.30.11-172.1.50.11
172.1.30.12-172.1.50.12
172.1.30.13-172.1.50.13
//[无]
```

### 服务管理类: 111.xx
----
consul:
```markdown
[consul/rec.sh: ]
consul-s1
172.1.111.111 [default]8500 [外]8500
```

### 单机服务类: 1.xx-2.xx
----
php:
```markdown
[rec.php.sh: ] cffycls/php
172.1.1.11
172.1.1.12
172.1.1.13
[无: sdebug+swoole-tracker] cffycls/php:debug
172.1.1.14
```

nginx:
```markdown
[rec.nginx.sh: ]
172.1.2.11 [default]80 [外]8080
172.1.2.12 [default]80 [外]8082
[ngx_lua_waf/waf.sh: ]
172.1.2.13 [default]80 [外]-p 8084:80 -p 8085:443 -p 9500:9500
```
