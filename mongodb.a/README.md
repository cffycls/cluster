MongoDB
====

基本的角色  
----
```markdown
1.数据库用户角色：read、readWrite;  
2.数据库管理角色：dbAdmin、dbOwner、userAdmin；  
3.集群管理角色：clusterAdmin、clusterManager、clusterMonitor、hostManager；  
4.备份恢复角色：backup、restore；  
5.所有数据库角色：readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase  
6.超级用户角色：root   
//这里还有几个角色间接或直接提供了系统超级用户的访问（dbOwner 、userAdmin、userAdminAnyDatabase）  
  
```
其中MongoDB默认是没有开启用户认证的，也就是说游客也拥有超级管理员的权限。userAdminAnyDatabase：有分配角色和用户的权限，但没有查写的权限  
  
#1. 创建用户  
# 增  
db.createUser({ user: "root", pwd: "123456", roles: [ {role:"userAdminAnyDatabase", db:"admin"} ] })  
# 删  
db.system.users.remove({user:"root"})  
# 查   db.system.users.find() 用户表信息  
> use admin  
switched to db admin  
> db.system.users.find()  
{ "_id" : "test.root", "userId" : UUID("b7339a90-c161-4873-8f1c-afe3056ddaa2"), "user" : "root", "db" : "test", "credentials" : { "SCRAM-SHA-1" : { "iterationCount" : 10000, "salt" : "u6O113zukVQFyJ5zwAqUeQ==", "storedKey" : "zfJddDA3VYJgdWzzpjOuO9hbvMg=", "serverKey" : "5ZhI/II2h+xMfeWKH0j5hf58Kb8=" }, "SCRAM-SHA-256" : { "iterationCount" : 15000, "salt" : "JI6/UATwgc+ggwt1bcECO94uqpC1OQLgevKL2Q==", "storedKey" : "hP8Yct9DLXA59Kh8VHNpjwHs1fQRI/Jk/dKMo35PmvU=", "serverKey" : "CtCm9aXKBVjIUTOMCV4E9V1KnEt6CIybhxyUdpJ7mnE=" } }, "roles" : [ { "role" : "userAdminAnyDatabase", "db" : "admin" } ] }  
  
#2. 鉴权  
> db.auth('root','123456')  
1  
  
#3. 帮助文档！！！  
> help  


