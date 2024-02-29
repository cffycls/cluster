#### [【实用指南】win10、linux文件共享服务（完备）](https://segmentfault.com/a/1190000022383656)


1、Samba链接【Client_Linux】
----
### a.查看共享目录列表
smbclient //192.168.1.100/WorkPlace -U cffyc
### b.手动挂载
mount -t cifs //192.168.1.100/WorkPlace/wwwroot/ /home/wwwroot/ -o username=cffyc,password=<passwd>,uid=1000,gid=1000,nounix,iocharset=utf8,dir_mode=0777,file_mode=0777
### c. 开机挂载
cat /etc/fstab:
//192.168.1.100/WorkPlace/wwwroot/ /home/remote/ cifs defaults,credentials=/etc/samba/credentials,uid=1000,gid=1000   	0 	0
cat /etc/samba/credentials:
username=cffyc
password=<passwd>
iocharset=utf8 

2、rsync设置
----
由于虚拟机使用Samba远程时IDE的频繁刷新，使得磁盘性能紧张，所以，需要对映射目录进行改造。  
目标：  
Linux本机编辑时，使用自身硬盘目录A，对映射的Samba客户端目录B'进行主动rsync同步，主机目录为B。
### a.首先：文件准备
Client_Linux：拷贝挂载文件到本机目录，解除旧挂载，目录还原为本地文件
```
cp -rp /home/wwwroot /home/remote
//查看挂载
df -h
//-l在该目录空闲后再umount，-v显示详情
umount -l /home/wwwroot 
mv /home/remote /home/wwwroot
```
### b.其次：重新挂载到根目录
```
vim /etc/fstab:
//192.168.1.100/WorkPlace/ /WorkPlace/ cifs defaults,credentials=/etc/samba/credentials,uid=1000,gid=1000   	0 	0
mkdir /WorkPlace/
mount -a
df -h
```
### c.然后：本机rsync主动同步【备份】
```
rsync -azvr /home/wwwroot/ --delete --exclude='*.git/' --exclude='*.idea/' /WorkPlace/wwwroot/
```

2、rsync同步
----
同步脚本inotify.sh:
``` 
# rsync -h
# -a, ––archive		归档模式，表示以递归方式传输文件，并保持所有文件属性
# -v, ––verbose		详细输出模式
# -z, ––compress	    在传输文件时进行压缩处理
# -c, --checksum    基于校验跳过，而不是模式时间和大小
# -R, --relative    使用相对路径名
# -C, --cvs-exclude  动忽略文件的方式与CVS相同

# inotifywait -h
# -m|--monitor	     保持对事件的关注
# -t|--timeout	     强制超时时间
# -r|--recursive	     递归地观察目录
# -q|--quiet    	     少打印(仅打印事件)

ignore=$(echo $(find . -name '.idea' | awk '{print $1}') | sed 's/\s\+/\/|/g')
excludeStr="*~|*~.swap|${ignore}" 
excludeStr=".*,*~" 
```
文件略，【.idea/】结尾过滤。
