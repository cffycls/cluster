<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/8
 * Time: 17:19
 */
//swoole官方 https://wiki.swoole.com/wiki/page/292.html

$table = new Swoole\Table(1024); //$size参数指定表格的最大行数，必须为2的指数，如1024,8192,65536等
$table->column('fd', swoole_table::TYPE_INT);
$table->column('from_id', swoole_table::TYPE_INT);
$table->column('data', swoole_table::TYPE_STRING, 1024);
$table->create();

$serv = new Swoole\Server('127.0.0.1', 9501, SWOOLE_BASE, SWOOLE_SOCK_TCP);
//将table保存在serv对象上
$serv->table = $table;

$serv->on('receive', function ($serv, $fd, $from_id, $data) {
    $pre = substr($data, 0, 1);
    $data = substr($data, 1);
    if($pre == \Swoole\Table::TYPE_STRING){
        /*
        foreach ($serv->table as $row) var_dump($row);
        print_r($serv->table);
        */
        $table = [];
        foreach ($serv->table as $k => $row) {
            $row['key'] = $k;
            $table[] = $row;
        }
        $count = count($serv->table);
        print_r("当前表行数". $count);
        $serv->send($fd, json_encode($table, JSON_UNESCAPED_UNICODE));
    }elseif($pre == \Swoole\Table::TYPE_FLOAT){
        $key = $data;
        $exist = $serv->table->exist($key);
        if($exist){
            $row = $serv->table->get($key);
            $exist = $serv->table->del($key);
            $data = json_decode($row['data'], true);
            $serv->send($fd, "消费：" .($exist===true?'true':'false'). ' '. $data['order'].PHP_EOL);
        }
    }elseif($pre == \Swoole\Table::TYPE_INT){
        $ret = $serv->table->set($fd, array('from_id' => $from_id, 'data' => $data, 'fd' => $fd));
        $data = json_decode($data, true);
        $serv->send($fd, "服务器：". ($ret===true?'true':'false'). " from ".$fd.' order：'.$data['order']);
    }else{
        print_r($data);
        $serv->send($fd, 'OTHERS');
    }
});

$serv->start();