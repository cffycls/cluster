<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/9
 * Time: 7:58
 */
require "../vendor/autoload.php";

//从集群当中读取
$servers = ['172.1.50.11:6379', '172.1.50.12:6379', '172.1.50.13:6379'];
define('PROMOTION_KEY_PREFIX', 'promotionList_');
define('TIME_LIMIT_PREFIX', 'timeLimit_');

//每次购买请求的客户端工作--swoole常驻内存，缓存运行第一步
//一、初始化：查出所有节点分布，lPush、lRange函数准备，同服务端
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
            $host =explode(' ', $addr)[0];
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

//二、消费数据：模拟分散请求
/**
 * @param String $key 商品key
 * @param int $stock 库存
 */
$createQueue = function (String $key, int $stock) use (&$opt) {
    for ($i=0; $i<$stock; $i++){
        $opt('lPush', $key, $i);
    }
};
//第一个任务
go(function () use (&$opt, &$limit1, &$createQueue){
    $limit1 = [
        'goods_id'=>'9505900000',
    ];
    $createQueue(PROMOTION_KEY_PREFIX. $limit1['goods_id'], 20);
    $has = $opt('lLen', PROMOTION_KEY_PREFIX. $limit1['goods_id']);
    print_r('创建goods1 '. $has. ' 个'. PROMOTION_KEY_PREFIX. $limit1['goods_id'].PHP_EOL);
    $has = 0;
    swoole_timer_tick(10, function ($timer_id) use (&$opt, &$limit1, &$has){
        $now = $opt('lLen', PROMOTION_KEY_PREFIX. $limit1['goods_id']);
        if($has != $now) {
            $has = $now;
            if ($now) {
                print_r('goods1 还有个' . $has . '剩余' . PHP_EOL);
            } else {
                print_r('OK DONE1!'. PHP_EOL . PROMOTION_KEY_PREFIX . $limit1['goods_id'] . PHP_EOL);
                Swoole\Timer::clear($timer_id);
            }
        }
    });
});

//第二个任务：增加时段限制
go(function () use (&$opt, &$limit1, &$has, &$createQueue){
    $limit2 = [
        'goods_id'=>'2302500000',
        'start'=>date("Y-m-d H:i:s", strtotime('+ 1 minutes')),
        'end'=>date("Y-m-d H:i:s", strtotime('+ 5 minutes')),
    ];
    $createQueue(PROMOTION_KEY_PREFIX. $limit2['goods_id'], 500);
    //保存时间条件
    $opt('lPush', TIME_LIMIT_PREFIX. $limit2['goods_id'], json_encode($limit2, JSON_UNESCAPED_UNICODE));

    $has = $opt('lLen', PROMOTION_KEY_PREFIX. $limit2['goods_id']);
    print_r('创建goods2 '. $has. ' 个'. PROMOTION_KEY_PREFIX. $limit2['goods_id'].PHP_EOL);
    $has = 0;
    swoole_timer_tick(2000, function ($timer_id2) use (&$opt, &$limit2, &$has){
        $now = $opt('lLen', PROMOTION_KEY_PREFIX. $limit2['goods_id']);
        if($has != $now) {
            $has = $now;
            if ($now) {
                print_r('goods2 还有个' . $has . '剩余' . PHP_EOL);
            } else {
                print_r('OK DONE2!'. PHP_EOL . PROMOTION_KEY_PREFIX . $limit2['goods_id'] . PHP_EOL);
                Swoole\Timer::clear($timer_id2);
            }
        }
    });
});
