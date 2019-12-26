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
    $channels = ['channel1', 'channel2', 'channel3'];

    swoole_timer_tick(1000, function () use ($redis, $channels) {
        $channel = $channels[array_rand($channels)];
        $news = [
            'time'=>date("Y-m-d H:i:s"),
            'document'=> "这是".date("Y-m-d", strtotime('+ 1 days'))."的新闻内容"
        ];

        $redis->publish($channel, json_encode($news, JSON_UNESCAPED_UNICODE));
        print_r("--发布成功：".$channel .PHP_EOL);
    });
});


