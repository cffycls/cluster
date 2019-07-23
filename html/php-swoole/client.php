<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/8
 * Time: 18:08
 */


for($i=1; $i<=50; $i++){
    go(function () use($i) {
        $client = new \Swoole\Client(SWOOLE_SOCK_TCP);
        usleep(mt_rand(10,1000));
        $res = $client->connect('127.0.0.1', 9501, 0.5);
        if (!$res) {
            exit("connect failed. Error: {$client->errCode}\n");
        }

        echo "客户端：". $i. PHP_EOL;
        $data = ['order'=>$i, 'data'=>md5(mt_rand(10,1000).time())];
        echo \Swoole\Table::TYPE_INT. json_encode($data, JSON_UNESCAPED_UNICODE). PHP_EOL;
        $client->send(\Swoole\Table::TYPE_INT. json_encode($data, JSON_UNESCAPED_UNICODE));
        //echo $client->recv(). PHP_EOL;
        $client->close();
    });
}

$client = new \Swoole\Client(SWOOLE_SOCK_TCP);
$res = $client->connect('127.0.0.1', 9501, 0.5);
if (!$res) {
    exit("connect failed. Error: {$client->errCode}\n");
}
$client->send(\Swoole\Table::TYPE_STRING. "GET_TABLE_INFO");
$table = $client->recv();
$client->close();

$table = json_decode($table, true);
while($row = array_pop($table)){
    go(function () use($row) {
        $client = new \Swoole\Client(SWOOLE_SOCK_TCP);
        usleep(mt_rand(10,1000));
        $res = $client->connect('127.0.0.1', 9501, 0.5);
        if (!$res) {
            exit("connect failed. Error: {$client->errCode}\n");
        }
        
        echo "处理{$row['fd']}发来的{$row['data']}". PHP_EOL;
        $client->send(\Swoole\Table::TYPE_FLOAT. $row['key']);
        $client->close();
    });
}