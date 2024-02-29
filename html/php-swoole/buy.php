<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/9
 * Time: 10:18
 */

require "../vendor/autoload.php";

//从集群当中读取
define('PROMOTION_KEY_PREFIX', 'promotionList_');
define('TIME_LIMIT_PREFIX', 'timeLimit_');

$goods1 = '9505900000';
$goods2 = '2302500000';

//每次购买请求的客户端工作--添加到缓存
$servers = ['172.1.50.11:6379', '172.1.50.12:6379', '172.1.50.13:6379'];
$redisServers = [];
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
    if(!isset($redisServers[$host])){
        $server = explode(':', $host);
        $r = new Redis();
        $r->connect($server[0], (int) $server[1]);
        $redisServers[$host] = $r;
    }
}
$crc = new \Predis\Cluster\Hash\CRC16();
//注意method=lRange时args传参是（$key, $start, $end）
$opt = function ($method, $key, ...$args) use (&$redisServers, &$slotNodes, &$crc) {
    $code = $crc->hash($key) % 16384;
    foreach ($slotNodes as $addr => $boundry){
        if( $code>=$boundry[0] && $code<=$boundry[1] ){
            $host = explode(' ', $addr)[0];

            if(empty($args)){
                return $redisServers[$host]->$method($key);
            }elseif(count($args)==1){
                return $redisServers[$host]->$method($key, $args[0]);
            }else{ //...
                return $redisServers[$host]->$method($key, $args);
            }
        }
    }
};

//无限制：100人抢 -- goods1=20个
go(function () use (&$opt, &$limit1, &$has, &$createQueue, $goods1){
    $cart = [];
    $cart['key'] = PROMOTION_KEY_PREFIX. $goods1;
    for ($i=0; $i<100; $i++) {
        $cart['user'] = 'tom'.$i;
        go(function () use($cart, &$opt){
            co::sleep(mt_rand(1,500)*0.001); //增加redis网络连接耗时
            $state = $opt('lPop', $cart['key']);
            if($state){
                print_r($cart['user'] .' 购买成功！' .PHP_EOL);
                return true;
            }else{
                //print_r('--已被抢光 ' .$cart['user'] .PHP_EOL);
                print_r('*');
                return false;
            }
        });
    }
});
//时段限制：10000人抢 -- goods2=500个
go(function () use (&$opt, &$limit1, &$has, &$createQueue, $goods2){
    $cart = [];
    $cart['key'] = PROMOTION_KEY_PREFIX. $goods2;
    //获取时间条件
    $limit2 = json_decode($opt('lIndex', TIME_LIMIT_PREFIX. $goods2, 0), true);
    for ($i=0; $i<10000; $i++) {
        $cart['user'] = 'jack'.$i;
        go(function () use($cart, &$opt, &$limit2){
            $min = strtotime($limit2['start']);
            $max = strtotime($limit2['end']);
            co::sleep(mt_rand(2,6*60)); //请求分散 2-5min

            $cur = time();
            if($cur<$min){
                print_r('--尚未开始 ' .$cart['user'] .PHP_EOL);
                return true;
            }elseif($min<=$cur && $cur<=$max){
                co::sleep(mt_rand(100,500)*0.001); //增加redis网络连接耗时
                $state = $opt('lPop', $cart['key']);
                if($state){
                    echo $cart['user'] .' 购买成功！' .PHP_EOL;
                    return true;
                }else{
                    echo '.';
                    //echo '++已被抢光 ' .$cart['user'] .json_encode([$limit2,date('Y-m-d H:i:s',$cur)], JSON_UNESCAPED_UNICODE) .PHP_EOL;
                    return false;
                }
            }else{
                echo '++已被抢光 ' .$cart['user'] .json_encode([$limit2,date('Y-m-d H:i:s',$cur)], JSON_UNESCAPED_UNICODE) .PHP_EOL;
                return false;
            }
        });
    }
});
