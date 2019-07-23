<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/6
 * Time: 9:57
 */
require "../vendor/autoload.php";

//从缓存当中读取，可以更新的，根据集群状态更新
$servers = ['172.1.50.11:6379', '172.1.50.12:6379', '172.1.50.13:6379'];
$rs = [];

//查出所有节点分布
$slotNodes = [];
foreach ($servers as $addr){
    $server=explode(':',$addr);
    try{
        $r = new Redis();
        $r->connect($server[0], (int) $server[1]);
        //单一节点可以看到所有存在槽的节点
        $slotInfo = $r->rawCommand('cluster','slots');
        //print_r($slotInfo);exit; 这里单个服务器可能有多个slot片段，所以引入$ix，+1与命令行显示分片序号相同
        foreach ($slotInfo as $ix => $value){
            $slotNodes[$value[2][0].':'.$value[2][1].' '.($ix+1)]=[$value[0], $value[1]];
        }
        break;
    }catch (\RedisException $e){
        echo $e->getMessage(). ': '. $addr;
        continue;
    }
}
//宕机引发节点主从关系变化
foreach ($slotNodes as $addr => $value){
    $host =explode(' ', $addr)[0];
    if(!isset($rs[$host])){
        $server = explode(':', $host);
        $r = new Redis();
        $r->connect($server[0], (int) $server[1]);
        $rs[$host] = $r;
    }
}
echo '<pre>';
//print_r($rs);

function getValue($rs, $key){
    foreach ($rs as $ss => $r){
        try{
            $v = $r->get($key);
            //echo $ss. ' 得到：'.$key.'='.$v.'<br/>';
            return $v;
        }catch (\RedisException $e){
            //print_r("----- {$key}-{$ss}获取错误跳过：".$e->getMessage(). '<br/>');
            continue;
        }
    }
}

function setValue($rs, $key, $value){
    foreach ($rs as $addr => $r){
        try{
            echo "+++++ {$key}-{$addr}".'设置： '.$key. '<br/>';
            return $r->set($key, $value);
        }catch (\RedisException $e){
            //print_r("+++++ {$key}-{$addr}设置错误跳过：".$e->getMessage(). '<br/>');
            continue;
        }
    }
}


for($i=0; $i<20000; $i++){
    $key = 'set-'.$i;
    if(getValue($rs, $key)) {
        continue;
    }else{
        setValue($rs, $key, md5(time().$i));
    }
}



foreach ($rs as $r){
    $r->close();
}
