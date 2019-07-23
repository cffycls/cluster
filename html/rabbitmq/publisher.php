<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/8
 * Time: 12:12
 */

date_default_timezone_set("Asia/Shanghai");
//配置信息
$conn_args = array(
    'host' => '172.1.12.13',
    'port' => '5672',
    'login' => 'root',
    'password' => '123456',
    'vhost'=>'/'
);
$k_route = 'k_route_1'; //路由key，用来绑定交换机和队列
$e_name = 'e_switches'; //交换机名称

//创建连接和channel
$conn = new AMQPConnection($conn_args);
if (!$conn->connect()) {
    die("Cannot connect to the broker!PHP_EOL");
}

$channel = new AMQPChannel($conn);
echo "<font color='red'>生产者</font>PHP_EOL已连接成功！准备发布信息...".PHP_EOL;

//创建交换机对象
$ex = new AMQPExchange($channel);
$ex->setName($e_name);
$ex->setType(AMQP_EX_TYPE_DIRECT); // 设置交换机类型
$ex->setFlags(AMQP_DURABLE); // 设置交换机是否持久化消息

//发送消息
$channel->startTransaction(); //开始事务
for($i=1; $i<=50000; ++$i){
    usleep(100);//休眠1秒
    $message = "消息数据".$i. ' '.date("Y-m-d H:i:s A"); //消息内容
    echo "消息发送返回：".$ex->publish($message, $k_route).PHP_EOL;
}
$channel->commitTransaction(); //提交事务

$conn->disconnect();
