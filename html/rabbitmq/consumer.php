<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/8
 * Time: 12:50
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
$q_name = 'q_queue'; //队列名

//创建连接和channel
$conn = new AMQPConnection($conn_args);
if (!$conn->connect()) {
    die("Cannot connect to the broker!\n");
}
$channel = new AMQPChannel($conn);
echo "<font color='red'>消费者</font>:".PHP_EOL ."已连接成功！准备接收信息...".PHP_EOL;

//创建交换机
$ex = new AMQPExchange($channel);
$ex->setName($e_name);
//direct类型：[AMQP_EX_TYPE_DIRECT,AMQP_EX_TYPE_FANOUT, AMQP_EX_TYPE_HEADERS or AMQP_EX_TYPE_TOPIC]
$ex->setType(AMQP_EX_TYPE_DIRECT);
$ex->setFlags(AMQP_DURABLE); //持久化

//创建队列
$q = new AMQPQueue($channel);
$q->setName($q_name);
$q->setFlags(AMQP_DURABLE); //持久化
$q->declareQueue();

//绑定交换机与队列，并指定路由键
$q->bind($e_name, $k_route);

//阻塞模式接收消息
echo "阻塞模式接收消息:".PHP_EOL;
while(True){
    $q->consume(function ($envelope, $queue) {
        $msg = $envelope->getBody();
        echo '收到：'. $msg.PHP_EOL; //处理消息
        sleep(1);//休眠1秒

    }, AMQP_AUTOACK); //ACK应答
}
$conn->disconnect();

