#!/bin/bash

#echo "Shell 传递参数实例！";
#echo "第一个参数为：$1";
#echo "参数个数为：$#";
#echo "传递的参数作为一个字符串显示：$*";

# mysql.docker容器重建的数据备份，手动填写数据库名
mm_array=("mysql" "ibdata1" "test")
ms_array=("mysql" "ibdata1" "test")

backup() {
  echo "-----备份工作开始执行-----"
  if [ ! -d /home/wwwroot/cluster/.db_backup/ ]; then
    mkdir /home/wwwroot/cluster/.db_backup/
  fi

  cd /home/wwwroot/cluster/.db_backup/
  echo "-----进入工作目录： -----"
  /usr/bin/pwd
  if [ ! -d mm/ ]; then
    mkdir mm/ ms/
  fi
  echo "处理 mm_array:"
  for i in ${mm_array[*]} ; do
      rm -rf mm/$i
      if [ -e ../mysql/data/$i ]; then
          echo "cp -r ../mysql/data/${i} mm/"
          cp -r ../mysql/data/$i mm/
      fi
  done
  #/usr/bin/tree
  echo "处理 ms_array:"
  for i in ${ms_array[*]} ; do
      rm -rf ms/$i
      if [ -e ../mysql_slave/data/$i ]; then
          echo "cp -r ../mysql_slave/data/${i} mm/"
          cp -r ../mysql_slave/data/$i mm/
      fi
  done
  #/usr/bin/tree
}

restore() {
  echo "-----还原工作开始...-----"
  cd /home/wwwroot/cluster/.db_backup/
  echo "-----进入工作目录： -----"
  /usr/bin/pwd

  echo "还原 mm_array:"
  for(( i=0;i<${#mm_array[@]};i++)) ; do
      if [ -e mm/$i ]; then
          echo "cp -rf mm/${i} ../mysql/data/"
          cp -rf mm/$i ../mysql/data/
      fi
  done
  echo "还原 ms_array:"
  for(( i=0;i<${#ms_array[@]};i++)) ; do
      if [ -e ms/$i ]; then
          echo "cp -rf ms/${i} ../mysql_slave/data/"
          cp -rf ms/$i ../mysql_slave/data/
      fi
  done
}

# default: re backup; restore
if [ "$1" == "restore" ]; then
  docker stop mm ms
  echo "start restore..."
  restore
  docker start mm ms
else
  #docker stop mm ms
  echo "start backup..."
  backup
  #docker start mm ms
  /usr/bin/tree
fi

echo "All Done"