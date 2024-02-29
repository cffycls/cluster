<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/6
 * Time: 9:57
 */
require "../vendor/autoload.php";

//从缓存当中读取，可以更新的，根据集群状态更新
$servers = ['172.1.50.11:6379', '172.1.50.12:6379', '172.1.50.13:6379',
    '172.1.30.11:6379', '172.1.30.12:6379', '172.1.30.13:6379'];
$rs = [];

//查出所有节点分布
$slotNodes = [];
foreach ($servers as $addr){
    $server=explode(':',$addr);
    try{
        $r = new Redis();
        $r->connect($server[0], (int) $server[1], 0.2);
        //单一节点可以看到所有存在槽的节点
        $slotInfo = $r->rawCommand('cluster','slots');
        //print_r($slotInfo);exit; 这里单个服务器可能有多个slot片段，所以引入$ix，+1与命令行显示分片序号相同
        foreach ($slotInfo as $ix => $value){
            $slotNodes[$value[2][0].':'.$value[2][1].' '.($ix+1)]=[$value[0], $value[1]];
        }
        $rs[$addr] = $r;
        //节点分片分槽信息
        foreach ($slotNodes as $slot => $value){
            $addr = explode(' ', $slot)[0];
            if(!isset($rs[$addr])){
                $server = explode(':', $addr);
                $r = new Redis();
                $r->connect($server[0], (int) $server[1]);
                $rs[$addr] = $r;
            }
        }
        break;
    }catch (\RedisException $e){
        echo $e->getMessage(). ': '. $addr;
        continue;
    }
}
echo '<pre>';
//print_r($rs);

//计算，测试批量查询
$crc = new \Predis\Cluster\Hash\CRC16();
$getAddr = function ($key) use (&$slotNodes, &$crc, &$rs) {
    $code = $crc->hash($key) % 16384;
    //echo ($key).' -- '. ($code).'<br/>';
    foreach ($slotNodes as $addr => $boundry){
        if( $code>=$boundry[0] && $code<=$boundry[1] ){
            $host =explode(' ', $addr)[0];
            //print_r(['OK: '. $addr => $boundry, $host, $rs]);
            return $addr. ' = '. $rs[$host]->get($key);
        }else{
            //print_r([$addr => $boundry]);
        }
    }
};

$result=[];
for($i=10; $i<30; $i++){
    $key = 'set-'.$i;
    $result[$key] = $getAddr($key);
}
print_r($result);


foreach ($rs as $r){
    $r->close();
}

