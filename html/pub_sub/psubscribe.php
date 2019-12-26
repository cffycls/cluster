<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/13
 * Time: 7:54
 */

go(function (){

    $redis = new Swoole\Coroutine\Redis();
    $redis->connect('172.1.13.11', 6379);
    $redis->auth('123456');
    function counter (){
        $c = 1; //准备静态化
        return function () use (&$c) { return $c++; };
    }
    $counter = counter();

    if ($redis->subscribe(['channel1', 'channel2', 'channel3'])) { // 或者使用psubscribe

        while ($msg = $redis->recv()) {
            // msg是一个数组, 包含以下信息
            // $type # 返回值的类型：显示订阅成功
            // $name # 订阅的频道名字 或 来源频道名字
            // $info  # 目前已订阅的频道数量 或 信息内容
            list($type, $name, $info) = $msg;

            if ($type == 'subscribe'){ // 或psubscribe
                // 频道订阅成功消息，订阅几个频道就有几条：首次连接
                var_dump("频道订阅成功消息 ", $msg);
            } else if ($type == 'unsubscribe' && $info == 0) { // 或punsubscribe
                break; // 收到取消订阅消息，并且剩余订阅的频道数为0，不再接收，结束循环
            } else if ($type == 'message') { // 若为psubscribe，此处为pmessage
                $rev_times = $counter();
                //标记退订
                // 打印来源频道名字、消息
                print_r( ['rev_times'=>$rev_times, 'name'=>$name, 'info'=>$info] );
                // 处理消息
                // balabalaba....

                if ($rev_times%10==0){ // 每20个退订一个channel
                    $status = $redis->unsubscribe($msg); // 继续recv等待退订完成
                    var_dump("准备退订 $name", $status);
                }
            }
        }
    }
});