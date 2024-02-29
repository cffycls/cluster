<?php
/**
 * Created by PhpStorm.
 * User: cffyc
 * Date: 2019/7/7
 * Time: 15:23
 */

session_start();
echo '<pre>';

if(empty($_SESSION['testArray'])){
    echo print_r('设置session数组<br/>');
    $_SESSION['testArray'] = ['name' => 'cffycls', 'setTime' => date("Y-m-d H:i:s")];
}
print_r($_SESSION);

//连接redis
$redis = new redis();
try{
    $redis->connect('172.1.13.11', 6379);
    $redis->auth('123456');
}catch (\RedisException $e){
    echo $e->getMessage(). ': '. $addr;
    try{
        $redis->connect('172.1.13.12', 6379);
        $redis->auth('123456');
    }catch (\RedisException $e){
        echo $e->getMessage(). ': '. $addr;
    }
}

$redis_save = $redis->get('PHPREDIS_SESSION:' . session_id());
print_r($redis_save);
print_r(json_decode($redis_save));

$serverInfo = [
    'gethostbyname'=>gethostbyname(gethostname().'.'),
    'REQUEST_TIME'=>date("Y-m-d H:i:s", $_SERVER['REQUEST_TIME']),
    'HTTP_COOKIE'=>$_SERVER['HTTP_COOKIE'],
    'HTTP_HOST'=>$_SERVER['HTTP_HOST'],
    'SERVER_SOFTWARE'=>$_SERVER['SERVER_SOFTWARE'],
    'SERVER_ADDR'=>$_SERVER['SERVER_ADDR'],
    'SERVER_PORT'=>$_SERVER['SERVER_PORT'],
    'REMOTE_ADDR'=>$_SERVER['REMOTE_ADDR'],
    'REMOTE_PORT'=>$_SERVER['REMOTE_PORT'],
    //'$_SERVER'=>$_SERVER,
];
$data = array_merge_recursive(['session_id'=>session_id()], $serverInfo);
print_r($data);

